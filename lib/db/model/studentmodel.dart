

import 'package:hive/hive.dart';
 part 'studentmodel.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String department;
  @HiveField(4)
  String? profilePhoto;
  @HiveField(5)
  final String location;
  @HiveField(6)
  final String guardian;
  StudentModel({required this.name, required this.age, required this.department, this.id,required this.profilePhoto, required this.location,required this.guardian});
}