import 'package:flutter/material.dart';
import 'package:sqlite_app/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_app/models/note.dart';
import 'package:sqlite_app/utils/database_helper.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 103, 184),
        title: Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: getNoteListview(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 104, 2, 127),
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDeatails('Add Note');
        },
        tooltip: 'Add note',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  ListView getNoteListview() {
    TextStyle? titleStyle = Theme.of(context).textTheme.displayMedium;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text('Dummy Title', style: titleStyle),
            subtitle: Text('Dummy Date'),
            trailing: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint("lst_title tapped");
              navigateToDeatails('Edit Note');
            },
          ),
        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackbar(context, 'Note deleted successfully!');
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showBodyScrim(snackbar);
  }

  void navigateToDeatails(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }
}
