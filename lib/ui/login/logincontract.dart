import 'package:sophia/model/student.dart';

import '../../model/login.dart';

abstract class LoginContract {

  void showLoginDetail(LoginDetails detail);
  void showError();
}