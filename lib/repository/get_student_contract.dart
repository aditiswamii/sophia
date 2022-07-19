import 'dart:async';
import 'package:sophia/model/student.dart';

import '../model/feesdetail.dart';

abstract class StudentRepository {
  Future<List<Student>> fetchStudent();
  Future<FeesDetail> feesDetail();
}