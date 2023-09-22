import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';

import '../../HELP/text_filed.dart';
import '../../subscription/my_subscription.dart';

class go_premium extends StatefulWidget {
  const go_premium({super.key});

  @override
  State<go_premium> createState() => _go_premiumState();
}

class _go_premiumState extends State<go_premium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WTextField(),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/search.png"),
                
                  const Text(
                    "Expand your surrounding by searching for others",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                
                  ElevatedButton(
                    onPressed: () {
                      context.pushPage(const my_subscription());
                    },
                    style: ElevatedButton.styleFrom(
                      // shape: const (),
                      padding: const EdgeInsets.all(5),
                      backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                      fixedSize: const Size(150, 40),
                      elevation: 0,
                    ),
                    //  style: const ButtonStyle( B elevation: 0.2, ),
                    child: const Text(
                      'Go premium',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
