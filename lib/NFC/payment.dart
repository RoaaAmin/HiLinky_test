import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';

import 'cardy.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  paymentState createState() {
    return paymentState();
  }
}

class paymentState extends State<payment> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey,
            elevation: 0,
            // leading: TextButton(
            //   onPressed: () {
            //     context.pop();
            // },
            // child: const Icon(Icons.arrow_back_ios),
            // ),
            title: const Row(
              children: [
                Icon(Icons.circle),
                Icon(
                  Icons.linear_scale,
                  size: 100,
                )
              ],
            )
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       context.pop();
            //     },
            //     child: const Text("Done", style: TextStyle(fontSize: 12)),
            //   ),
            // ],
            ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // CircleAvatar(
              //   radius: 90,
              //   backgroundImage: controller.imagePath.isNotEmpty
              //       ? FileImage(
              //           File(controller.imagePath.toString()),
              //         )
              //       : myImage,
              // ),

              // Image(image: FileImage(File(controller.imagePath.toString()),) ) ,

// CachedNetworkImage(
//         imageUrl: "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcRRv9ICxXjK-LVFv-lKRId6gB45BFoNCLsZ4dk7bZpYGblPLPG-9aYss0Z0wt2PmWDb",
//         placeholder: (context, url) => CircularProgressIndicator(),
//         errorWidget: (context, url, error) => Icon(Icons.error),
//      ),

              const Text(
                "Order NFC card Three ",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("Fill the information to order your NFC card."),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    const Text(
                      "Personal information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // labelText: 'Name',
                        hintText: 'Country',
                      ),
                      //   autofillHints:,
                      cursorColor: Colors.black,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // labelText: 'Name',
                        hintText: 'Country',
                      ),
                      //   autofillHints:,
                      cursorColor: Colors.black,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // labelText: 'Name',
                        hintText: 'Phone',
                      ),
                      //   autofillHints:,
                      cursorColor: Colors.black,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ),
              // const location(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //    Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      //   If the form is valid, display a snackbar. In the real world,
                      //   you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      context.pushPage(cardy());
                    }
                  },
                  child: const Text('Complete Order'),
                ),
              ),
            ],
          ),
        ));
  }
}