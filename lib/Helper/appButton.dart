//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../color.dart';
//
// Widget btn({VoidCallback? onTap, String? title, double? height, double? width }) {
//   return SizedBox(
//     height: height ?? 40,
//     width: width ?? 190,
//     child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colors.primary,
//
//
//         ),
//         onPressed: onTap, child:  Text(title ?? '--',
//     style: const TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: 16))),
//   );
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import '../Screen/notificationScreen.dart';
import 'color.dart';

class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  Btn({Key? key,
    this.title, this.onPress, this.height, this.width, this.fSize, this.icon,this.color
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [colors.primary, colors.primary,],
              stops: [0, 1,],
          ),
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(color:colors.primary)
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            "$title",
            style:  TextStyle(
              color:Colors.white,
              fontSize: fSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


Widget homeAppBar(BuildContext context,
    {required String text, required VoidCallback ontap}) {
  return
    Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      //padding: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colors.primary, colors.primary]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.menu,
                color: colors.primary,
              ),
            ),
          ),
          const Text(
            'Home',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
            child: Container(
              // margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.notifications_active_rounded,
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
}


Widget commonAppBar(BuildContext context,
    {required String text, bool? isActionButton}) {
  return
    Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        //padding: EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [colors.primary, colors.primary]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                //   Navigator.pop(context);
              },
              child: Container(
                // margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: colors.primary, borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.arrow_back,
                  color: colors.primary,
                ),
              ),
            ),
            Container(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
             isActionButton == false
                ? Container(
              width: 40,
              ): InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));},
                child: Container(
                // margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: colors.primary,
                     ),
                  ),
              ),
          ],
        ),
    );
}