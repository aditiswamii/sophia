class Student {

  final int child_id;

  final String name;

  final String standard;

  final int feesdue;

  const Student({required this.child_id, required this.name, required this.standard, required this.feesdue});

  Student.fromMap(Map<String, dynamic>  map) :

        child_id = map['child_id'],
        name = map['name'],
        standard = map['standard'],
        feesdue = map['feesdue'];
        // location = new Location.fromMap(map['location']),
        // phones = <Phone>[
        //   new Phone(type: 'Home',   number: map['phone']),
        //   new Phone(type: 'Mobile', number: map['cell'])
        // ];
}

class Location {

  final String street;

  final String city;

  const Location({required this.street, required this.city});

  Location.fromMap(Map<String, dynamic>  map) :
        street = map['street'],
        city = map['city'];
}

class Phone {
  final String type;
  final String number;

  const Phone({required this.type, required this.number});
}