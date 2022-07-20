class Success {

  final int status;
  final String message;

  const Success({required this.status, required this.message});

  Success.fromMap(Map<String, dynamic>  map) :

        status = map['status'],
        message = map['message'];
}
