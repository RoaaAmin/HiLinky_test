import 'package:flutter/material.dart';

class WTextField extends StatefulWidget {
  const WTextField({
    super.key,
  });

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextField(
        controller: textEditingController,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          hintText: "Enter your keyword",
          prefixIconColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.grey[10],
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
        ),
        //--------
        // onSubmitted: (text) {
        //   showBottomSheet(
        //     context: context,
        //     builder: (context) {
        //       return SelectingSheet(keyword: text);
        //     },
        //   );
        // },
      ),
    );
  }
}
