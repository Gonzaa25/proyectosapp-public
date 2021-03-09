import 'package:flutter/material.dart';
import 'package:project_app/providers/color.dart';
import 'package:project_app/proyects/ui/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ColorThemeProvider())],
    child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //test CI con GitHubAction
    return MaterialApp(
      title: 'Proyectos Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: context.watch<ColorThemeProvider>().appcolor,
      ),
      home: ProjectPage(),
    );
  }
}
