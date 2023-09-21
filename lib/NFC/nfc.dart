import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:hilinky_test/NFC/step_1.dart';
import 'package:hilinky_test/components/context.dart';

class nfc extends StatefulWidget {
  const nfc({super.key});

  @override
  State<nfc> createState() => _nfcState();
}

class _nfcState extends State<nfc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 50, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Order your NFC card",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Text(
                "From here you can get your NFC card and specify all the details"),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageSlideshow(
                // height: MediaQuery.of(context).size.height * 0.25,
                height: 300,
                width: 300,
                // width: MediaQuery.of(context).size.width,
                indicatorColor: Colors.white,
                isLoop: true,
                children: [
                  Image.asset(
                    "assets/images/card.png",
                    scale: 1,
                  ),

                  Image.asset(
                    "assets/images/img_clippathgroup_black_900.png",
                    scale: 1,
                  ),
                  // Image.asset("assets/images/HilinkyLogo.png"),
                ],
              ),
            ),
            const Text(
                "Lorem Ipsum is simply dummy text of the printing /n Lorem Ipsum is simply dummy text of the printing"),
            ElevatedButton(
              onPressed: () {
                context.pushPage(const step_one());
              },
              style: ElevatedButton.styleFrom(
                // shape: const (),
                padding: const EdgeInsets.all(5),
                backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                fixedSize: const Size(300, 40),
                elevation: 0,
              ),
              //  style: const ButtonStyle( B elevation: 0.2, ),
              child: const Text(
                'Order your NFC card For 200 S.R',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     Text("Order your NFC card"),

      //     Text(
      //         "From here you can get your NFC card and specify all the details"),

      //     //slideshow

      //     Text(
      //         "Lorem Ipsum is simply dummy text of the printing /n Lorem Ipsum is simply dummy text of the printing"),
      //   ],
      // ),
    );
  }
}
//text
//text
//slideshow
//text
//button