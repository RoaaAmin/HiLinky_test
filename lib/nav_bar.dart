import 'package:flutter/material.dart';
import 'package:hilinky_test/screens/QRScannerPage.dart';
import 'package:hilinky_test/screens/home_screen.dart';
import 'package:hilinky_test/screens/search_page_premuim_screen/search_page_premuim_screen.dart';
import 'package:hilinky_test/screens/tabs/followedScreen/followedScreen.dart';

import 'NFC/nfc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List myScreenList = [
    HomeScreen(),
    //profiletest(),
    SearchPagePremiumScreen(),
    //Notifications(),
    QRScannerPage(),
    //Edit(),
    FollowedScreen(
      savedCards: [],
    ),
    //terms(),
    const nfc()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(size: 20),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add_alt_1), label: "Followed"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: "Market"),
          ],
        ),
        body: myScreenList[currentIndex]
//         extendBody: true,
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: DotNavigationBar(
//             backgroundColor: Colors.blueGrey[100],
//             currentIndex: currentIndex,
//             dotIndicatorColor: Colors.black,
//             unselectedItemColor: Colors.black,
//             selectedItemColor: Colors.orange,
//             onTap: (index) {
//               currentIndex = index;
//               setState(() {});
//             },
//             items: [
//               /// home
//               DotNavigationBarItem(
//                 icon: const Icon(Icons.home),
//               ),

//               /// search
//               DotNavigationBarItem(
//                 icon: const Icon(Icons.search),
//               ),

//               /// scan
//               DotNavigationBarItem(
//                 icon: const Icon(Icons.qr_code),
//               ),

// //followed
//               DotNavigationBarItem(
//                 icon: const Icon(Icons.person_add_alt_1),
//               ),

//               /// Marcket
//               DotNavigationBarItem(
//                 icon: const Icon(Icons.shopping_bag_outlined),
//               ),
//             ],
//           ),
//         ),
//         body: myScreenList[currentIndex]
        );
  }
}
