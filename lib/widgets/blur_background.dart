import 'dart:ui';

import 'package:flutter/widgets.dart';

class BlurBackground extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
      child: Row(
        children: [
          Expanded(child: Container(color: Color(0xFFFF0000))),
          Expanded(child: Container(color: Color(0xFF00FF00))),
          Expanded(child: Container(color: Color(0xFF0000FF))),
        ],
      ),
      // child: Image.network("https://picsum.photos/500/300", fit: .fitHeight),
    );
  }
}
