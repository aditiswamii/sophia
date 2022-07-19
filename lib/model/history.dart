class History {

  final int child_id;
  final String name;
  final String standard;
  final int feesdue;
  final String feesdetail;
  final String paymentdate;
  final String transactionid;

  const History({required this.child_id, required this.name, required this.standard, required this.feesdue,
    required this.feesdetail, required this.paymentdate, required this.transactionid});

  History.fromMap(Map<String, dynamic>  map) :

        child_id = map['child_id'],
        name = map['name'],
        standard = map['standard'],
        feesdue = map['feesdue'],
        feesdetail = map['feesdetail'],
        paymentdate = map['payment_date'],
        transactionid = map['transaction_id'];

}
