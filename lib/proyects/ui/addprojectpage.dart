import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/proyects/struct/struct.dart';

class AddProjectPage extends StatefulWidget {
  final List<Projects>? proyectslist;
  AddProjectPage({this.proyectslist});
  @override
  State<StatefulWidget> createState() => AddProjectPageState();
}

class AddProjectPageState extends State<AddProjectPage> {
  DateTime? selecteddate = DateTime.now();
  List<Tasks> taskslist = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController projectcontroller = TextEditingController();
  TextEditingController taskcontroller = TextEditingController();
  Projects newproject = Projects(
      name: "",
      owner: "",
      tasks: [],
      endDate: DateTime.now(),
      isCompleted: false);

  @override
  void dispose() {
    projectcontroller.dispose();
    taskcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final white = SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: white,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                  onPressed: () {
                    newproject.name = projectcontroller.value.text;
                    newproject.owner = "Test User";
                    newproject.endDate = selecteddate;
                    newproject.isCompleted = false;
                    if (newproject.tasks.length > 0 && newproject.name != "") {
                      widget.proyectslist!.add(newproject);
                      setState(() {});
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Los campos de nombre y tareas no pueden estar vacios"),
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 1000)));
                    }
                  },
                  icon: Icon(Icons.save, color: Colors.white),
                  label: Text('Guardar',
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          controller: projectcontroller,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              labelText: "Nombre del proyecto",
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      width: 5.0, color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.white))),
                        )),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2022),
                        );
                        print("fecha" + date.toString());
                        setState(() {
                          selecteddate = date;
                        });
                      },
                      child: Text("Fecha de cierre",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    SizedBox(height: 8),
                    Text(selecteddate.toString().substring(0, 10),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height / 4) - 160),
                    Expanded(
                      child: ListView.builder(
                          itemCount: newproject.tasks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(newproject.tasks[index].name));
                          }),
                    )
                  ],
                ),
              ),
              Positioned(
                  right: 50,
                  top: MediaQuery.of(context).size.height / 4 - 30,
                  child: FloatingActionButton(
                      heroTag: "addtask",
                      elevation: 10,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text("Nueva tarea"),
                                  content: TextFormField(
                                    key: _formKey,
                                    controller: taskcontroller,
                                    decoration: InputDecoration.collapsed(
                                        hintText: "Nombre de la tarea"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          taskcontroller.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "CANCELAR",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {
                                          newproject.tasks.add(Tasks(
                                              name: taskcontroller.value.text,
                                              isCompleted: false));
                                          taskcontroller.clear();
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "INGRESAR",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ));
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
