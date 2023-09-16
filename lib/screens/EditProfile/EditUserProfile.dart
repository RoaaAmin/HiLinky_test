import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:random_string/random_string.dart';
import '../../models/SnackBar.dart';
import '../../models/user.dart';
import 'NetworkHandler.dart';





class EditUserProfile extends StatefulWidget {


  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<EditUserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //for updating user info
  bool _displayNameValid = true;
  bool _displayPhoneValid = true;

  // for getting a user name.
  bool isLoading = false;
  User? user;
  String? userID;

  @override
  void initState() {
    getUserID();
    super.initState();
    getUser();
  }

  getUserID() {
    setState(() {
      userID = fbAuth.FirebaseAuth.instance.currentUser?.uid;
    });
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(userID).get();
    user = User.fromDocument(doc);
    _name.text = user!.username;
    //_email.text = user.email;
    setState(() {
      isLoading = false;
    });
  }

  //final networkHandler = NetworkHandler();
  bool circular = false;
  File?_selectedImage;

  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNum = TextEditingController();

  // method to update the user data .
  updateMyProfile() async {
    if (_selectedImage != null) {
    // await context.loaderOverlay.show();
      await FirebaseStorage.instance.ref('Users/').child(randomAlphaNumeric(9).toString() + '.jpg').putFile(_selectedImage!).then((value) async {
        await value.ref.getDownloadURL().then((link) async {
          print(value);
          setState(() {
            _name.text.isEmpty ? _displayNameValid = false : _displayNameValid = true;
            _phoneNum.text.isEmpty ? _displayPhoneValid = false : _displayPhoneValid = true;
          });
          if (_displayNameValid  || _displayPhoneValid) {
            print(" updating user info ");
            print(" User ID");
            print(userID.toString());
            try {
              await FirebaseFirestore.instance.collection('Users').doc(userID).update({
                "sUserName": _name.text,
                "sUserPhoneNumber": _phoneNum.text,
                "UserProfileImage": link,

              }
                //when we pressed on update button move me to previous page
              ).then((value) async {
             //   await context.loaderOverlay.hide();
                Navigator.of(context).pop();
              });
            }

            catch (e) {
              print(e.toString());
            }
            showInSnackBar('Your profile is updated!',  Colors.green, Colors.black, 2, context, _scaffoldKey);

          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //********************************************************************
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Color(0xff390B33),
      overlayOpacity: 0.80,
      overlayWidget: Center(
          child: SizedBox(
              height: 125,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                backgroundColor: Colors.transparent,
              ))),
      child: Scaffold(
        body: Form(
          key: _globalkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
            children: <Widget>[
              imageProfile(),
              SizedBox(
                height: 20,
              ),
              nameTextField(),
              SizedBox(
                height: 20,
              ),

              phoneNumTextField(),
              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () async {
                  setState(() {
                    circular = true;
                  });
                  if (_globalkey.currentState!.validate()) {
                    Map<String, String> data = {
                      "name": _name.text,
                      "phoneNumber": _phoneNum.text,

                    };

                   var response = await NetworkHandler().post("/profile/add", data);
                    if (response.statusCode == 200 || response.statusCode == 201) {
                      if (_selectedImage!.path != null) {
                        var imageResponse = await NetworkHandler().patchImage("/profile/add/image", _selectedImage!.path);
                        if (imageResponse.statusCode == 200) {
                          setState(() {
                            circular = false;
                          });
                        //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homeScreen()), (route) => false);
                        }
                      } else {
                        setState(() {
                          circular = false;
                        });
                      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => homeScreen()), (route) => false);
                      }
                    }
                  }
                },
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          updateMyProfile();
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[


        // CircleAvatar(
        //   backgroundColor: Colors.white,
        //   radius: 55.0,
        //   backgroundImage: _selectedImage == null ?
        //   NetworkImage("https://www.sketchappsources.com/resources/source-image/profile-illustration-gunaldi-yunus.png") : FileImage(File(_selectedImage.path)),
        // ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,

              size: 18.0,
            ),
          ),
        ),
      ]),
    );
  }


  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image,),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ]
          )
        ],
      ),
    );
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform.getImage(source: source,);
    setState(() {
      _selectedImage = File(image!.path);
    });
  }

  Future takePhoto(ImageSource source) async {
    //final pickedFile = await _picker.getImage(source: source,);
    setState(() {
      //_imageFile = pickedFile;
    });
  }



  Widget nameTextField() {
    return TextFormField(
      controller: _name,
      validator: (value) {
        if (value!.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(

              width: 2,
            )),
        prefixIcon: Icon(
          Icons.person,
        ),
        labelText: "Name",
        // helperText: "Name can't be empty",
        hintText: "",
      ),
    );
  }


  Widget phoneNumTextField() {
    return TextFormField(
      controller: _phoneNum,
      validator: (value) {
        if (value!.isEmpty) return "Phone number can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            )),
        prefixIcon: Icon(
          Icons.person,
        ),
        labelText: "Phone Number",
        // helperText: "Phone number can't be empty",
        hintText: "",
      ),
    );

  }

}

