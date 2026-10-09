import 'package:box_ui/box_ui.dart';
import 'package:box_ui/compornents/button.dart';
import 'package:flutter/widgets.dart';

void main() {
  theme.changeTheme(Color(0xFFfcf9eb), Color(0xFF000000));
  runApp(StudioApp());
}

class StudioApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: theme.background,
      home: HomePage(),
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
        return PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, _, __) => builder(context),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Button(label: "HELLO", width: 300, height: 100),
          SizedBox(width: 300, height: 100, child: Button(label: "HELLO")),
        ],
      ),
    );
  }
}
