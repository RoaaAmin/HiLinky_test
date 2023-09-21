import 'package:flutter/material.dart';
import 'package:hilinky_test/Profile/Activity_tabs/com.dart';

class MyCommints extends StatelessWidget {
  const MyCommints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: const [
        com(),
        com(),
        com(),
      ],
    ));
  }
}


// class MyCommints extends StatefulWidget {
//   const MyCommints({super.key});

//   @override
//   State<MyCommints> createState() => _MyCommintsState();
// }

// class _MyCommintsState extends State<MyCommints> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Scaffold(
//         // appBar: AppBar(
//         //   title: const Text("MyCommints"),
//         //   leading: const Icon(Icons.arrow_back_ios),
//         // ),
    
//         body: Text("MyCommints"),
//       ),
//     );
//   }
// }
