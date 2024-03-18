import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Color.dart';

Widget LoadingWidget(BuildContext context){

  return SpinKitThreeInOut(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index.isEven ? Colors.white : colors.primary,
        ),
      );
    },
    // color: Colors.white,
    size: 20.0,
  );
}