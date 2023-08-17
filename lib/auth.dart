
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:hilinky_test/screens/login_screen.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData){ // if user already logged in
            return HomeScreen();
            // no data else
          } else{
            return LoginScreen();
          }
        }

        )
      ),

     );

}
}