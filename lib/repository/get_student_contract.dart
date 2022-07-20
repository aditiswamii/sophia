import 'dart:async';
import 'package:sophia/model/history.dart';
import 'package:sophia/model/student.dart';

import '../model/feesdetail.dart';
import '../model/success.dart';

abstract class StudentRepository {
  Future<List<Student>> fetchStudent();
  Future<FeesDetail> feesDetail();
  Future<List<History>> fetchHistory();
  Future<Success> changePassword(String old, String newp);
}