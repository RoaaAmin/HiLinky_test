
import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';

import '../profile.dart';

class changePass extends StatefulWidget {
  const changePass({super.key});

  @override
  changePassState createState() {
    return changePassState();
  }
}

class changePassState extends State<changePass> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          leading: IconButton(
              onPressed: () {
                 context.pushPage(profiletest());
              
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 100, bottom: 100, left: 10, right: 10),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Old Password"),

                        // hintText: 'name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        hintText: 'name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        // hintText: 'name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              // const location(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pushPage(profiletest());
                    },
                    style: ElevatedButton.styleFrom(
                      // shape: const (),

                      padding: const EdgeInsets.all(5),

                      backgroundColor: Colors.white,

                      fixedSize: const Size(161, 59),

                      elevation: 1,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 84, 86),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //    Validate returns true if the form is valid, or false otherwise.

                      if (_formKey.currentState!.validate()) {
                        //   If the form is valid, display a snackbar. In the real world,

                        //   you'd often call a server or save the information in a database.

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Your Information Has Been Saved Successfully'),
                            backgroundColor: Color.fromARGB(255, 149, 181, 236),
                          ),
                        );

                        context.pushPage(profiletest());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      // shape: const (),

                      padding: const EdgeInsets.all(5),

                      backgroundColor: const Color.fromARGB(255, 2, 84, 86),

                      fixedSize: const Size(161, 59),

                      elevation: 1,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

