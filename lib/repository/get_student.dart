import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:sophia/model/feesdetail.dart';
import 'package:sophia/model/history.dart';
import 'package:sophia/model/student.dart';
import 'package:sophia/model/success.dart';
import 'package:sophia/repository/get_student_contract.dart';
import 'package:sophia/utils/fetch_data_exception.dart';
import 'package:http/http.dart' as http;


class GetStudentRepository implements StudentRepository {

  //static const url = 'http://api.randomuser.me/?results=15';
  static const url = 'https://sophia.mobilogicx.com/api/child_list';
  static const fee_details = 'https://sophia.mobilogicx.com/api/fee_details';
  static const fee_history = 'https://sophia.mobilogicx.com/api/payment_historydetail';
  static const change_password = 'https://sophia.mobilogicx.com/api/change_password';
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

  @override
  Future<FeesDetail> feesDetail() {
    String child_id = "546";
    return http.post(Uri.parse(fee_details),
        body: {
          'child_id': child_id}).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final LinkedHashMap<String,dynamic> contactItems = contactsContainer['data'];
      return FeesDetail.fromMap(contactItems);
    //  return contactItems.map((contactRaw) => Student.fromMap(contactRaw));
    });
  }

  @override
  Future<List<History>> fetchHistory() {
    String parent_id = "4041";
    String child_id = "546";
    // var bodyv = json.encode(data);
    return http.post(Uri.parse(fee_history),
        body: {
          'parent_id': parent_id,'child_id': child_id}).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final List contactItems = contactsContainer['data']['children'];

      return contactItems.map((contactRaw) => History.fromMap(contactRaw))
          .toList();
    });
  }

  @override
  Future<Success> changePassword(String opassword, String npassword) {
    String user_id = "6932";
    return http.post(Uri.parse(change_password),
        body: {
          'user_id': user_id,'current_password': opassword,'new_password': npassword}).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final int status = contactsContainer['status'];
      final String message = contactsContainer['message'];
      Map map = {'status': status, 'message': message};

      final LinkedHashMap<String,dynamic> contactItems = LinkedHashMap.from(map);
      return Success.fromMap(contactItems);
      //  return contactItems.map((contactRaw) => Student.fromMap(contactRaw));
    });
  }
}