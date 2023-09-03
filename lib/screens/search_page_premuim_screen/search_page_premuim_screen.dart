import 'package:flutter/material.dart';
import 'package:hilinky_test/core/app_export.dart';
import 'package:hilinky_test/widgets/custom_bottom_bar.dart';
import 'package:hilinky_test/widgets/custom_drop_down.dart';
import 'package:hilinky_test/widgets/custom_search_view.dart';

class SearchPagePremuimScreen extends StatelessWidget {
  SearchPagePremuimScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  TextEditingController searchController = TextEditingController();

  List<String> dropdownItemList = [
    'City 1',
    'City 2',
    'City 3',
  ];

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
                onChanged: (value) {},
              ),
              SizedBox(height:100),
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
              ),
              Container(
                width: getHorizontalSize(330),
                margin: getMargin(
                  left: 19,
                  top: 16,
                  right: 11,
                  bottom: 16,
                ),
                child: Text(
                  "Expand your surrounding by searching for others",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      CustomTextStyles.bodyMediumInterOnPrimaryContainer.copyWith(
                    height: 1.56,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
