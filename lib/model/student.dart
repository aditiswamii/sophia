class Student {

  final String fullName;

  final String gender;

  final String email;

  final String imageUrl;

  final String birthday;

  // final Location location;
  //
  // final List<Phone> phones;


  const Student({required this.fullName, required this.gender, required this.email, required this.imageUrl,
    required this.birthday});

  Student.fromMap(Map<String, dynamic>  map) :
        fullName = "${map['name']['first']} ${map['name']['last']}",
        gender = map['gender'],
        email = map['email'],
        imageUrl = map['picture']['large'],
        birthday = "Birthday ${map['dob']}";
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