



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilinky_test/screens/create_post.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'main.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool postsFetched = false;
  late DocumentSnapshot<Map<String, dynamic>> userData;
  List<DocumentSnapshot<Map<String, dynamic>>> postsDocs= [];

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getPosts() async {
    await FirebaseFirestore.instance.collection('Posts')
       // .where('Status',isNotEqualTo: 'CLOSED')
        .get().then((value) async{
      if (value.docs.isEmpty == false) {
        for(int i=0;i<value.docs.length;i++){
            if(!mounted)return;
            setState(() {
              postsDocs.add(value.docs[i]);
              postsFetched = true;
            });
        }
        postsDocs.sort((a, b) => b.data()!['TimeStamp'].compareTo(a.data()!['TimeStamp']));
    }});
  }


  getUserData() async {
    await FirebaseFirestore.instance.collection('Users').doc(sUserID).get().then((value) {
      setState(() {
        userData = value;
        getPosts();
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Color(0xff390B33),
      overlayOpacity: 0.80,
      overlayWidget: Center(
          child: SizedBox(
              height: 125,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                backgroundColor: Colors.transparent,
              ))),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(LineIcons.bell, size:30.0),
                    onPressed: () {
                      // Navigator.pushNamed(context, notificationsViewRoute);
                    }
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0, bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
                          child: Text(
                            "Posts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          //height: 50.0,
                          //width: deviceWidth,
                          //decoration: BoxDecoration(
                          //  color: Colors.grey.withOpacity(0.3),
                          //  borderRadius: BorderRadius.circular(12.0),
                        ),
                        //  child: TextField(
                        // decoration: InputDecoration(
                        //    border: InputBorder.none,
                        //  prefixIcon: Icon(
                        //   Icons.search,
                        // color: Colors.grey,
                        //  ),
                        // contentPadding: EdgeInsets.only(top: 15.0),
                        // hintText: 'Search for active cases...',
                        // hintStyle: TextStyle(
                        //   color: Colors.grey.withOpacity(0.6),
                        // fontWeight: FontWeight.w600,
                        //  ),
                        // ),
                        //  ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            flowList(context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber.shade800,
            onPressed: () {
              //if(userData.data()!['UserType']=='Driver'){
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) => CreatePost()));
            }

          //  },
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    if (postsDocs != null) {
      if (postsDocs.length != 0) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 75),
            itemCount: postsDocs.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: ()async{
                //  showUserBottomSheet(postsDocs[i]);
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
                                image: DecorationImage(image: NetworkImage(postsDocs[i].data()!['ImageURL']), fit: BoxFit.fill),
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
                          'Description:',
                          style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        Text(
                          postsDocs[i].data()!['Description'],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
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
                                  'Status: ',
                                  style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  postsDocs[i].data()!['Status'],
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
                                ),
                               // postsDocs[i].data()!['TimeStamp'],
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
       // print('No post');
        return Center(child: CircularProgressIndicator());

      }
    } else {

      //print('Noo post');
      return Center(child: CircularProgressIndicator());

    }
  }




}
