


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../main.dart';
import '../models/SnackBar.dart';


class SignupScreen extends StatefulWidget {
 const SignupScreen({Key? key}) : super(key: key);


  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

/// user info
  String Error = '';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();
  TextEditingController _confirmPasswordConroller = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();



  Future signUp() async{

    if(passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: _emailController.text.trim(),
        password: _passwordConroller.text.trim(),);
      Navigator.of(context).pushReplacementNamed('/');
    }
  }
bool passwordConfirmed(){
    if(_passwordConroller.text.trim() ==
        _confirmPasswordConroller.text.trim()){
      return true;
    }else{
      return false;
    }
}
  void openLoginScreen(){
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordConroller.dispose();
    _confirmPasswordConroller.dispose();
  }
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,);

    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
       // notificationToken=token;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

///Title
                Text('SIGN UP',
                  style: GoogleFonts.robotoCondensed(fontSize:40, fontWeight: FontWeight.bold),
                ),
                Text('Welcome! Here you can sign up',
                  style: GoogleFonts.robotoCondensed(fontSize:18),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
//name
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'User Name',
                          prefixIcon: Icon(
                            LineIcons.user,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
// email text
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Adress',
                          prefixIcon: Icon(
                            LineIcons.envelope,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
           // phone num
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  prefixIcon: Icon(
                    LineIcons.mobilePhone,
                    color: Colors.black38,
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
              ),
                ),
              ),
            ),
        SizedBox(height: 10),
                //pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordConroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //confirm pass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                //SizedBox(height: 15),

/// Radio buttons
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    ),
    ),),

                SizedBox(height: 15),
// sign up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child:   GestureDetector(
                    onTap: signUpValidation,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.amber[900],
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text('Sign up', style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),)),
                    ),
                  ),
                ),
          //space between button and text
                SizedBox(height: 25),
                // make text to sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text ('Already a member? ',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),

                    GestureDetector(
                      onTap: openLoginScreen,
                      child: Text('sign in Here',
                        style: GoogleFonts.roboto(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//////////////////////////////////////////////


  void signUpValidation(){

    if(nameController.text==null||nameController.text.length<3){
      showInSnackBar('Please Enter valid you name.', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(_emailController.text==null||_emailController.text.contains('@')==false||_emailController.text.contains('.com')==false){
      showInSnackBar('Invalid Email', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(phoneNumberController.text==null||phoneNumberController.text.contains('05')==false||phoneNumberController.text.length<10){
      showInSnackBar('Please enter your phone number, ex: 05xxxxxxxxx', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(_passwordConroller.text==null||_passwordConroller.text.length<6){
      showInSnackBar('Password is too weak.', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else{
      print('Validation Completed');
      signup();
    }
  }

  Future signup()async{
    DocumentSnapshot<Map<String, dynamic>> userData;
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordConroller.text,
      ).then((userCredentials) async{
        if(userCredentials.user!=null){
          await userCredentials.user!.sendEmailVerification().then((metaData) async{
            try{
              await FirebaseFirestore.instance.collection('Users').doc(userCredentials.user!.uid).set({
                'UserID':userCredentials.user!.uid,
                'UserEmail':userCredentials.user!.email,
                'UserName':nameController.text,
                'UserPhoneNumber':phoneNumberController.text,
                'AccountCreatedDateTime':DateTime.now(),
              }).then((value) async{
                await FirebaseFirestore.instance.collection('Users').doc(userCredentials.user!.uid).get().then((userDBData) async{
                  setState(() {
                    userData=userDBData;
                   sUserID = userCredentials.user!.uid;
                    sUserEmail = userDBData.data()!['UserEmail'];
                    sUserName = userDBData.data()!['UserName'];
                    sUserPhoneNumber = userDBData.data()!['UserPhoneNumber'];
                   // sUserNotificationToken = userDBData.data()!['FBNotificationToken'];
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  clearControllers();
                  await FirebaseAuth.instance.signOut();
                  showInSnackBar('Registration completed successfully',  Colors.green, Colors.white, 3, context, _scaffoldKey);
                 // Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Auth()));
                });
              });
            }catch(e){
              await FirebaseAuth.instance.currentUser!.delete().then((value) async{
                await FirebaseAuth.instance.signOut().then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showInSnackBar('An error occur!', Colors.red, Colors.white, 3, context, _scaffoldKey);
                  print('$e');
                });
              });
            }
          });
        }


      });
    }on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar(e.message!.trim(), Colors.red, Colors.white, 3, context, _scaffoldKey);
    }
  }

  clearControllers(){
    _emailController.clear();
    _passwordConroller.clear();
    nameController.clear();
    phoneNumberController.clear();
    _emailController.clear();

  }
}

