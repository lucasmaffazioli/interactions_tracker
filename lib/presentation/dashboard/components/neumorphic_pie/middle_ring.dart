import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';

class MiddleRing extends StatelessWidget {
  final num width;
  final Widget child;

  const MiddleRing({Key key, @required this.width, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      child: Center(child: child),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          // Edge shadow
          Constants.boxShadow,
        ],
      ),
      // child: Center(
      //   child: Container(
      //     height: width * 0.3,
      //     width: width * 0.3,
      //     decoration: BoxDecoration(
      //       color: Colors.red,
      //       shape: BoxShape.circle,
      //       boxShadow: [
      //         // Edge shadow
      //         BoxShadow(
      //           offset: Offset(-1.5, -1.5),
      //           color: Colors.black45,
      //           spreadRadius: 2.0,
      //           // blurRadius: 0,
      //         ),

      //         // Circular shadow
      //         BoxShadow(
      //           offset: Offset(1.5, 1.5),
      //           color: Colors.white,
      //           spreadRadius: 2.0,
      //           blurRadius: 4,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
