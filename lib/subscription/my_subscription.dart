import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';
import 'package:hilinky_test/subscription/plan.dart';

class my_subscription extends StatefulWidget {
  const my_subscription({super.key});

  @override
  State<my_subscription> createState() => _my_subscriptionState();
}

class _my_subscriptionState extends State<my_subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "You have not subscribed to the premium package yet",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              context.pushPage(const plan());
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
              'Subscribe Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
