import 'package:flutter/widgets.dart';

class NormalLayout extends StatelessWidget {
  const new({
    super.key,
    required this.body,
    this.header,
    this.footer,
    this.sideBar,
  });

  final Widget body;
  final Widget? header;
  final Widget? footer;
  final Widget? sideBar;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisSize: .max,
        children: [
          SizedBox(child: header),
          SizedBox(height: 8),
          Expanded(
            child: Row(
              mainAxisSize: .max,
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: .horizontal(right: .circular(16)),
                    child: sideBar,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: .horizontal(left: .circular(16)),
                    child: body,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(child: footer),
        ],
      ),
    );
  }
}
