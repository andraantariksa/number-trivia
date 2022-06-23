import 'package:drift/drift.dart';

class NumberTrivia extends Table {
  IntColumn get number => integer()();
  TextColumn get description => text()();
}