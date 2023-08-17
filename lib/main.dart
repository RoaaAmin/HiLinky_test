
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hilinky_test/screens/create_post.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:hilinky_test/screens/login_screen.dart';
import 'package:hilinky_test/screens/signup_screen.dart';
import 'auth.dart';
import 'feeds.dart';
import 'firebase_options/firebase_options.dart';


//test
//check

String sUserID = ' ';
String sUserName = ' ';
String sUserEmail = ' ';
String sUserPhoneNumber = ' ';
String sUserNotificationToken = ' ';
String userProfileImage = ' ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      // home: Auth(),
      routes: {
        '/': (context) => const Auth(),
        'homeScreen': (context) =>   HomeScreen(),
        'signupScreen': (context) =>  SignupScreen(),
        'loginScreen':  (context) =>  LoginScreen(),
      //  'settingPage': (context) =>  settingPage(),
        'feeds': (context) => Feeds(),
        'CreatePost': (context) => CreatePost(),
      },

    );

  }
}
