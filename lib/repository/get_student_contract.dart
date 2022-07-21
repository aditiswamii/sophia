import 'dart:async';
import 'package:sophia/model/history.dart';
import 'package:sophia/model/student.dart';

import '../model/feesdetail.dart';
import '../model/login.dart';
import '../model/success.dart';

abstract class StudentRepository {
  Future<List<Student>> fetchStudent(String parent_id);
  Future<FeesDetail> feesDetail();
  Future<List<History>> fetchHistory();
  Future<Success> changePassword(String old, String newp);
  Future<LoginDetails> loginapi(String mobile_number, String password);
  Future<Success> insettoken(String user_id,String token, String device_id,String device_name);
  Future<Success> logout(String user_id,String device_id);
}