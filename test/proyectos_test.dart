import 'package:flutter_test/flutter_test.dart';
import 'package:project_app/proyects/struct/struct.dart';

void main() {
  group('TEST - Proyectos', () {
    test('Verificar la carga de un proyecto', () {
      // Verifica que no hay proyectos
      final List<Projects> myproyects = [];
      expect(myproyects.length, 0);
      // Agrega un nuevo proyecto a la lista
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
