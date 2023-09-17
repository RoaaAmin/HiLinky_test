import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatefulWidget {
  Link({super.key, required this.Links});

  Map<String, dynamic> Links;

  @override
  State<Link> createState() => _Link();
}

class _Link extends State<Link> {
  //links save

  // icons
  List<Widget> socialMediaIcons = [
    const FaIcon(FontAwesomeIcons.facebook),
    const FaIcon(FontAwesomeIcons.linkedin),
    const FaIcon(FontAwesomeIcons.twitter),
    const FaIcon(FontAwesomeIcons.github),
    const FaIcon(FontAwesomeIcons.instagram),
  ];

  Map<String,FaIcon> l = {
    'linkedin': FaIcon(FontAwesomeIcons.linkedin),
    'facebook': FaIcon(FontAwesomeIcons.facebook),
    'twitter': FaIcon(FontAwesomeIcons.twitter),
    'github': FaIcon(FontAwesomeIcons.github),
    'instagram': FaIcon(FontAwesomeIcons.instagram),
  };

  @override
  Widget build(BuildContext context) {
    List<String> keys = widget.Links.keys.toList();
    List<dynamic> values = widget.Links.values.toList();


    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.Links.length,
        itemBuilder: (context, index) {
          return Card(
            child: IconButton(
              isSelected: true,
              iconSize: 40,
              onPressed:(){
                final Uri url = Uri.parse(values[index]);
                _launchUrl(url);
              },
              icon: Icon(l[keys[index]]!.icon),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
