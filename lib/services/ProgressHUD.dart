import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  late final Widget child;
  late final bool inAsyncCall;
  late final double opacity;
  late final Color color;

  ProgressHUD({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.brown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          new Center (
            child: new CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFCC13A)),
              backgroundColor: Color(0xFF5B3415),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
        children: widgetList,
    );
  }
}
