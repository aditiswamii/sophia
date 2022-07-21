import 'package:sophia/model/student.dart';

import '../../model/success.dart';

abstract class DrawerContract {

  void success(Success succ);
  void showError();
}