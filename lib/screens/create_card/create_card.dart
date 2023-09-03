import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilinky_test/screens/create_card/widgets/create_card_items_widget.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:random_string/random_string.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../main.dart';
import '../../models/SnackBar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../myCard.dart';
////////////////////////////////

class CreateCard extends StatefulWidget {
  CreateCard({Key? key}) : super(key: key);

  @override
  State<CreateCard> createState() => _CreateCardState();
  late DocumentSnapshot<Map<String, dynamic>> card;
}

class _CreateCardState extends State<CreateCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String? prefix;
  String? firstName;
  String? middleName;
  String? lastName;
  String? position;
  String? companyName;
  String? email;
  String? phoneNumber;


  TextEditingController prefixController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool editMode = false;
  String editModeImageURL = '';
  String editModeImageURLLogo = '';
  String editModeImageURLPortfilio = '';
  File? selectedImage;
  File? selectedLogo;
  File? selectedPortfolio;

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedImage = File(image!.path);
    });
  }
  Future getLogo(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedLogo = File(image!.path);
    });
  }
  Future getPortfolio(ImageSource source) async {
    var image = await ImagePicker.platform
        .getImageFromSource(source: source); //pickImage
    print('printing source of image $source');
    setState(() {
      selectedPortfolio = File(image!.path);
    });
  }

  uploadCard() async {
    if (selectedImage != null) {
      String imageURL = editMode ? editModeImageURL : '';
      String logoURL = editMode ? editModeImageURLLogo : '';
      String portfolioURL = editMode ? editModeImageURLPortfilio : '';

      if (!editMode) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '.jpg')
            .putFile(selectedImage!)
            .then((value) async {
          imageURL = await value.ref.getDownloadURL();
        });
      }

      if (selectedLogo != null) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '_logo.jpg')
            .putFile(selectedLogo!)
            .then((value) async {
          logoURL = await value.ref.getDownloadURL();
        });
      }

      if (selectedPortfolio != null) {
        await FirebaseStorage.instance
            .ref('Cards/')
            .child(randomAlphaNumeric(9).toString() + '_portfolio.jpg')
            .putFile(selectedPortfolio!)
            .then((value) async {
          portfolioURL = await value.ref.getDownloadURL();
        });
      }

      if (editMode) {
        await widget.card.reference.update({
          "ImageURL": imageURL,
          "LogoURL": logoURL,
          "PortfolioURL": portfolioURL,
        });

      } else {
        await FirebaseFirestore.instance.collection('Cards').add({
          "ImageURL": imageURL,
          "LogoURL": logoURL,
          "PortfolioURL": portfolioURL,
           "Prefix": prefix,
           "FirstName": firstName,
           "MiddleName": middleName,
           "LastName":  lastName,
           "Position":  position,
           "CompanyName": companyName,
           "Email": email,
           "PhoneNumber": phoneNumber,
          "PostedByUID": sUserID,
          "TimeStamp": DateTime.now(),
        }).then((value) async {
          print('Card saved');
         // Navigator.of(context).pop();
        });
        Navigator.of(context).pushReplacement(
           CupertinoPageRoute(builder: (BuildContext context) => MyCard()));
      }
    } else {
      showInSnackBar('You have to fill all the fields ', Colors.red, Colors.white, 3,context,_scaffoldKey);
    }
  }


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
  Widget bottomSheetLogo() {
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
                getLogo(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image,color: Colors.amber[800]),
              onPressed: () {
                getLogo(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ]
          )
        ],
      ),
    );
  }
  Widget bottomSheetPortfolio() {
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
                getPortfolio(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image,color: Colors.amber[800]),
              onPressed: () {
                getPortfolio(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ]
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  LineIcons.arrowLeft,
                  size: 30.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
                  ));
                },
              )),
          body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to start
                  children: [
                    Text(
                      'Create Card',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing',
                      style: GoogleFonts.robotoCondensed(fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Personal Details',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                             controller: prefixController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Prefix (optional)',
                            ),
                            onChanged: (val) {
                              prefix = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                             controller: firstNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First name',
                            ),
                            onChanged: (val) {
                              firstName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: middleNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Middle name (optional)',
                            ),
                            onChanged: (val) {
                              middleName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                             controller: lastNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last name',
                            ),
                            onChanged: (val) {
                              lastName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: positionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Position',
                            ),
                            onChanged: (val) {
                              position = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                              controller: companyNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Company name (optional)',
                            ),
                            onChanged: (val) {
                              companyName = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Contact',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                             controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Border color
                            width: 2, // Border width
                          ),
                        ),
// email text
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                             controller: phoneNumberController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone number',
                            ),
                            onChanged: (val) {
                              phoneNumber = val;
                            },
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Choose links to add',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: getPadding(
                        top: 16,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: getVerticalSize(51),
                          crossAxisCount: 5,
                          mainAxisSpacing: getHorizontalSize(24),
                          crossAxisSpacing: getHorizontalSize(24),
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return CreateCardItemWidget();
                        },
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        top: 16,
                        right: 74,
                      ),
                      child: Row(
                        children: [
                          // CustomImageView(
                          //   imagePath: ImageConstant.imgDribbble,
                          //   height: getSize(50),
                          //   width: getSize(50),
                          // ),
                          // CustomImageView(
                          //   imagePath: ImageConstant.imgBehance,
                          //   height: getSize(50),
                          //   width: getSize(50),
                          //   margin: getMargin(
                          //     left: 24,
                          //   ),
                          // ),
                          // CustomIconButton(
                          //   height: getSize(50),
                          //   width: getSize(50),
                          //   margin: getMargin(
                          //     left: 24,
                          //   ),
                          //   padding: getPadding(
                          //     all: 8,
                          //   ),
                          //   child: CustomImageView(
                          //     svgPath: ImageConstant.imgLocationmarker,
                          //   ),
                          // ),
                          CustomIconButton(
                            height: getSize(50),
                            width: getSize(50),
                            margin: getMargin(
                              left: 24,
                            ),
                            padding: getPadding(
                              all: 13,
                            ),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgTablerplus,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: editMode,
                      child: Container(
                        //margin: EdgeInsets.symmetric(horizontal: 0),
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                                image: NetworkImage(editModeImageURL))),
                        // width: MediaQuery.of(context).size.width,
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
                                //margin: EdgeInsets.symmetric(horizontal: 0),
                                height: 150,
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
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Icon(Icons.account_box, size: 50.0),
                                Text(
                                  'Upload your photo',
                                ),
                              ],
                            )

                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Visibility(
                          visible: editMode,
                          child: Container(
                            //margin: EdgeInsets.symmetric(horizontal: 0),
                            //height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: NetworkImage(editModeImageURLLogo))),
                            // width: MediaQuery.of(context).size.width,
                          ),
                          replacement: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheetLogo()),
                              );
                            },
                            child: selectedLogo != null
                                ? Container(
                              //margin: EdgeInsets.symmetric(horizontal: 0),
                              height: 170,
                              width: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedLogo as File,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : Container(

                              // margin: EdgeInsets.symmetric(horizontal: 50),
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                width: 170,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Icon(Icons.upload, size: 50.0),
                                    Text(
                                      'Upload logo',
                                    ),
                                  ],
                                )

                            ),
                          ),
                        ),

                 SizedBox(width: 10,),

                        Visibility(
                          visible: editMode,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                             height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                    image: NetworkImage(editModeImageURLPortfilio))),
                            // width: MediaQuery.of(context).size.width,
                          ),
                          replacement: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheetPortfolio()),
                              );
                            },
                            child: selectedPortfolio
                                != null
                                ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 6),
                              height: 170,
                              width: 170,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedPortfolio
                                  as File,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                                : Container(

                              margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                width:170,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Icon(Icons.upload, size: 50.0),
                                    Text(
                                      'Upload portfolio',
                                    ),
                                  ],
                                )

                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                          onTap: uploadCard,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                            'Continue',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}