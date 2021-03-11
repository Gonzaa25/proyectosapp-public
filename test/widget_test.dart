// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_app/main.dart';

void main() {
  group('WIDGETS', () {
    testWidgets(
        '- Verificar que se muestra el mensaje de no hay proyectos al iniciar la app',
        (WidgetTester tester) async {
      // Compila la app
      await tester.pumpWidget(MyApp());
      // Verifica que no hay proyectos y empieza con el texto en pantalla
      expect(find.text("No hay proyectos aún"), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'AGREGAR'), findsOneWidget);
    });
  });
}
