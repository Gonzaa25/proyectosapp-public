import 'package:flutter/material.dart';
import 'package:project_app/proyects/struct/struct.dart';

class ProjectDetail extends StatefulWidget {
  final Projects? proyect;
  final List<Projects>? pendingproyects;
  final List<Projects>? completeproyects;
  ProjectDetail({this.proyect,this.pendingproyects,this.completeproyects});
  @override
  State<StatefulWidget> createState() => ProjectDetailState();
}

class ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.proyect!.name,style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context,index)=>Divider(),
          itemCount: widget.proyect!.tasks.length,
          itemBuilder: (context,index){
          return CheckboxListTile(
            value: widget.proyect!.tasks[index].isCompleted,onChanged: (status){
             setState(() {
               widget.proyect!.tasks[index].isCompleted=status;
             });
          },title: Text(widget.proyect!.tasks[index].name),);
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            int totaltasks = widget.proyect!.tasks.length;
                                int i = 0;
                                int completedtasks = 0;
                                for (i = 0; i < totaltasks; i++) {
                                  if (widget.proyect!.tasks[i].isCompleted!) {
                                    completedtasks += 1;
                                  }
                                }
                                if (completedtasks ==widget.proyect!.tasks.length) {
                                  setState(() {
                                    widget.proyect!.isCompleted=true;
                                    
                                  });
                                }else{
                                  setState(() {
                                    widget.proyect!.isCompleted=false;
                                  });

                                }
            Navigator.pop(context);
          }, child: Icon(Icons.check, color: Colors.white)),
    );
  }
}