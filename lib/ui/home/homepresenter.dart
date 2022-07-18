import 'package:sophia/di/injection.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/ui/home/homecontract.dart';

class HomePresenter {

  HomeContract _view;

  late StudentRepository _repository;

  HomePresenter(this._view) {
    _repository = new Injector().studentRepository;
  }

  void loadContacts() {
    assert(_view != null);

    _repository
        .fetchStudent()
        .then((contacts) => _view.showStudentList(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError();
    });
  }
}