import 'dart:async';
import 'dart:convert';
import 'package:sophia/model/student.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/utils/fetch_data_exception.dart';
import 'package:http/http.dart' as http;


class GetStudentRepository implements StudentRepository {

  static const url = 'http://api.randomuser.me/?results=15';

  final JsonDecoder _decoder = JsonDecoder();

  @override
  Future<List<Student>> fetchStudent() {
    return http
        .get(Uri.parse(url))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final List contactItems = contactsContainer['results'];

      return contactItems.map((contactRaw) => Student.fromMap(contactRaw))
          .toList();
    });
  }
}