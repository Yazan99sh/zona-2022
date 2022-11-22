import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.black12,
          ),
        ),
      );
    } else {
      return Container(
          color: Colors.white,
          child: const Center(child: CupertinoActivityIndicator(radius: 15.0)));
    }
  }
}
