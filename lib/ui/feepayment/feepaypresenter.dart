import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/ui/feepayment/feepaycontract.dart';

class FeePayPresenter {

  FeePayContract _view;

  late StudentRepository _repository;

  FeePayPresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void getfeesdetail() {
    assert(_view != null);

    _repository
        .feesDetail()
        .then((contacts) => _view.showFeesDetail(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
  void gethistory() {
    assert(_view != null);

    _repository
        .fetchHistory()
        .then((contacts) => _view.showHistory(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
  void payfee(String child_id,String transaction_id,String q2,String q1,String parent_id) {
    assert(_view != null);

    _repository
        .payfeeapi(child_id, transaction_id, q2, q1, parent_id)
        .then((contacts) => _view.success(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}