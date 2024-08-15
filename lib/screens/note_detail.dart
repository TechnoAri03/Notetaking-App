import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqlite_app/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_app/models/note.dart';
import 'package:sqlite_app/utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  NoteDetail(this.appBarTitle);

  // const NoteDetail({super.key});
  @override
  State<NoteDetail> createState() => _NoteDetailState(this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;

  static var _priorities = ['High', 'Low'];
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  _NoteDetailState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 16, 247, 255),
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectionByUser) {
                  setState(() {
                    debugPrint('user selected $valueSelectionByUser');
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleControler,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Second chaned in Title text field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionControler,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('changd in descretion text field.');
                },
                decoration: InputDecoration(
                    labelText: 'Descreption',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 25, 5, 248),
                        elevation: 5,
                        // textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Saved button clicked');
                        });
                      },
                      child: Text(
                        'save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 25, 5, 248),
                        elevation: 5,
                        // textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete button clicked');
                        });
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
