import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'my_commints.dart';
import 'my_likes.dart';
import 'my_post.dart';

class tabs extends StatefulWidget {
  const tabs({Key? key}) : super(key: key);

  @override
  _tabsState createState() => _tabsState();
}

class _tabsState extends State<tabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const Text(
              //   "Activity",
              //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              ButtonsTabBar(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                borderWidth: 1,
                borderColor: Colors.grey,
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 0, 55, 29),
                unselectedBackgroundColor: Colors.white,
                unselectedLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 55, 29),
                ),
                labelStyle: const TextStyle(color: Colors.white),
                tabs: const [
                  Tab(
                    text: "MyPosts",
                  ),
                  Tab(
                    text: "MyCommints",
                  ),
                  Tab(
                    text: "MyLikes",
                  ),
                ],
              ),

              const Expanded(
                child: TabBarView(
                  children: <Widget>[MyPosts(), MyCommints(), MyLikes()],
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

// class tabs extends StatefulWidget {
//   const tabs({super.key});

//   @override
//   State<tabs> createState() => tabsState();
// }

// class tabsState extends State<tabs> with SingleTickerProviderStateMixin {
//   late TabController tabController;

//   @override
//   void initState() {
//     tabController = TabController(length: 3, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               Container(
//                 // height: 20,
//                 width: MediaQuery.of(context).size.height,

//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: TabBar(
//                         // indicator: BoxDecoration(color: Colors.black),
//                         indicatorColor: Colors.orange,
//                         controller: tabController,
//                         labelColor: Colors.grey,
//                         tabs: const [
//                           Tab(
//                             text: "Request",
//                           ),
//                           Tab(
//                             text: "Offer",
//                           ),
//                           Tab(
//                             text: "Favorite",
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                   child: TabBarView(
//                       controller: tabController,
//                       children: const [MyPosts(), MyCommints(), MyLikes()]))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
