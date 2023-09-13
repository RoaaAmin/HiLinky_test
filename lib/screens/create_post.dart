

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:random_string/random_string.dart';
import '../API/SendUserNotification.dart';
import '../feeds/feeds.dart';
import '../main.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
  late DocumentSnapshot<Map<String, dynamic>> post;
   //CreatePost({required this.post});
}

class _CreatePostState extends State<CreatePost> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String?  description;

  TextEditingController descriptionController = TextEditingController();
  bool editMode=false;
  String editModeImageURL='';
  File? selectedImage;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform.getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedImage = File(image!.path);
    });
  }
   uploadpost() async {
    if (selectedImage != null) {
      await FirebaseStorage.instance.ref('Posts/')
          .child(randomAlphaNumeric(9).toString() + '.jpg')
          .putFile(selectedImage!).then((value) async {
        await value.ref.getDownloadURL().then((link) async {
         print('printing linkkkkkk of image $link');
          await FirebaseFirestore.instance.collection('Posts').add({
            "ImageURL": link,
            "Description": description,
            "Status": 'OPEN',
            "PostedByUID": FirebaseAuth.instance.currentUser!.uid,
            "TimeStamp": DateTime.now(),
          }).then((value) async {
          print('saved');
         SendNotification(
           title: 'New Post Added!',
           body: 'Hey, Check out the posted case.',
         ).sendToAllUsers(context);
        // await context.loaderOverlay.hide();
         Navigator.of(context).pop();
          });
         Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Feeds()));

        });
      });
    }
    else {
     // showInSnackBar('You have to fill all the fields ', Colors.red, Colors.white, 3,context,_scaffoldKey);
    }
  }
  @override
  Widget build(BuildContext context) {

    Widget bottomSheet() {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 95,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera,color: Colors.amber[800]),

                onPressed: () {
                  getImage(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image,color: Colors.amber[800]),
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
    //final isKeyboard = MediaQuery.of(context).viewInsets.bottom !=0;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Color(0xffc96304),
      overlayOpacity: 0.80,
      overlayWidget: Center(
          child: SizedBox(
              height: 125,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                backgroundColor: Colors.transparent,
              ))),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Text("Add new post"),
              ]),
              backgroundColor:  Colors.amber[800],
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    uploadpost();
                  },
                  child: Container(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.file_upload)),
                ),
              ]),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 20),
            child: ListView(children: <Widget>[
              Visibility(
                visible: editMode,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: NetworkImage(editModeImageURL)
                      )
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                replacement: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                  child: selectedImage != null
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        selectedImage as File,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 250,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      width: MediaQuery.of(context).size.width,
                      child: Icon(Icons.add_a_photo, size: 60.0)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: <Widget>[
                  TextField(
                    controller: descriptionController,
                    maxLength: 200,
                    maxLines: 6,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        hintText: "write here.."),

                    onChanged: (val) {
                      description = val;
                    },
                  ),
                ]),
              ),
            ]),

          )),

    );

  }
}


