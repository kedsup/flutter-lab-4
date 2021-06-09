import 'package:flutter/material.dart';
import 'package:lab4/main.dart';
import 'package:lab4/theme/colors.dart';
import 'package:lab4/models/story_model.dart';
import 'package:provider/provider.dart';

class Story extends StatelessWidget {
  final String name;
  const Story({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = getThemeColor();
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {
                var counter = context.read<StoryModel>();
                counter.add();
              },
              child: Container(
                width: 68,
                height: 68,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: black, width: 2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )),
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
    );
  }
}
