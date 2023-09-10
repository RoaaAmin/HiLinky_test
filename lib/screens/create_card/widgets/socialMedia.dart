import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hilinky_test/core/utils/size_utils.dart';

class SocialMedia extends StatefulWidget {
  SocialMedia({super.key, required this.paddin, required this.saved});
  var paddin;
  Map<String,String> saved;

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  //links save
  Map<String,String> links = {
    'facebook' : '',
    'linkedin' : '',
    'twitter' : '',
    'github' : '',
  };
  // icons
  List<Widget> socialMediaIcons = [
    const FaIcon(FontAwesomeIcons.facebook),
    const FaIcon(FontAwesomeIcons.linkedin),
    const FaIcon(FontAwesomeIcons.twitter),
    const FaIcon(FontAwesomeIcons.github),
  ];

  var entredLink = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: getVerticalSize(51),
        crossAxisCount: 5,
        mainAxisSpacing: getHorizontalSize(24),
        crossAxisSpacing: getHorizontalSize(24),
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: socialMediaIcons.length,
      itemBuilder: (context, index) {
        var name;
        if(index == 0){
          name = 'facebook';
        };
        if(index == 1){
          name = 'linkedin';
        };
        if(index == 2){
          name = 'twitter';
        };
        if(index == 3){
          name = 'github';
        };
        return IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => Padding(
                padding: widget.paddin,
                child: bottomSheetLinks(index,name),
              )),
            );
          },
          icon: socialMediaIcons[index],
        );
      },
    );



  }
  Widget bottomSheetLinks(index,name) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 95,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter a link",
              ),
              controller: entredLink,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: (){
                    links["$name"] = entredLink.text;
                    widget.saved = links;
                    print(links);
                    Navigator.of(context).pop();
                    entredLink.clear();
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
