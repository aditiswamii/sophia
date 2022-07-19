class FeesDetail {

  final String name;
  final String standard;
  final String year;
  final int feesdue;
  final int q1;
  final String q1paystatus;
  final int q2;
  final String q2paystatus;
  final int q3;
  final String q3paystatus;
  final int q4;
  final String q4paystatus;

  const FeesDetail({required this.name, required this.standard, required this.year, required this.feesdue,
    required this.q1, required this.q1paystatus, required this.q2, required this.q2paystatus,
    required this.q3, required this.q3paystatus, required this.q4, required this.q4paystatus});

  FeesDetail.fromMap(Map<String, dynamic>  map) :
        name = map['name'],
        standard = map['standard'],
        year = map['year'],
        feesdue = map['feesdue'],
        q1 = map['q1'],
        q1paystatus = map['q1paystatus'],
        q2 = map['q2'],
        q2paystatus = map['q2paystatus'],
        q3 = map['q3'],
        q3paystatus = map['q3paystatus'],
        q4 = map['q4'],
        q4paystatus = map['q4paystatus'];

}
