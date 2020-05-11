// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Order Services App', () {
    final anonSignInFinder = find.byValueKey("anonSignIn");

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Navigate to Services Page after Login', () async {
      await driver.tap(anonSignInFinder);
      print('Anon Sign-in was successful!');
      await driver.waitFor(find.text("Carl's Jr"));
      print("Succesfully loaded locations");
      await driver.tap(find.text("Carl's Jr"));
      await driver.waitFor(find.text("Famous Star w/ Cheese"));
      print('Successfully found services within Location');
      await driver
          .scrollIntoView(find.text('Triple Spicy Western Cheeseburger'));
      print("Scroll through services works!");
      await driver.tap(find.text('Triple Spicy Western Cheeseburger'));
      print(
          "User succesfully ordered service, please verify on Firebase database");
    });
  });
}
