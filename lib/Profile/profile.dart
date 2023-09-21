import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:hilinky_test/screens/login_screen.dart';

import 'activity.dart';
import 'edit.dart';
import 'notifications.dart';

class profiletest extends StatefulWidget {
  const profiletest({super.key});

  @override
  profiletestState createState() {
    return profiletestState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class profiletestState extends State<profiletest> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<profiletestState>.
  final _formKey = GlobalKey<FormState>();
  late int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          title: const Center(
            child: Text(
              "My Profile",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          leading: const Icon(Icons.arrow_back_ios_new),
          actions: [
            TextButton(
              onPressed: () {
                context.pushPage(const Edit());
              },
              child: const Icon(Icons.share),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/avatary.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nema Alnajjar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "CEO - HiLinky",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.square,
                              // grade: 3.3,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 11),
                            child: const Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.square,
                              // grade: 3.3,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 11),
                            child: const Icon(
                              Icons.call,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.square,
                              // grade: 3.3,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 11),
                            child: const Icon(
                              Icons.link,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.square,
                              // grade: 3.3,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 11),
                            child: const Icon(
                              Icons.castle_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            child: const Icon(
                              Icons.square,
                              // grade: 3.3,
                              color: Colors.orange,
                              size: 40,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, top: 11),
                            child: const Icon(
                              Icons.camera,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: 181,
                    width: 361,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushPage(const Edit());
                                },
                                child: const Text(
                                  "Edit Profile Information",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushPage(const Notifications());
                                },
                                child: const Text(
                                  "Notifications",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const Text("ON")
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Language",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const Text("English(US)")
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: 181,
                    width: 361,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  showBottomSheet(
                                    // clipBehavior: AboutDialog(applicationName: ,),

                                    shape: const Border.symmetric(),
                                    // strokeAlign:
                                    //     BorderSide.strokeAlignOutside,

                                    // color: Colors.black),
                                    context: context,
                                    builder: (context) {
                                      return const SizedBox(
                                        height: 200,
                                        width: 200,
                                        //MediaQuery.of(context).size.width,
                                        // *
                                        //     0.8,
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Theme",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Light Mode",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "Dark Mode",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "System Default",
                                                style: TextStyle(fontSize: 15),
                                              ),

                                              //                   TextButton(
                                              // onPressed: () {
                                              //  context.pop();
                                              // },
                                              // child:  Text("Cancel"))
                                            ],
                                          ),
                                        ),
                                      );
                                      // return SelectingSheet(keyword: text);
                                    },
                                  );
                                },
                                child: const Text(
                                  "Theme",
                                  style: TextStyle(color: Colors.black),
                                )),
                            const Text("Light Mode")
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  context.pushPage(const Activity());
                                },
                                child: const Text(
                                  "Activity",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: const Icon(
                                    Icons.circle_outlined,
                                    // grade: 3.3,
                                    color: Colors.blueGrey,
                                    size: 40,
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 11, top: 11),
                                  child: const Icon(
                                    Icons.my_library_books_rounded,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  showBottomSheet(
                                    // clipBehavior: AboutDialog(applicationName: ,),

                                    shape: const Border.symmetric(),
                                    // strokeAlign:
                                    //     BorderSide.strokeAlignOutside,

                                    // color: Colors.black),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // *
                                        //     0.8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Log Out",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                "Are you sure you want to logout?",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pushPage(
                                                      const HomeScreen());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  // shape: const (),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 2, 84, 86),
                                                  fixedSize: const Size(70, 40),
                                                  elevation: 0,
                                                ),
                                                //  style: const ButtonStyle( B elevation: 0.2, ),
                                                child: const Text(
                                                  'Log Out',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pushPage(
                                                      const HomeScreen());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  // shape: const (),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 2, 84, 86),
                                                  fixedSize: const Size(70, 40),
                                                  elevation: 0,
                                                ),
                                                //  style: const ButtonStyle( B elevation: 0.2, ),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              //                   TextButton(
                                              // onPressed: () {
                                              //  context.pop();
                                              // },
                                              // child:  Text("Cancel"))
                                            ],
                                          ),
                                        ),
                                      );
                                      // return SelectingSheet(keyword: text);
                                    },
                                  );
                                },
                                child: const Text(
                                  "Log Out",
                                  style: TextStyle(color: Colors.black),
                                )),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: <Widget>[
                            //     ListTile(
                            //       title: const Text('Option 1'),
                            //       leading: Radio(
                            //         value: 1,
                            //         groupValue: selectedOption,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             selectedOption = value!;
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //     ListTile(
                            //       title: const Text('Option 2'),
                            //       leading: Radio(
                            //         value: 2,
                            //         groupValue: selectedOption,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             selectedOption = value!;
                            //           });
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 40,
              // ),
              //tabs(),
            ],
          ),
        ));
  }
}
