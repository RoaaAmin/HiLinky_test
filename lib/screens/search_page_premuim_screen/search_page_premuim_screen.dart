import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilinky_test/screens/profilePage/ProfilePage.dart';

import '../../cardSearchDetails/cardDetails.dart';
import '../my_card/widget/qr_code.dart';

class SearchPagePremiumScreen extends StatefulWidget {
  SearchPagePremiumScreen({Key? key}) : super(key: key);

  @override
  State<SearchPagePremiumScreen> createState() => _SearchPagePremiumScreenState();
}

class _SearchPagePremiumScreenState extends State<SearchPagePremiumScreen> {
  TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cardsDocs = [];
  String? valueChoose ;
  List<String> dropdownItemList = [
    'City 1',
    'City 2',
    'City 3',
  ];
  Future<void> searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Cards')
        .where('City', isEqualTo: valueChoose)
        .where('Position', isEqualTo: query)
        .get();

    setState(() {
      cardsDocs = result.docs;
    });
  }

  Map<String, dynamic> Links = {};


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.fromLTRB(16, 86, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            cardsDocs.clear();
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    onChanged: (query) {
                      if (query.length >= 1) {
                        searchFromFirebase(query);
                      }
                    },
                  ),
                ),
                DropdownButton(
                  value: valueChoose, // control the selected value
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue!; // Update the selected value

                    });
                  },
                  items: dropdownItemList.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),

                SizedBox(height: 5),
                flowList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    if (cardsDocs.isNotEmpty) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 75),
        itemCount: cardsDocs.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () async {
              print('FLOWLIST ID -> ${cardsDocs[i].data()!['PostedByUID']}');
              print('FLOWLIST CardID -> ${cardsDocs[i].id}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetails(postedByUID: cardsDocs[i].data()!['PostedByUID'],),

                     // ProfilePage(postedByUID: cardsDocs[i].data()!['PostedByUID'],
                  ),

              );
            },
            child: Card(
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 110,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF495592),
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    cardsDocs[i].data()!['LogoURL']),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0xFF495592).withOpacity(0.9),
                    ),
                    Text(
                      'name:',
                      style: TextStyle(
                          color: Color(0xFF495592),
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    Text(
                      cardsDocs[i].data()!['FirstName'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    Divider(
                      color: Color(0xFF495592).withOpacity(0.9),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Position: ',
                              style: TextStyle(
                                  color: Color(0xFF495592),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            Text(
                              cardsDocs[i].data()!['Position'],
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14),
                            ),
                            // postsDocs[i].data()!['TimeStamp'],
                          ],
                        ),
                      ],
                    ),
                    QrCode(),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text("No results found"),
      );
    }
  }

  void getLinks() async {
    await FirebaseFirestore.instance
        .collection('Cards')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
          (value) {
        Links.clear();
        Links = value.data()!['Links'];
        Links.removeWhere((key, value) => value == '');
      },
    );
  }
}