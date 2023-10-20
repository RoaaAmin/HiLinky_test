import 'package:flutter/material.dart';
import 'package:hilinky_test/followed/linky.dart';

class Followed_list extends StatelessWidget {
  const Followed_list({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
    
        linky(
          nameperson: 'Maali Alkhaldi',
          usernameperson: "coding",
          profileImageperson: "assets/images/avatary.png",
          imageperson: "assets/images/big.png",
        ),
        linky(
          nameperson: 'Nema Alnajjar',
          usernameperson: "CEO - HiLinky",
          profileImageperson: "assets/images/avatary.png",
          imageperson: "assets/images/big.png",
        ),
        linky(
          nameperson: 'Tasneem',
          usernameperson: "UI/UX - HiLinky",
          profileImageperson: "assets/images/avatary.png",
          imageperson: "assets/images/big.png",
        ),
        linky(
          nameperson: 'Fai ',
          usernameperson: "Web - HiLinky",
          profileImageperson: "assets/images/avatary.png",
          imageperson: "assets/images/bg2.png",
        ),
      ],
    );
  }
}
