import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:number_trivia/features/number_trivia/data/database/table/number_trivia.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [NumberTrivia])
class NumberTriviaDatabase extends _$NumberTriviaDatabase {
  NumberTriviaDatabase() : super(openConnection());

  @override
  int get schemaVersion => 0;

  Future<void> insertNumberTrivia(NumberTriviaData numberTrivia) =>
      into(this.numberTrivia).insert(numberTrivia);

  Future<NumberTriviaData?> getNumberTrivia(int id) =>
      (select(numberTrivia)..where((tbl) => tbl.number.equals(id))).getSingleOrNull();
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final opener = File(path.join(dbFolder.path, "db.sqlite"));
    return NativeDatabase(opener);
  });
}
