import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kindainternship/data/data.dart';
import 'package:kindainternship/screens/single_question_screen.dart';
import 'package:kindainternship/components/custom_topic_widget.dart';

List<int> listId = [];

class CustomFullQuestionWidget extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final DateTime pubDate;
  final int likes;
  final int dislikes;
  final String imageUrl;
  final List answers;
  final List comment;
  final int answerCount;
  final bool userVote;
  final int subjectId;
  final String subjectName;

  final bool myQuestions;
  final bool myAnswer;
  final String answerText;
  CustomFullQuestionWidget(
      {@required this.id,
      this.title,
      this.description,
      this.pubDate,
      this.likes = 0,
      this.dislikes = 0,
      this.imageUrl = 'https://placeimg.com/640/480/any',
      this.userVote,
      this.answerCount,
      this.answers,
      this.comment,
      this.myQuestions = false,
      this.myAnswer = false,
      this.answerText,
      this.subjectId,
      this.subjectName});
  @override
  _CustomFullQuestionWidgetState createState() =>
      _CustomFullQuestionWidgetState();
}

class _CustomFullQuestionWidgetState extends State<CustomFullQuestionWidget> {
  bool added = false;
  dynamic response;
  dynamic data;

  @override
  void dispose() {
    super.dispose();
    listId.remove(widget.id);
  }

  bool userVoteCheck;
  bool userLikeCheck = false;
  bool userDislikeCheck = false;
  int likes1;
  int dislikes1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double num4 = height * 0.0057;
    double num5 = height * 0.0071;
    double num7 = height * 0.0099;
    double num12 = height * 0.0170;
    double num14 = height * 0.0198;
    double num15 = height * 0.0212;
    double num16 = height * 0.0227;
    double num17 = height * 0.0241;
    double num18 = height * 0.0255;
    double num20 = height * 0.0283;
    double num22 = height * 0.0312;
    double num28 = height * 0.0397;

    if (!listId.contains(widget.id)) {
      listId.add(widget.id);
      added = true;
    }
    return added
        ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: num15),
                widget.myQuestions
                    ? SizedBox(width: 0)
                    : Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: num17,
                            backgroundColor: Color(0xffE5E5E5),
                            backgroundImage: NetworkImage(
                                'https://placeimg.com/640/480/any'),
                          ),
                          SizedBox(width: num7),
                          Text(
                            'Alex Conor',
                            style: TextStyle(color: Color(0xFF828282)),
                          ),
                        ],
                      ),
                widget.myQuestions
                    ? SizedBox(width: 0)
                    : SizedBox(height: num12),
                widget.title == null
                    ? Text(
                        'no data',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.myQuestions ? num20 : num22,
                            fontWeight: widget.myQuestions
                                ? FontWeight.w400
                                : FontWeight.w500),
                      )
                    : Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.myQuestions ? num20 : num22,
                            fontWeight: widget.myQuestions
                                ? FontWeight.w400
                                : FontWeight.w500),
                      ),
                SizedBox(height: num14),
                widget.myAnswer
                    ? Text(
                        widget.answerText,
                        style: TextStyle(
                            color: Color(0xFF828282), fontSize: num16),
                      )
                    : SizedBox(width: 0),
                widget.myAnswer ? SizedBox(height: num14) : SizedBox(width: 0),
                widget.myQuestions
                    ? SizedBox(width: 0)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CustomTopicWidget(
                              topic: widget.subjectName, isFull: true),
                        ],
                      ),
                widget.myQuestions
                    ? SizedBox(width: 0)
                    : SizedBox(height: num14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: num28),
                    Icon(
                      Icons.message,
                      size: num18,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        widget.answers == null
                            ? '0'
                            : widget.answers.length.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: num20,
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      child: !userLikeCheck
                          ? widget.userVote == true
                              ? Icon(
                                  Icons.thumb_up,
                                  size: num18,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.thumb_up,
                                  size: num18,
                                  color: Colors.grey,
                                )
                          : userVoteCheck == true
                              ? Icon(
                                  Icons.thumb_up,
                                  size: num18,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.thumb_up,
                                  size: num18,
                                  color: Colors.grey,
                                ),
                      onTap: () async {
                        try {
                          response = await Like(
                                  value: 'True',
                                  id: widget.id.toInt(),
                                  context: context)
                              .like();
                          if (response.statusCode == 200 ||
                              response.statusCode == 201 ||
                              response.statusCode == 202) {
                            data = jsonDecode(response.body);
                            print(data);
                            setState(() {
                              userVoteCheck = data['data'][0]['user_vote'];
                              userLikeCheck = true;
                              likes1 = data['data'][0]['likes'];
                              userDislikeCheck = true;
                              dislikes1 = data['data'][0]['dislikes'];
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        likes1 == null
                            ? widget.likes.toString()
                            : likes1.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: num5),
                    GestureDetector(
                      child: !userDislikeCheck
                          ? widget.userVote == false
                              ? Icon(
                                  Icons.thumb_down,
                                  size: num18,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.thumb_down,
                                  size: num18,
                                  color: Colors.grey,
                                )
                          : userVoteCheck == false
                              ? Icon(
                                  Icons.thumb_down,
                                  size: num18,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.thumb_down,
                                  size: num18,
                                  color: Colors.grey,
                                ),
                      onTap: () async {
                        try {
                          response = await Like(
                                  value: 'false',
                                  id: widget.id.toInt(),
                                  context: context)
                              .like();
                          if (response.statusCode == 200 ||
                              response.statusCode == 201 ||
                              response.statusCode == 202) {
                            data = jsonDecode(response.body);
                            print(data);
                            setState(() {
                              userVoteCheck = data['data'][0]['user_vote'];
                              userDislikeCheck = true;
                              dislikes1 = data['data'][0]['dislikes'];
                              userLikeCheck = true;
                              likes1 = data['data'][0]['likes'];
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        dislikes1 == null
                            ? widget.dislikes.toString()
                            : dislikes1.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Spacer(),
                    widget.myQuestions
                        ? SizedBox(width: 0)
                        : FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SingleQuestionScreen.id,
                                  arguments: {
                                    'id': widget.id,
                                  });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                            child: Text(
                              'Answer',
                              style: TextStyle(
                                color: Color(0xFFFF7A00),
                              ),
                            )),
                  ],
                ),
                SizedBox(height: num4),
                Divider(
                  color: Color(0xFFFF7A00),
                  thickness: 1,
                ),
              ],
            ),
          )
        : Container();
  }
}
