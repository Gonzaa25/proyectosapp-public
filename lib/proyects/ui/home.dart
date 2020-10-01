import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/proyects/struct/struct.dart';
import 'package:project_app/proyects/ui/projectdetail.dart';
import 'package:project_app/proyects/ui/addprojectpage.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  static List<Projects> myprojects = [];

  AnimationController controller;
  Animation animation;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    _tabController.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Projects> pendingprojects =
        myprojects.where((project) => project.isCompleted == false).toList();
    List<Projects> completeprojects =
        myprojects.where((project) => project.isCompleted == true).toList();
    final white = SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: white,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title:
              Text("Mis Proyectos", style: Theme.of(context).textTheme.title),
        ),
        body: myprojects.length <= 0
            ? Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("No hay proyectos aún",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(
                          "Haz click en el boton de agregar para\n cargar un proyecto nuevo",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center),
                      SizedBox(height: 10),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("AGREGAR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddProjectPage(
                                        proyectslist: myprojects)));
                          },
                          color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(color: Colors.black),
                      indicatorColor: Theme.of(context).primaryColor,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: "En Curso",
                        ),
                        Tab(
                          text: "Completados",
                        ),
                      ]),
                  Expanded(
                    flex: 1,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        RefreshIndicator(
                          onRefresh: () {
                            setState(() {
                              controller.reset();
                              controller.forward();
                            });
                            var future = new Future.value();
                            return future;
                          },
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: ListView.builder(
                                itemCount: pendingprojects.length,
                                padding: EdgeInsets.only(top: 10),
                                itemBuilder: (context, index) {
                                  int totaltasks =
                                      pendingprojects[index].tasks.length;
                                  int i = 0;
                                  int completedtasks = 0;
                                  for (i = 0; i < totaltasks; i++) {
                                    if (pendingprojects[index]
                                        .tasks[i]
                                        .isCompleted) {
                                      completedtasks += 1;
                                    }
                                  }
                                  final dif = pendingprojects[index]
                                      .endDate
                                      .difference(DateTime.now());
                                  final txtDays = dif.inDays + 1 <= 1
                                      ? 'día para el cierre!'
                                      : 'días para el cierre.';
                                  double value = 0.0;
                                  if (completedtasks > 0) {
                                    value = (completedtasks.toDouble() * 1) /
                                        totaltasks;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProjectDetail(
                                                        proyect:
                                                            pendingprojects[
                                                                index],
                                                        pendingproyects:
                                                            pendingprojects,
                                                        completeproyects:
                                                            completeprojects,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                  title: Text(
                                                      pendingprojects[index]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22)),
                                                  subtitle: Text("Creado por: " +
                                                      pendingprojects[index]
                                                          .owner +
                                                      '\nTe queda ${dif.inDays + 1} $txtDays'),
                                                  trailing: Material(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      color: Colors.greenAccent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "En Curso",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ))),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Tareas ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text("   " +
                                                            completedtasks
                                                                .toString() +
                                                            "/" +
                                                            totaltasks
                                                                .toString())
                                                      ],
                                                    )),
                                                    Column(children: <Widget>[
                                                      Text("FECHA DE CIERRE",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 15)),
                                                      Text(
                                                          pendingprojects[index]
                                                              .endDate
                                                              .toString()
                                                              .substring(0, 10),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                    ]),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: LinearProgressIndicator(
                                                  value:
                                                      value * animation.value,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListView.builder(
                              itemCount: completeprojects.length,
                              padding: EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) {
                                int totaltasks =
                                    completeprojects[index].tasks.length;
                                int i = 0;
                                int completedtasks = 0;
                                for (i = 0; i < totaltasks; i++) {
                                  if (completeprojects[index]
                                      .tasks[i]
                                      .isCompleted) {
                                    completedtasks += 1;
                                  }
                                }
                                double value = 0.0;
                                if (completedtasks > 0) {
                                  value = (completedtasks.toDouble() * 1) /
                                      totaltasks;
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectDetail(
                                                      proyect: completeprojects[
                                                          index],
                                                      pendingproyects:
                                                          pendingprojects,
                                                      completeproyects:
                                                          completeprojects,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                                title: Text(
                                                    completeprojects[index]
                                                        .name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22)),
                                                subtitle: Text("Creado por: " +
                                                    completeprojects[index]
                                                        .owner),
                                                trailing: Material(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    color: Colors.greenAccent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Completado",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ))),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "Tareas ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text("   " +
                                                          completedtasks
                                                              .toString() +
                                                          "/" +
                                                          totaltasks.toString())
                                                    ],
                                                  )),
                                                  Column(children: <Widget>[
                                                    Text("FECHA DE CIERRE",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 15)),
                                                    Text(
                                                        completeprojects[index]
                                                            .endDate
                                                            .toString()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: LinearProgressIndicator(
                                                value: value * animation.value,
                                                backgroundColor:
                                                    Colors.grey[200],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: _tabController.index == 0 && myprojects.length > 0
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 10,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProjectPage(proyectslist: myprojects)));
                },
                child: Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }
}
