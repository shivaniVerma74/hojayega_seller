import 'package:flutter/material.dart';
import 'package:hojayega_seller/Helper/color.dart';
class Custom_Text extends StatelessWidget {
  Custom_Text({Key? key,required this.text,required this.text2}) : super(key: key);

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black
          ),
        ),
        Text(text2,style: TextStyle(color: colors.primary,fontWeight: FontWeight.w600),),
      ],
    );
  }
}
