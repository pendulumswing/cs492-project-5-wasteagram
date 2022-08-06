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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title ?? '',
      // theme: ThemeData(primarySwatch: Colors.blueGrey),
      theme: ThemeData.dark(),
      // theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: const WasteListScreen(),
    );
  }
}
