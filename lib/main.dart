import 'package:flutter/material.dart';
import 'package:my_notes/data/drift_database.dart';
import 'package:my_notes/ui/create_note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/create_new_note': (context) => CreateNoteScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          Column(
            children: [
              StreamBuilder(
                stream: MyDatabase().watchAllEntries(Note),
                builder: (context, AsyncSnapshot<List<Note>> snapshot) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${snapshot.data?[index].title}'),
                          subtitle: Text('${snapshot.data?[index].content}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_new_note');
        },
        tooltip: 'Create New Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
