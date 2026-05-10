import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_gradebook/main.dart';

void main() {
  testWidgets('shows initial gradebook dashboard', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('My Grades'), findsOneWidget);
    expect(find.text('Overall Average'), findsOneWidget);
    expect(find.text('Subjects'), findsOneWidget);
    expect(find.text('Mathematics'), findsOneWidget);
    expect(find.text('Programming'), findsOneWidget);
    expect(find.text('Physics'), findsOneWidget);
  });

  testWidgets('opens add subject dialog from floating action button', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Add Subject'), findsOneWidget);
    expect(find.text('Subject Name'), findsOneWidget);
    expect(find.text('Icon (Emoji)'), findsOneWidget);
  });
}
