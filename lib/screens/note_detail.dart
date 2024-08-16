import 'package:flutter/material.dart';
import 'package:sqlite_app/models/note.dart';
import 'package:path/path.dart';
import 'package:sqlite_app/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:sqlite_app/utils/database_helper.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;

  final Note note;
  NoteDetail(this.note, this.appBarTitle, {super.key});

  // const NoteDetail({super.key});
  @override
  State<NoteDetail> createState() =>
      _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;

  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  _NoteDetailState(this.note, this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    titleControler.text = note.title;
    descriptionControler.text = note.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 247, 255),
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
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
                value: getPriorityAsString(note.priority),
                onChanged: (valueSelectionByUser) {
                  setState(() {
                    debugPrint('user selected $valueSelectionByUser');
                    updatePriorityAsInt(valueSelectionByUser!);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleControler,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Second chaned in Title text field');
                  updateTitle();
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionControler,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('changd in descretion text field.');
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: 'Descreption',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 25, 5, 248),
                        elevation: 5,
                        // textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Saved button clicked');
                        });
                      },
                      child: const Text(
                        'save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 25, 5, 248),
                        elevation: 5,
                        // textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete button clicked');
                        });
                      },
                      child: const Text(
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

  // void noveToNextScreen() {
  //   Navigator.pop(context);
  // }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    late String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleControler.text;
  }

  void updateDescription() {
    note.description = descriptionControler.text;
  }

  void _save() async {
    int result;

    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }
  }
}
