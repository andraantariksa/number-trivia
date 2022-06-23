import 'dart:io';

String fixtureString(String name) => File('test/fixtures/$name').readAsStringSync();
