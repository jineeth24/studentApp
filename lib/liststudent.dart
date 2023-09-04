import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newstudent/db/funcitons/dbfunctions.dart';
import 'package:newstudent/detailscreen.dart';

import 'db/model/studentmodel.dart';



class ListStudentWidget extends StatefulWidget{
  const ListStudentWidget({Key? key}): super(key: key);

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context){
    final studentList = studentListNotifier.value;


    return ValueListenableBuilder<List<StudentModel>>(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> studentList, Widget? child) {

        //  final data = studentList[widget.index];
        // final base64Image = data.profilePhoto;
        // final imageBytes = base64.decode(base64Image!);
        return ListView.separated(itemBuilder: (ctx,index) {
          final data = studentList[index];
          return ListTile(title: Text(data.name),
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailedScreen(index)),
                );
              },
            subtitle: Text(data.age +" "+ data.department+" " +data.location+" "+data.guardian),
            //


            trailing: IconButton(
                onPressed: () {
                  if(data.id !=null){
                    deleteStudent(data.id!);
                  }
                  else{
                    print('Student id is null, Unable to delete');
                  }
                }, icon: const Icon(Icons.delete,
              color: Colors.red,
            )),
          );
        },
            separatorBuilder: (ctx, index){
          return const Divider();
        }, itemCount: studentList.length);
      },

    );
  }
}