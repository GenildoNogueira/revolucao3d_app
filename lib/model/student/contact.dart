import 'dart:convert';

class Contact {
  final String email;
  final String phoneNumber;
  final String address;

  const Contact({
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Contact copyWith({
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return Contact(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map['email'] as String,
      phoneNumber: map['phone_number'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Contact(email: $email, phone_number: $phoneNumber, address: $address)';

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode => email.hashCode ^ phoneNumber.hashCode ^ address.hashCode;
}
