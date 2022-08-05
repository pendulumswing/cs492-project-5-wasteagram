//--------------------------------------
// App - Controls Routing and Theme State
//--------------------------------------
import 'package:flutter/material.dart';
import 'screens/_screens.dart';

class App extends StatefulWidget {
  final String? title;

  const App({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    final routes = {
      NewWasteScreen.route: (context) => NewWasteScreen(),
      WasteDetailScreen.route: (context) => const WasteDetailScreen(),
      WasteListScreen.route: (context) => const WasteListScreen(),
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title ?? '',
      // theme: ThemeData(primarySwatch: Colors.blueGrey),
      // theme: isDark ? ThemeData.dark() : ThemeData.light(),
      routes: routes,
    );
  }
}
