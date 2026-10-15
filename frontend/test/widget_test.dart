import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('App launches login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FinGuardAI());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
