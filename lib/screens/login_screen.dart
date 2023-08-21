import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../auth.dart';
import '../main.dart';
import '../models/SnackBar.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _LoginScreenState();


  }

class _LoginScreenState extends State<LoginScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  void openSignupScreen(){
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children:[
//Title
              Text('SIGN IN',
                style: GoogleFonts.robotoCondensed(fontSize:40, fontWeight: FontWeight.bold),
              ),
                Text('Welcome back!',
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
// email text
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          prefixIcon: Icon(
                            LineIcons.envelope,
                            color: Colors.grey,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.white,
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
                        controller: _passwordController,
                       // obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            LineIcons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.grey,),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.white,
                        obscureText: obscureText,
                        ),
                      ),
                    ),
                  ),


SizedBox(height: 15),
// sign in button
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25),
  child:   GestureDetector(
    onTap: loginValidation,
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[900],
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Text('Sign in', style: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),)),
    ),
  ),
),
//space between button and text
SizedBox(height: 25),
                Center(
                  child: GestureDetector(
                    onTap: () async{
                        sendRecoveryPass();
                    },
                    child: Text(
                      'Forget Password ?',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                // make text to sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text ('Not a member? ',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),

                    GestureDetector(
                      onTap: openSignupScreen,
                      child: Text('sign up Now',
                        style: GoogleFonts.roboto(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],
                )
              ],
          ),
        ),
    ),
      ),
    );
  }

  void loginValidation(){
    if(_emailController.text==null||_emailController.text.contains('@')==false||_emailController.text.contains('.com')==false){
      showInSnackBar('Invalid Email', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(_passwordController.text==null||_passwordController.text.length<6){
      showInSnackBar('Invalid Password', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else{
      print('Validation Completed');
      signIn();

    }
  }

  Future signIn() async{
    print('Authentication Started.......');
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ).then((userCredentials)async{
        if(userCredentials.user?.uid!=null){
          if(userCredentials.user?.emailVerified==false){
            clearControllers();
            await userCredentials.user?.sendEmailVerification();
            await FirebaseAuth.instance.signOut().then((value) {
              showInSnackBar('Oops, Your email is not verified, Please verify your email', Colors.amber[800]!, Colors.white, 3, context, _scaffoldKey);
            }).then((metaData)async{
              await FirebaseFirestore.instance.collection('Users').doc(userCredentials.user!.uid).get().then((userDataInfo) {
                setState(() {
                  sUserID = userCredentials.user!.uid;
                  sUserEmail = userDataInfo.data()!['sUserEmail'];
                  sUserName = userDataInfo.data()!['sUserName'];
                  sUserPhoneNumber = userDataInfo.data()!['sUserPhoneNumber'];
                });
              });
            });
          }else{
            await FirebaseFirestore.instance.collection('Users').doc(userCredentials.user?.uid).get().then((userDoc) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => Auth()));
            });
          }
        }
      });
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar('Login failed, incorrect account information.', Colors.red, Colors.white, 3, context, _scaffoldKey);
    }
  }
  clearControllers(){
    _emailController.clear();
    _passwordController.clear();

  }

  sendRecoveryPass()async{
    if(_emailController.text==null||_emailController.text.contains('@')==false||_emailController.text.contains('.com')==false){
      showInSnackBar('Invalid Email', Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else {
      await FirebaseFirestore.instance.collection('Users')
          .where('UserEmail',isEqualTo: _emailController.text)
          .get().then((whereResult) async{
        if(whereResult==null && whereResult.docs.isEmpty){
          showInSnackBar('There is no record for this email', Colors.red, Colors.white, 3, context, _scaffoldKey);
          _passwordController.clear();
        }else{
          try {
            await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((metaData) {
              showInSnackBar('Reset password email has been sent',  Colors.green, Colors.white, 2, context, _scaffoldKey);
              _passwordController.clear();
            });
          } catch (e) {
            showInSnackBar('There is no record for this email', Colors.red, Colors.white, 3, context, _scaffoldKey);
          }
        }
      });
    }
  }
}

