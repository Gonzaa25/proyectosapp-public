import 'package:flutter/material.dart';
import 'package:project_app/providers/color.dart';
import 'package:project_app/proyects/ui/home.dart';
import 'package:provider/provider.dart';
import 'configs/configure_nonweb.dart'
    if (dart.library.html) 'configs/configure_web.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorThemeProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Proyectos Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: context.watch<ColorThemeProvider>().appcolor,
          ),
          home: ProjectPage(),
        );
      },
    );
  }
}
