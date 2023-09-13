
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hilinky_test/screens/QRScannerPage.dart';
import 'package:hilinky_test/screens/create_card/create_card.dart';
import 'package:hilinky_test/screens/create_post.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:hilinky_test/screens/login_screen.dart';
import 'package:hilinky_test/screens/myProfile/myProfile.dart';
import 'package:hilinky_test/screens/my_card/myCard.dart';
import 'package:hilinky_test/screens/profilePage/ProfilePage.dart';
import 'package:hilinky_test/screens/search_page_premuim_screen/search_page_premuim_screen.dart';
import 'package:hilinky_test/screens/signup_screen.dart';
import 'package:hilinky_test/theme/theme_helper.dart';
import 'API/SendUserNotification.dart';
import 'API/notifications.dart';
import 'auth.dart';
import 'feeds/feeds.dart';
import 'firebase_options/firebase_options.dart';


// did it work?

String sUserID = ' ';
String sUserName = ' ';
String sUserEmail = ' ';
String sUserPhoneNumber = ' ';
String sUserNotificationToken = ' ';
String userProfileImage = ' ';
String uniqueUserName =' ';
String sNationality= ' ';
String sCity= ' ';

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
        'NotificationsPage': (context) =>  NotificationsPage(),
        'feeds': (context) => Feeds(),
        'CreatePost': (context) => CreatePost(),
        'MyCard':(context) => MyCard(),
        'SearchPagePremiumScreen':(context) =>  SearchPagePremiumScreen(),
        'QRScannerPage' :(context) =>  QRScannerPage(),
        'ProfilePage' :(context) =>   ProfilePage(),
        'MyProfile' :(context) =>  MyProfile(),
      },

    );

  }
}
