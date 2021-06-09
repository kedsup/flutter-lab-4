import 'package:flutter/material.dart';
import 'package:lab4/pages/root_page.dart';
import 'package:lab4/models/story_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamedRouteScreenArguments {
  final String message;

  NamedRouteScreenArguments(this.message);
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NamedRouteScreenArguments args =
        ModalRoute.of(context).settings.arguments as NamedRouteScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Message: ${args.message}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  static SharedPreferences mainSharedPreferences;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _loadApp() async {
    MyApp.mainSharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => StoryModel(),
        child: RootPage(),
      ),
      initialRoute: '/',
      routes: {
        '/first': (context) => NamedRouteScreen(),
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

void main() {
  runApp(new MyApp());
}
