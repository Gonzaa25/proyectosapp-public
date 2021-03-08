import 'package:flutter/material.dart';
import 'package:project_app/providers/color.dart';
import 'package:provider/provider.dart';

class CustomColorPicker extends StatefulWidget {
  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                context.read<ColorThemeProvider>().changeAppColor(Colors.red);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<ColorThemeProvider>().changeAppColor(Colors.green);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              ),
            ),
            InkWell(
              onTap: () {
                context
                    .read<ColorThemeProvider>()
                    .changeAppColor(Colors.orange);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                context
                    .read<ColorThemeProvider>()
                    .changeAppColor(Colors.purple);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.purple),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<ColorThemeProvider>().changeAppColor(Colors.teal);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<ColorThemeProvider>().changeAppColor(Colors.amber);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
              ),
            )
          ],
        )
      ],
    );
  }
}
