// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:project_app/main.dart';
import 'package:project_app/proyects/struct/struct.dart';

void main() {
  group('Default tests', () {
    testWidgets('Verificar que no hay proyectos cargados al iniciar',
        (WidgetTester tester) async {
      // Compila la app
      await tester.pumpWidget(MyApp());
      // Verifica que no hay proyectos
      expect(find.text("No hay proyectos aún"), findsOneWidget);
    });
    testWidgets('Verificar la carga de un proyecto',
        (WidgetTester tester) async {
      // Compila la app
      await tester.pumpWidget(MyApp());
      // Verifica que no hay proyectos
      final List<Projects> myproyects = [];
      expect(myproyects.length, 0);
      myproyects.add(Projects(
          name: 'name',
          owner: 'owner',
          tasks: [],
          endDate: DateTime.now(),
          isCompleted: false));
      expect(myproyects.length, 1);
    });
  });
}
