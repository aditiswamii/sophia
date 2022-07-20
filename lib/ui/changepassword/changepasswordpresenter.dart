import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/ui/feepayment/feepaycontract.dart';

import 'changepasswordcontract.dart';

class ChangePasswordPresenter {

  ChangePasswordContract _view;

  late StudentRepository _repository;

  ChangePasswordPresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void changepassword(String old, String newp) {
    assert(_view != null);

    _repository
        .changePassword(old, newp)
        .then((contacts) => _view.success(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }

}