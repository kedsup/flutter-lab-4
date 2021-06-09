import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab4/theme/colors.dart';
import 'package:lab4/mocks/posts.dart';
import 'package:lab4/mocks/stories.dart';
import 'package:lab4/widgets/story.dart';

import '../widgets/post.dart';

import 'package:http/http.dart' as http;

Future<Users> fetchUsers() async {
  final response = await http
      .get(Uri.https('jsonplaceholder.typicode.com', 'users'))
      .then((value) {
    print(value.body);
    return value;
  });

  if (response.statusCode == 200) {
    return Users.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load users');
  }
}

class Users {
  final List<String> usernames;

  Users({@required this.usernames});

  factory Users.fromJson(List<dynamic> json) {
    List<String> usernames = json.map((u) => u['username'].toString()).toList();
    print(usernames);
    return Users(usernames: usernames);
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Users> users;

  @override
  void initState() {
    users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Users>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getBody(snapshot.data.usernames);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget getBody(List<String> users) {
    var textColor = getThemeColor();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 19,
                                    height: 19,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: textColor),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: buttonFollowColor,
                                      size: 19,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                      children: List.generate(stories.length, (index) {
                    return Story(
                      name: users[index],
                    );
                  })),
                ],
              ),
            ),
          ),
          Divider(
            color: textColor.withOpacity(0.3),
          ),
          Column(
            children: List.generate(posts.length, (index) {
              return Post(
                name: posts[index]['name'],
                description: posts[index]['description'],
                isLiked: posts[index]['isLiked'],
                viewCount: posts[index]['commentCount'],
                likedBy: posts[index]['likedBy'],
                dayAgo: posts[index]['dayAgo'],
                // stateCallback: this.stateCallback,
              );
            }),
          )
        ],
      ),
    );
  }
}
