

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:random_string/random_string.dart';
import '../feeds.dart';
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
    var image = await ImagePicker.platform.pickImage(source: source);
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
         print('printing link of image $link');
          await FirebaseFirestore.instance.collection('Posts').add({
            "ImageURL": link,
            "Description": description,
            "Status": 'OPEN',
            "LiveLocationID": null,
            "LiveLocationStatus": false,
            "PostedByUID": sUserID,
            "TimeStamp": DateTime.now(),
          }).then((value) async {
         print('saved');
           });
       // Navigator.of(context).pop();
         Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Feeds()));

        });
      });
    }
    else {
     // showInSnackBar('You have to fill all the fields ', Colors.red, Colors.white, 3,context,_scaffoldKey);
    }
  }

  // @override
  // void initState() {
  //   getCurrentLocation();
  //   if (widget.post != null) {
  //     setState(() {
  //       editMode=true;
  //       editModeImageURL=widget.post.data()!['ImageURL'];
  //       descriptionController.text = widget.post.data()!['Description'];
  //       name = widget.post.data()!['Name'];
  //       from = widget.post.data()!['Age'];
  //       to = widget.post.data()!['CountryOrCity'];
  //       phone = widget.post.data()!['Phone'];
  //       time = widget.post.data()!['Time'];
  //       description = widget.post.data()!['Description'];
  //     });
  //   }
  //   super.initState();
  //  }
////////////////
//   editPost() async {
//    // await context.loaderOverlay.show();
//     await FirebaseFirestore.instance.collection('Cases').doc(widget.post.id).update({
//
//       "Status": 'OPEN',
//       "Description": description,
//     }).then((value) async {
//      // await context.loaderOverlay.hide();
//       print('updated..')
//       Navigator.pop(context);
//     });
//   }

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


