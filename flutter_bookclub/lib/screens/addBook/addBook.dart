import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookclub/models/book.dart';
import 'package:flutter_bookclub/screens/root/rootScreen.dart';
import 'package:flutter_bookclub/services/database.dart';
import 'package:flutter_bookclub/states/currentUser.dart';
import 'package:flutter_bookclub/widgets/ourContainer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OurAddBook extends StatefulWidget {
  final bool onGroupCreation;
  final String groupName;
  OurAddBook({
    this.onGroupCreation,
    this.groupName,
  });
  @override
  _OurAddBookState createState() => _OurAddBookState();
}

class _OurAddBookState extends State<OurAddBook> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked =
        await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addBook(BuildContext context, String groupName, OurBook book) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString;
    if (widget.onGroupCreation) {
      _returnString = await OurDatabase()
          .createGroup(groupName, _currentUser.getCurrentUser.uid, book);
    } else {
      _returnString = await OurDatabase()
          .addBook(_currentUser.getCurrentUser.groupId, book);
    }
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OurRootScreen()),
          (route) => false);
    }
  }

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
                  TextFormField(
                    controller: _bookNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Add book",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Add author",
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.list),
                      hintText: "Add length",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  //Should be date picker
                  Text(DateFormat.yMMMMd("en_US").format(_selectedDate)),
                  Text(DateFormat("H:mm").format(_selectedDate)),
                  FlatButton(
                    onPressed: () => _selectDate(context),
                    child: Text("Change Date"),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      OurBook book = OurBook();
                      book.name = _bookNameController.text;
                      book.author = _authorController.text;
                      book.length = int.parse(_lengthController.text);
                      book.dateCompleted = Timestamp.fromDate(_selectedDate);
                      debugPrint("Book" + book.toString());
                      debugPrint("Book Name :" + book.name.toString());
                      _addBook(context, widget.groupName, book);
                    },
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
