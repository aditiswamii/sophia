import 'dart:async';
import 'dart:convert';
import 'package:sophia/model/student.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/utils/fetch_data_exception.dart';
import 'package:http/http.dart' as http;


class GetStudentRepository implements StudentRepository {

  //static const url = 'http://api.randomuser.me/?results=15';
  static const url = 'https://sophia.mobilogicx.com/api/child_list';
  final JsonDecoder _decoder = JsonDecoder();

  @override
  Future<List<Student>> fetchStudent() {
   String parent_id = "4041";
   // var bodyv = json.encode(data);
    return http.post(Uri.parse(url),
        body: {
        'parent_id': parent_id}).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final List contactItems = contactsContainer['data']['student'];

      return contactItems.map((contactRaw) => Student.fromMap(contactRaw))
          .toList();
    });
  }
}