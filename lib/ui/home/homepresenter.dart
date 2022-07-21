import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/ui/home/homecontract.dart';

class HomePresenter {

  HomeContract _view;

  late StudentRepository _repository;

  HomePresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void loadContacts(String parent_id) {
    assert(_view != null);

    _repository
        .fetchStudent(parent_id)
        .then((contacts) => _view.showStudentList(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
  void insertoken(String user_id,String token, String device_id,String device_name) {
    assert(_view != null);

    _repository
        .insettoken(user_id, token, device_id, device_name)
        .then((contacts) => _view.success(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}