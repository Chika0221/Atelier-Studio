import 'package:atelier_studio/widgets/side_bar.dart';
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
          SizedBox(height: (header != null) ? 8 : 16),
          Expanded(
            child: Row(
              mainAxisSize: .max,
              children: [
                SizedBox(width: 16),
                SizedBox(
                  child: ClipRRect(
                    borderRadius: .circular(16),
                    child: SideBar(),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ClipRRect(borderRadius: .circular(16), child: body),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(height: (footer != null) ? 8 : 16),
          SizedBox(child: footer),
        ],
      ),
    );
  }
}
