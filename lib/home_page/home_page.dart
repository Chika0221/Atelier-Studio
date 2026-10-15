import 'package:atelier_studio/widgets/custom_titlebar.dart';
import 'package:atelier_studio/widgets/normal_layout.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: .circular(8),
      child: Container(
        color: boxTheme.background,
        child: NormalLayout(
          header: CostomTitlebar(),
          body: Container(color: boxTheme.accent),
          sideBar: Container(width: 300, color: boxTheme.accent),
        ),
      ),
    );
  }
}
