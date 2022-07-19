import 'package:sophia/model/feesdetail.dart';

abstract class FeePayContract {

  void showFeesDetail(FeesDetail detail);

  void showError();
}