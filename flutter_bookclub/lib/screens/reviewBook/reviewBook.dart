import 'package:flutter/material.dart';
import 'package:flutter_bookclub/states/currentGroup.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:flutter_bookclub/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurReview extends StatefulWidget {
  final CurrentGroup currentGroup;
  OurReview({this.currentGroup});
  @override
  _OurReviewState createState() => _OurReviewState();
}

class _OurReviewState extends State<OurReview> {
  TextEditingController _reviewController = TextEditingController();
  int _dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Rate book 1-10:    "),
                      DropdownButton<int>(
                          items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          value: _dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 10,
                          dropdownColor: Colors.white,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                          onChanged: (int newValue) {
                            setState(() {
                              _dropdownValue = newValue;
                            });
                          }),
                    ],
                  ),
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Add Review",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: Text("Add"),
                    ),
                    onPressed: () {
                      String uid =
                          Provider.of<CurrentUser>(context, listen: false)
                              .getCurrentUser
                              .uid;
                      widget.currentGroup.finishedBook(
                          uid, _dropdownValue, _reviewController.text);
                      debugPrint("IsBookDone? " +
                          widget.currentGroup.getIsDoneWithCurrentBook
                              .toString());
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
