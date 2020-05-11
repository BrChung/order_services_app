// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
// This is an example of whitebox testing

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:order_services_app/screens/orderable_services.dart';
import 'package:order_services_app/services/services.dart';
import 'package:order_services_app/main.dart';
import 'package:order_services_app/screens/login.dart';

void main() {
  testWidgets('Testing display of Location Item Widget...',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: LocationItem(
      location:
          Location(img: 'default.jpg', title: 'Test Location', type: 'Food'),
    )));

    final titleFinder = find.text('Test Location');
    final typeFinder = find.text('Food');

    expect(titleFinder, findsOneWidget);
    expect(typeFinder, findsOneWidget);
  });
  testWidgets('Testing display of Location Screen Widget...',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: LocationScreen(
      location: Location(
          img: 'default.jpg',
          title: 'Test Location',
          type: 'Food',
          services: [
            Service(title: "Service Item", description: "Cool item description")
          ]),
    )));

    final titleFinder = find.text('Test Location');

    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Testing display of Service List Widget...',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: ServiceList(
      location: Location(
          img: 'default.jpg',
          title: 'Test Location',
          type: 'Food',
          services: [
            Service(title: "Service Item", description: "Cool item description")
          ]),
    )));

    final serviceTitleFinder = find.text('Service Item');
    final descriptionFinder = find.text('Cool item description');

    expect(serviceTitleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
  });

  testWidgets('Testing Loading of Login Page...', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    final loginButton = find.byType(LoginButton);

    expect(loginButton, findsNWidgets(2));
  });
}
