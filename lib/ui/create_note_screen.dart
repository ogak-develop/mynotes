import 'package:flutter/material.dart';
import 'package:my_notes/data/drift_database.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('New Notes'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(18, 5, 18, 5),
        children: [
          Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: content,
                decoration: InputDecoration(hintText: 'Notes here...'),
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            MyDatabase().createNote(NotesCompanion.insert(
                title: title.text, content: content.text));
            title.clear();
            content.clear();
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
