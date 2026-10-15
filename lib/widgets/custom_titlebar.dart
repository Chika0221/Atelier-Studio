import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/widgets.dart';

class CostomTitlebar extends StatefulWidget {
  const new({super.key, this.title});

  final String? title;

  @override
  State<CostomTitlebar> createState() => _CostomTitlebarState();
}

class _CostomTitlebarState extends State<CostomTitlebar> {
  @override
  Widget build(BuildContext context) {
    final WindowButtonColors buttonColor = WindowButtonColors(
      iconNormal: boxTheme.accent,
    );

    return SizedBox(
      child: Stack(
        children: [
          if (widget.title != null)
            Positioned.fill(child: Center(child: Text(widget.title!))),
          Row(
            children: [
              Expanded(child: WindowTitleBarBox(child: MoveWindow())),
              MinimizeWindowButton(colors: buttonColor),
              MaximizeWindowButton(colors: buttonColor),
              CloseWindowButton(colors: buttonColor),
            ],
          ),
        ],
      ),
    );
  }
}
