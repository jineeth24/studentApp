import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newstudent/db/model/studentmodel.dart';

import 'db/funcitons/dbfunctions.dart';








class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _departmentController = TextEditingController();
  final _locationController = TextEditingController();
  final _guardianController=TextEditingController();

  final picker = ImagePicker();

  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _imageFile != null
                        ? FileImage(_imageFile!)
                        : AssetImage('assets/images/filepicker.png') as ImageProvider<Object>,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _departmentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Department',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your department';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller:_guardianController,
              decoration: InputDecoration(hintText: "guardian name",
              border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Location',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Location';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onAddStudentButtonClicked();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _department = _departmentController.text.trim();
    final _location = _locationController.text.trim();
    final _guardian=_guardianController.text.trim();
    if(_name.isEmpty || _age.isEmpty || _department.isEmpty||_location.isEmpty){
    //  ScaffoldMessenger.of(context).showSnackBar(
    //   const  SnackBar(
    //       backgroundColor:Colors.red,
    //       duration: Duration(seconds: 1),
    //       content: Text('please fill all fields!',)),
    //   );
      return;
    }
    if(_imageFile ==null){
      //return;
      ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(
          backgroundColor:Colors.red,
          duration: Duration(seconds: 1),
          content: Text('please add your picture!')),
      );
    }

    final bytes = await _imageFile!.readAsBytes();
    final String base64Image = base64Encode(bytes);

    StudentModel _student = StudentModel(name: _name, age: _age, department: _department, profilePhoto: base64Image,location:_location,guardian:_guardian);
    addStudent(_student);
    _nameController.clear();
    _ageController.clear();
    _departmentController.clear();
    _locationController.clear();
    setState(() {
      _imageFile = null;
    });
  }
}