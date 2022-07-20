import '../../model/success.dart';

abstract class ChangePasswordContract {

  void success(Success succ);

  void showError();
}