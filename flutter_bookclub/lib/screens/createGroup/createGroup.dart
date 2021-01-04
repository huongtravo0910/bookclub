import 'package:flutter/material.dart';
import 'package:flutter_bookclub/screens/addBook/addBook.dart';
import 'package:flutter_bookclub/screens/root/rootScreen.dart';
import 'package:flutter_bookclub/services/database.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:flutter_bookclub/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {
  TextEditingController _groupNameController = TextEditingController();
  void _goToAddBook(BuildContext context, String groupName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: true,
          groupName: groupName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      hintText: "Group name",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () =>
                        _goToAddBook(context, _groupNameController.text),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: Text("Create"),
                    ),
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
