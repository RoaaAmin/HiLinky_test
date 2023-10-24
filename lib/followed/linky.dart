import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//m
class linky extends StatelessWidget {
  linky(
      {super.key,
      required this.nameperson,
      required this.usernameperson,
      required this.profileImageperson,
      required this.imageperson});

  final String nameperson, usernameperson, profileImageperson, imageperson;

//icons
  Map<String, FaIcon> l = {
    'linkedin': const FaIcon(FontAwesomeIcons.linkedin),
    'facebook': const FaIcon(FontAwesomeIcons.facebook),
    'twitter': const FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
    'github': const FaIcon(FontAwesomeIcons.github),
    'instagram': const FaIcon(FontAwesomeIcons.instagram),
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 3,
          //color: const Color.fromARGB(255, 255, 255, 255),
          child: Stack(
            //  constraints: const BoxConstraints(minHeight: 0, maxHeight: 200.0)
            alignment: Alignment.centerLeft,
            children: [
              Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bigbig.png"),
                //    height: 190,
                // width: context.width,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        maxRadius: 70,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMxYwhyb-ZYPd3tHeJo3odrNh7GsYjPYGXsA&usqp=CAU")
                        //AssetImage(profileImageperson),
                        ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameperson,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          usernameperson,
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //   itemCount: Links.length,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.orange,
                                                Colors.deepOrange
                                              ],
                                              end: Alignment.topLeft,
                                              begin: Alignment.bottomRight),
                                        ),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: IconButton(
                                            isSelected: true,
                                            iconSize: 20,
                                            onPressed: () {
                                              // final Uri url =
                                              //     Uri.parse(
                                              //         values[index]);
                                              // _launchUrl(url);
                                            },
                                            icon: Icon(Icons.ac_unit_outlined),
                                            //   Icon( l[keys[index]]!.icon),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
