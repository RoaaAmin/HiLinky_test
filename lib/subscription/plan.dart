import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:hilinky_test/components/context.dart';

import 'cancel.dart';

class plan extends StatefulWidget {
  const plan({super.key});

  @override
  State<plan> createState() => _planState();
}

class _planState extends State<plan> {
  Map<dynamic, dynamic> billing = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Subscription"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Plan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckout(
                    sandboxMode: true,
                    clientId:
                        "AUi7DZVOct26Q_gsZEd_mgvvDTQ4a2SjzOM4AtIelr6OyAQnIBT0MjUI5_rD88LTgxIDRjOEsLq4QGZN",
                    secretKey:
                        "EDs0U2atywgg-KCGcaI_ga4YtX-BHx9mccqE_NrDkf50r4HoUo9Q4is2gHXOpxLvnCR_wHRmnPGcAxGp",
                    returnURL: "success.snippetcoder.com",
                    cancelURL: "cancel.snippetcoder.com",
                    transactions: const [
                      {
                        "amount": {
                          "total": '20',
                          "currency": "USD",
                          "details": {
                            "subtotal": '20',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        "item_list": {
                          "items": [
                            {
                              "name": "Premium",
                              "quantity": 1,
                              "price": '20',
                              "currency": "USD"
                            },
                          ],
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      print("onSuccess: $params");
                      setState(() {
                        billing.addAll(params);
                      });
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'premium': true});
                    },
                    onError: (error) {
                      print("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      print('cancelled:');
                    },
                  ),
                ));
              },
              child: const SizedBox(
                height: 120,
                width: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  elevation: 3,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Yearly",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Start date : 15 - 11 -2020",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "Start date : 15 - 11 -2020",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Billing information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            billing.isEmpty
                ? SizedBox(
                    child: SizedBox(
                      height: 100,
                      width: 400,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        elevation: 3,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Text('no billing'),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 100,
                    width: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      elevation: 3,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Name : ${billing['data']['payer']['payer_info']['first_name']}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Start date : 15 - 11 -2020",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Amount: ${billing['data']['transactions'][0]['amount']['total'].toString()}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                context.pushPage(const cancel());
              },
              style: ElevatedButton.styleFrom(
                // shape: const (),
                padding: const EdgeInsets.all(5),
                backgroundColor: Colors.orange,
                //const Color.fromARGB(255, 2, 84, 86),
                fixedSize: const Size(200, 40),
                elevation: 0,
              ),
              //  style: const ButtonStyle( B elevation: 0.2, ),
              child: const Text(
                'here dialog',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
