class LoginDetails {

  final String token;
  final int parent_id;
  final String parent_name;

  const LoginDetails({required this.token, required this.parent_id, required this.parent_name});

  LoginDetails.fromMap(Map<String, dynamic>  map) :
        token = map['token'],
        parent_id = map['parent_id'],
        parent_name = map['parent_name'];

}
