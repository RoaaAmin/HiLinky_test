import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    dynamic myImage = const AssetImage("assets/images/HilinkyLogo.png");
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          // leading: TextButton(
          //   onPressed: () {
          //     context.pop();
          // },
          // child: const Icon(Icons.arrow_back_ios),
          // ),
          title: const Text("Edit My Information"),
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

              CircleAvatar(
                radius: 50,
                backgroundImage: myImage,
              ),

              // Image(image: FileImage(File(controller.imagePath.toString()),) ) ,

// CachedNetworkImage(
//         imageUrl: "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcRRv9ICxXjK-LVFv-lKRId6gB45BFoNCLsZ4dk7bZpYGblPLPG-9aYss0Z0wt2PmWDb",
//         placeholder: (context, url) => CircularProgressIndicator(),
//         errorWidget: (context, url, error) => Icon(Icons.error),
//      ),
              TextButton(
                  onPressed: () async {
                    await controller.getImage();
                    setState(() {});
                   
                  },
                  child: const Icon(Icons.add)),

              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        //  style: BorderRadius.circular(B) ,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          // labelText: 'Name',
                          hintText: 'name',
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
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          // labelText: 'Name',
                          hintText: 'Bio',
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
                        hintText: 'City',
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
                          "Contact",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // labelText: 'Name',
                        hintText: 'Email',
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
                        hintText: 'Whatsapp',
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // labelText: 'Name',
                        hintText: 'Gender',
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
                        hintText: 'Age',
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
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
