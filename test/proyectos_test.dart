import 'package:flutter_test/flutter_test.dart';
import 'package:project_app/proyects/struct/struct.dart';
import 'package:project_app/proyects/ui/home.dart';

void main() {
  group('PROYECTOS', () {
    test('- Verificar que la cantidad de proyectos arranca en cero', () {
      expect(ProjectPageState.myprojects.length, 0);
    });
    test(
        '- Verificar que al cargar un proyecto la lista pase a tener un registro',
        () {
      ProjectPageState.myprojects.add(Projects(
          name: 'name',
          owner: 'owner',
          tasks: [],
          endDate: DateTime.now(),
          isCompleted: false));
      expect(ProjectPageState.myprojects.length, 1);
      expect(ProjectPageState.myprojects[0].tasks, isNotNull);
    });
  });
}
