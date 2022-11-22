import 'package:flutter/material.dart';

class MyProgressDialog extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;

  const MyProgressDialog({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = WillPopScope(
        onWillPop: null,
        child: Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: ModalBarrier(dismissible: false, color: color),
            ),
            const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          ],
        ),
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
