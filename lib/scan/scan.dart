import 'package:flutter/material.dart';

class scan extends StatefulWidget {
  const scan({super.key});

  @override
  State<scan> createState() => _scanState();
}

class _scanState extends State<scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 100, left: 8, right: 8),
        child: Center(
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Scan the QR code of the card.",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/scan.png")
                  // h
                  ),
              const Text(
                "The QR code will be automatically detected when you position it between the guide lines",
                style: TextStyle(fontSize: 14),
              ),
              ElevatedButton(
                onPressed: () {
                  // context.pushPage(const Home());
                },
                style: ElevatedButton.styleFrom(
                  // shape: const (),
                  padding: const EdgeInsets.all(5),
                  backgroundColor: const Color.fromARGB(255, 2, 84, 86),
                  fixedSize: const Size(300, 40),
                  elevation: 0,
                ),
                //  style:  ButtonStyle(  elevation: 0.2, ),
                child: const Text(
                  'Scan QR Code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

      // backgroundColor: Colors.amberAccent,
    );
  }
}
