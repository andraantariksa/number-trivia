import 'package:drift/drift.dart';

class NumberTrivia extends Table {
  IntColumn get id => integer()();
  TextColumn get description => text()();
}