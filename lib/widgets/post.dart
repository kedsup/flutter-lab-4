import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab4/main.dart';
import 'package:lab4/models/story_model.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class Post extends StatelessWidget {
  final String name;
  final String description;
  final isLiked;
  final String likedBy;
  final String viewCount;
  final String dayAgo;
  final stateCallback;
  const Post({
    Key key,
    this.name,
    this.isLiked,
    this.likedBy,
    this.viewCount,
    this.dayAgo,
    this.description,
    this.stateCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = getThemeColor();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Icon(
                  LineIcons.verticalEllipsis,
                  color: textColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(color: Colors.purple),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    isLiked
                        ? SvgPicture.asset(
                            "public/images/loved_icon.svg",
                            width: 27,
                          )
                        : SvgPicture.asset(
                            "public/images/love_icon.svg",
                            width: 27,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          this.stateCallback();
                        },
                        child: SvgPicture.asset(
                          "public/images/comment_icon.svg",
                          width: 27,
                          color: textColor,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Provider.of<StoryModel>(context, listen: false)
                              .clear();
                        },
                        child: SvgPicture.asset(
                          "public/images/message_icon.svg",
                          width: 27,
                          color: textColor,
                        )),
                  ],
                ),
                SvgPicture.asset(
                  "public/images/save_icon.svg",
                  width: 27,
                  color: textColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Liked by ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor)),
              TextSpan(
                  text: "$likedBy ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor)),
              TextSpan(
                  text: "and 5 ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor)),
              TextSpan(
                  text: "Others",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor)),
            ])),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "$name ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textColor)),
                TextSpan(
                    text: "$description",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: textColor)),
              ]))),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "View $viewCount comments",
              style: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Add a comment...",
                        style: TextStyle(
                            color: textColor.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "😆",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "🤩",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.add_circle,
                        color: textColor.withOpacity(0.5),
                        size: 18,
                      )
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "$dayAgo",
              style: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
