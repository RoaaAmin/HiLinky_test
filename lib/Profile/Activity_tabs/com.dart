import 'package:flutter/material.dart';

class com extends StatelessWidget {
  const com({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black)),
            child: const Column(children: [
              Text(
                "you have commented to @karem post",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Keep Going ! ")
            ])));
  }
}

// class com extends StatelessWidget {
//   const com({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.25,
//           child: Stack(
//             children: [
//               ImageSlideshow(
//                 height: MediaQuery.of(context).size.height * 0.25,
//                 width: MediaQuery.of(context).size.width,
//                 indicatorColor: Colors.white,
//                 isLoop: true,
//                 children: [
//                   Image.asset("assets/images/HilinkyLogo.png"),
//                   Image.asset("assets/images/HilinkyLogo.png"),
//                   Image.network(
//                     "https: img.freepik.com/free-photo/cat-white-background_155003-20502.jpg?w=1800&t=st=1686983645~exp=1686984245~hmac=8868e3d57c7f801391489e52c6b3eff7c6d393b80708d5d189ee1cca97d73b34",
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: const Color.fromARGB(150, 0, 0, 0),
//                   height: MediaQuery.of(context).size.height * 0.08,
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Oscar",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Cat | Shirazi | 2 years",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.favorite_border,
//                                   color: Colors.white,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 4, right: 8),
//                                   child: Text(
//                                     "123",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.file_upload_outlined,
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
