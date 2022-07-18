import 'package:sophia/model/student.dart';

abstract class HomeContract {

  void showStudentList(List<Student> items);

  void showError();
}