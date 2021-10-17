import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mynotedb.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(tables: [Notes])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<int> createNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  Future<List<Note>> get allNoteEntries => select(notes).get();

  Stream<List<Note>> watchNoteEntries(Note) => select(notes).watch();

  Stream<List<Note>> watchAllEntries($NotesTable) => select(notes).watch();

  Future updateNote(Note note) => update(notes).replace(note);

  Future deleteNote(Note id) => delete(notes).delete(id);
}
