import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hilinky_test/core/app_export.dart';
import 'package:hilinky_test/widgets/custom_bottom_bar.dart';
import 'package:hilinky_test/widgets/custom_drop_down.dart';
import 'package:hilinky_test/widgets/custom_search_view.dart';

class SearchPagePremuimScreen extends StatefulWidget {
  SearchPagePremuimScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SearchPagePremuimScreen> createState() => _SearchPagePremuimScreenState();
}

class _SearchPagePremuimScreenState extends State<SearchPagePremuimScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot<Map<String, dynamic>>> cardsDocs= [];
  List<String> dropdownItemList = [
    'City 1',
    'City 2',
    'City 3',
  ];

  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Cards')
       .where('CompanyName', isEqualTo: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
    print("printttt $searchResult");
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 16,
            top: 86,
            right: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSearchView(
                controller: searchController,
                hintText: "Search",
                hintStyle: CustomTextStyles.bodyLarge16,
                prefix: Container(
                  margin: getMargin(
                    all: 8,
                  ),
                  child: CustomImageView(
                    svgPath: ImageConstant.imgSearch1,
                  ),
                ),
                prefixConstraints: BoxConstraints(
                  maxHeight: getVerticalSize(40),
                ),
                suffix: Padding(
                  padding: EdgeInsets.only(
                    right: getHorizontalSize(6),
                  ),
                  child: IconButton(
                    onPressed: () {
                     searchController.clear();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                onChanged: (query) {
                  searchFromFirebase(query);
                },
              ),
              CustomDropDown(
                width: getHorizontalSize(173),
                icon: Container(
                  margin: getMargin(
                    left: 30,
                    right: 12,
                  ),
                  child: CustomImageView(
                    svgPath: ImageConstant.imgGroup42179,
                  ),
                ),
                margin: getMargin(
                  top: 14,
                ),
                hintText: "Location",
                hintStyle: CustomTextStyles.titleSmallBlack900,
                alignment: Alignment.centerLeft,
                items: dropdownItemList,
                onChanged: (value) {
                },
              ),
              SizedBox(height:100),
            /*  SizedBox(
                height: getVerticalSize(157),
                width: getHorizontalSize(150),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgVector,
                      height: getVerticalSize(14),
                      width: getHorizontalSize(19),
                      alignment: Alignment.topLeft,
                      margin: getMargin(
                        left: 43,
                        top: 66,
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgClose,
                      height: getSize(20),
                      width: getSize(15),
                      alignment: Alignment.topLeft,
                      margin: getMargin(
                        left: 47,
                        top: 47,
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgReply,
                      height: getVerticalSize(13),
                      width: getHorizontalSize(18),
                      alignment: Alignment.topLeft,
                      margin: getMargin(
                        left: 44,
                        top: 44,
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgVectorErrorcontainer,
                      height: getSize(48),
                      width: getSize(48),
                      alignment: Alignment.topLeft,
                      margin: getMargin(
                        left: 34,
                        top: 31,
                      ),
                    ),
                    Opacity(
                      opacity: 0.3,
                      child: CustomImageView(
                        svgPath: ImageConstant.imgVectorOnsecondarycontainer,
                        height: getVerticalSize(72),
                        width: getHorizontalSize(77),
                        alignment: Alignment.topLeft,
                        margin: getMargin(
                          left: 11,
                          top: 27,
                        ),
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgVectorCyan800,
                      height: getVerticalSize(157),
                      width: getHorizontalSize(174),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),

             */
              // Container(
              //   width: getHorizontalSize(330),
              //   margin: getMargin(
              //     left: 19,
              //     top: 16,
              //     right: 11,
              //     bottom: 16,
              //   ),
              //   child: Text(
              //     "Expand your surrounding by searching for others",
              //     maxLines: 2,
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.center,
              //     style: CustomTextStyles.bodyMediumInterOnPrimaryContainer.copyWith(
              //       height: 1.56,
              //     ),
              //   ),
              // ),
              flowList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget flowList(BuildContext context) {
    if (cardsDocs != null) {
      if (cardsDocs.length != 0) {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 75),
            itemCount: cardsDocs.length,
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
                                image: DecorationImage(image: NetworkImage(cardsDocs[i].data()!['LogoURL']), fit: BoxFit.fill),
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
                          style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        Text(
                          cardsDocs[i].data()!['FirstName'],
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
                                  'Position: ',
                                  style: TextStyle(color: Color(0xFF495592), fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  cardsDocs[i].data()!['Position'],
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
        return
          //Center(child: CircularProgressIndicator());
        SizedBox(
          height: getVerticalSize(157),
          width: getHorizontalSize(150),

          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              SizedBox(height: 15,),
              CustomImageView(
                svgPath: ImageConstant.imgVector,
                height: getVerticalSize(14),
                width: getHorizontalSize(19),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 43,
                  top: 66,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgClose,
                height: getSize(20),
                width: getSize(15),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 47,
                  top: 47,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgReply,
                height: getVerticalSize(13),
                width: getHorizontalSize(18),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 44,
                  top: 44,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgVectorErrorcontainer,
                height: getSize(48),
                width: getSize(48),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 34,
                  top: 31,
                ),
              ),
              Opacity(
                opacity: 0.3,
                child: CustomImageView(
                  svgPath: ImageConstant.imgVectorOnsecondarycontainer,
                  height: getVerticalSize(72),
                  width: getHorizontalSize(77),
                  alignment: Alignment.topLeft,
                  margin: getMargin(
                    left: 11,
                    top: 27,
                  ),
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgVectorCyan800,
                height: getVerticalSize(157),
                width: getHorizontalSize(174),
                alignment: Alignment.center,
              ),
            ],
          ),
        );
      }
    } else {
      return
        //Center(child: CircularProgressIndicator());
        SizedBox(
          height: getVerticalSize(157),
          width: getHorizontalSize(150),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              CustomImageView(
                svgPath: ImageConstant.imgVector,
                height: getVerticalSize(14),
                width: getHorizontalSize(19),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 43,
                  top: 66,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgClose,
                height: getSize(20),
                width: getSize(15),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 47,
                  top: 47,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgReply,
                height: getVerticalSize(13),
                width: getHorizontalSize(18),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 44,
                  top: 44,
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgVectorErrorcontainer,
                height: getSize(48),
                width: getSize(48),
                alignment: Alignment.topLeft,
                margin: getMargin(
                  left: 34,
                  top: 31,
                ),
              ),
              Opacity(
                opacity: 0.3,
                child: CustomImageView(
                  svgPath: ImageConstant.imgVectorOnsecondarycontainer,
                  height: getVerticalSize(72),
                  width: getHorizontalSize(77),
                  alignment: Alignment.topLeft,
                  margin: getMargin(
                    left: 11,
                    top: 27,
                  ),
                ),
              ),
              CustomImageView(
                svgPath: ImageConstant.imgVectorCyan800,
                height: getVerticalSize(157),
                width: getHorizontalSize(174),
                alignment: Alignment.center,
              ),
            ],
          ),
        );
    }
  }
}
