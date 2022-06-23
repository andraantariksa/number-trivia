import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/common/platform/network_info.dart';

class InternetConnectionCheckerMock extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfo networkInfo;
  late InternetConnectionCheckerMock connectionChecker;

  setUp(() {
    connectionChecker = InternetConnectionCheckerMock();
    networkInfo = NetworkInfoImpl(connectionChecker);
  });

  test("should forward the returned value from a library", () async {
    when(() => connectionChecker.hasConnection).thenAnswer((_) => Future.value(true));

    expect(true, await networkInfo.isConnected);
  });
}
