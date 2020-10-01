import 'package:flutter/material.dart';

class Projects {
  String name;
  String owner;
  List<ProjectUsers> users;
  List<Tasks> tasks;
  DateTime endDate;
  bool isCompleted;
  Projects(
      {@required this.name,
      @required this.owner,
      @required this.tasks,
      this.users,
      @required this.endDate,
      @required this.isCompleted});
}

class Tasks {
  String name;
  bool isCompleted;
  Tasks({@required this.name, @required this.isCompleted});
}

class ProjectUsers {
  String name;
  String avatarimage;
  ProjectUsers({@required this.name, @required this.avatarimage});
}
