
import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';
import 'package:hilinky_test/createCard/choose_design.dart';

class create extends StatefulWidget {
    create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.amberAccent,
        body: Padding(
          padding:    EdgeInsets.all(20.0),
          child: ListView(
            children: [
          
                  Text(
                "Create Card",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
                  SizedBox(
                height: 5,
              ),
                  Text("Fill the information to display it in your card."),

              Form(
                key: _formKey,
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                        SizedBox(
                      height: 90,
                    ),
                        Text(
                      "Personal Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                
                      Text('Prefix (optional)'),
                    TextFormField(
                      decoration:   const  InputDecoration(
                      //  labelText: 'Prefix (optional)',
                        hintText: 'Mr.',
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
                
                
                    const  Text('First Name'),
                        TextFormField(
                     decoration:  const   InputDecoration(
                      // labelText: 'First Name',
                       hintText: 'Your first name',
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
                
                
                
                    const Text( 'Middle name (optional)'),
                        TextFormField(
                    decoration:     InputDecoration(
                       //labelText: 'Middle name (optional)',
                      hintText: 'Your middle name',
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
                
                
                
                
                      const  Text( 'Last Name'),
                     TextFormField(
                      decoration:     InputDecoration(
                        // labelText: 'Last Name',
                        hintText: 'Your last name',
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
                
                
                
                
                     
                     
                     
                      const  Text( "Position"),
                     TextFormField(
                      decoration:    InputDecoration(
                       //  labelText: 'Position',
                        hintText: 'Your Position',
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
                
                
                    const  Text( "Company Name (Optional)"),
                    TextFormField(
                      decoration:    InputDecoration(
                       //  labelText: 'Company Name (Optional)',
                        hintText: 'Your Company Name',
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
                
                    
                    
                    const  Text( "Email"),
                        TextFormField(
                     decoration:    InputDecoration(
                        labelText: 'Email',
                       hintText: 'Your Email',
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
                
                
                    
                    
                    const Text( "Phone Number"),
                        TextFormField(
                    decoration:     InputDecoration(
                      // labelText: 'Phone Number',
                      hintText: 'Your Phone Number',
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
                      height: 90,
                    ),
                  ],
                ),
              ),
              //   location(),
              ElevatedButton(
                onPressed: () {
                  //    Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    //   If the form is valid, display a snackbar. In the real world,
                    //   you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                    );
                    context.pushPage(  chooseDesign());
                  }
                },
                 style: ElevatedButton.styleFrom(
                // shape:   (),
                padding:     EdgeInsets.all(5),
                backgroundColor:     Color.fromARGB(255, 2, 84, 86),
                fixedSize:     Size(150, 40),
                elevation: 0,
              ),
                child:     Text('Continue ' , style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ));
  }
}
