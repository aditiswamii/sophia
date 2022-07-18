import 'dart:async';
import 'package:sophia/model/student.dart';

abstract class StudentRepository {
  Future<List<Student>> fetchStudent();
}