import 'package:flutter/material.dart';
import 'package:hilinky_test/components/context.dart';

import 'about_us.dart';
import 'f_list.dart';
import 'text_filed.dart';

class help extends StatefulWidget {
  const help({super.key});

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.amberAccent,

        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios_new),
          titleSpacing: 100,
          title: const Text("Help"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "How Can We Help You?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const WTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: f_list(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Questions ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            context.pushPage(const aboutus());
                          },
                          child: const Text("View All"))
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 400,
                    color: Colors.blueAccent,
                  )
                ],
              ),
            ],
          ),
        )

        //  Container(
        //   child: ,

        //     )
        );
  }
}
