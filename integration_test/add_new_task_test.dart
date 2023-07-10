import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/domain/models/importance.dart';
import 'test_main.dart' as test_main;

void main() {
  testWidgets("add and editn't new task", (widgetTester) async {
    test_main.main();

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(FloatingActionButton).first);
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(TextField).first, 'New task');
    await widgetTester.pumpAndSettle();

    final a = find.text("СОХРАНИТЬ").first;
    await widgetTester.tap(a);
    await widgetTester.pumpAndSettle();
    expect(find.text('New task'), findsAtLeastNWidgets(1));

    await widgetTester.tap(find.text('New task').first);
    await widgetTester.pumpAndSettle();
    expect(find.byType(DropdownButton<Importance>), findsOneWidget);

    await widgetTester.enterText(find.byType(TextField).first, 'Edited task');
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(CloseButton).first);
    await widgetTester.pumpAndSettle();
    expect(find.text('New task'), findsAtLeastNWidgets(1));
  });
}