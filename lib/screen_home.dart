import 'package:flutter/material.dart';
import 'package:newstudent/addstudentwidget.dart';
import 'package:newstudent/db/funcitons/dbfunctions.dart';
import 'package:newstudent/liststudent.dart';




class ScreenHome extends StatelessWidget{
  const ScreenHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    getAllStudents();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(" Student "), actions: [
          IconButton(onPressed: (){},
          //   onPressed: 
          // (){
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => SearchPage()),
          //   );},
           icon: Icon(Icons.search)),


        ],),
      body: SafeArea(

        child: Column(
          children: [
            AddStudentWidget(),
            const Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
    );
  }
}