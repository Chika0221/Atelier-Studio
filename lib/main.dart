import 'package:atelier_studio/home_page/home_page.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/widgets.dart';

void main() {
  // boxTheme.changeTheme(Color(0xFFfcf9eb), Color(0xFF000000));
  boxTheme.changeTheme(
    Color.fromARGB(255, 18, 168, 209),
    Color.fromARGB(255, 251, 252, 252),
    primaryFontFamily: "Black Ops One",
    secondaryFontFamily: "Kosugi Maru",
  );
  runApp(StudioApp());

  doWhenWindowReady(() {
    const initialSize = Size(720, 500);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;

    appWindow.show();
  });
}

class StudioApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0x00000000),
      debugShowCheckedModeBanner: false,
      textStyle: boxTheme.setTextStyle(),
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
