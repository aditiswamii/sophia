import 'package:sophia/model/student.dart';

import '../../model/success.dart';

abstract class HomeContract {

  void showStudentList(List<Student> items);
  void success(Success succ);
  void showError();
}