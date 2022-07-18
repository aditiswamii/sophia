import 'package:sophia/repository/get_student.dart';
import 'package:sophia/repository/get_student_contract.dart';

class Injector {

  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  StudentRepository get studentRepository {
    return new GetStudentRepository();
  }
}