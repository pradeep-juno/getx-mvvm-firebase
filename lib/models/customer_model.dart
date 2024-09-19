class Customer {
  String id;
  String name;
  String phone;
  int age;
  String gender;
  String address;
  String idProof;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.address,
    required this.idProof,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      age: json['age'],
      gender: json['gender'],
      address: json['address'],
      idProof: json['idProof'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'age': age,
      'gender': gender,
      'address': address,
      'idProof': idProof,
    };
  }
}
