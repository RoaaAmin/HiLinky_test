import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hilinky_test/Profile/profile.dart';
import 'package:hilinky_test/components/context.dart';

import 'image_picker.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  EditState createState() {
    return EditState();
  }
}

class EditState extends State<Edit> {
  imagePicker controller = Get.put(imagePicker());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dynamic myImage = const AssetImage("assets/images/avatary.png");
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
       leading: IconButton(
                onPressed: () {
                  context.pushPage( profiletest());
                },
                icon: const Icon(Icons.arrow_back_ios)

          ),

           

          
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: controller.imagePath.isNotEmpty
                    ? FileImage(
                        File(controller.imagePath.toString()),
                      )
                    : myImage,
              ),

              TextButton(
                  onPressed: () async {
                    await controller.getImage();
                    setState(() {});
                  },
                  child: const Text("Pick Image")),

              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("First Name"),

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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      //  hintText: 'name',
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
                    const SizedBox(
                      height: 90,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
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
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),

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
                     TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Nationality"),

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

                      TextFormField(
                      decoration: const InputDecoration(
                        label: Text("City"),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      cursorColor: Colors.black,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              // const location(),

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
                    context.pushPage( profiletest());
                  }
                },
                style: ElevatedButton.styleFrom(
                  // shape: const (),
                  padding: const EdgeInsets.all(5),
                  backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                  fixedSize: const Size(150, 40),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}

