import 'package:flutter/widgets.dart';

class MyColoredBox extends StatelessWidget {


  const MyColoredBox({
    super.key,
    this.width = 100,
    this.height = 100,
    this.color = const Color.fromARGB(235, 255, 251, 251),
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color),
    );
  }
}
