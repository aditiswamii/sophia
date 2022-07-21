import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';


import 'drawercontract.dart';

class DrawerPresenter {

  DrawerContract _view;

  late StudentRepository _repository;

  DrawerPresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void logout(String user_id,String device_id) {
    assert(_view != null);
    _repository
      ..logout(user_id, device_id)
          .then((contacts) => _view.success(contacts))
          .catchError((onError) {
        print(onError);
        _view.showError();
      });
  }
}