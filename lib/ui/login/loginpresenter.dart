import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/ui/home/homecontract.dart';

import 'logincontract.dart';

class LoginPresenter {

  LoginContract _view;

  late StudentRepository _repository;

  LoginPresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void getlogindetail(String mobile_number, String password) {
    assert(_view != null);

    _repository
        .loginapi(mobile_number, password)
        .then((contacts) => _view.showLoginDetail(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}