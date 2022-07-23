import 'package:sophia/model/feesdetail.dart';
import 'package:sophia/model/history.dart';

import '../../model/success.dart';

abstract class FeePayContract {

  void showFeesDetail(FeesDetail detail);
  void showHistory(List<History> items);
  void success(Success succ);
  void showError();
}