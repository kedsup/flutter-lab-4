import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab4/main.dart';
import 'package:lab4/pages/home_page.dart';
import 'package:lab4/pages/page_2.dart';
import 'package:lab4/theme/colors.dart';

class RootPage extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route by Class'),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text('Open route'),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
              print(result);
            }),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Come back!');
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class NamedRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Named route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Route by name with arguments'),
          onPressed: () {
            Navigator.pushNamed(context, '/second',
                arguments: NamedRouteScreenArguments('Save the world'));
          },
        ),
      ),
    );
  }
}

class _RootAppState extends State<RootPage> {
  int page = 0;
  int liftedCounter = 0;

  void _incrementCounter() {
    setState(() {
      liftedCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeIndex = MyApp.mainSharedPreferences?.getInt("selectedThemeIndex");
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: themeIndex == 0 ? white : black,
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      Center(
        child: Text(
          "Page 1, lifted state = $liftedCounter",
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
      Page2(),
      Center(
        child: FirstRoute(),
      ),
      NamedRouteScreen(),
    ];
    return IndexedStack(
      index: page,
      children: pages,
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () {
                  var current =
                      MyApp.mainSharedPreferences?.getInt("selectedThemeIndex");
                  MyApp.mainSharedPreferences
                      .setInt("selectedThemeIndex", current == 0 ? 1 : 0)
                      .then((a) {
                    setState(() {});
                  });
                },
                child: SvgPicture.asset(
                  "public/images/camera_icon.svg",
                  width: 30,
                )),
            Text(
              "Instagram",
              style: TextStyle(fontSize: 25),
            ),
            SvgPicture.asset(
              "public/images/message_icon.svg",
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomNavigationBar() {
    List bottomItems = [
      "public/images/home_active_icon.svg",
      "public/images/search_icon.svg",
      "public/images/upload_icon.svg",
      "public/images/love_icon.svg",
      "public/images/account_icon.svg",
    ];
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(color: appFooterColor),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  setState(() {
                    page = index;
                  });
                },
                child: SvgPicture.asset(
                  bottomItems[index],
                  width: 27,
                ));
          }),
        ),
      ),
    );
  }
}
