abstract class User {
  final String? id;
  final String firstName, lastName, email, password, contactNo, address;
  final Map<String, dynamic>? verification;
  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.contactNo,
    required this.address,
    required this.verification,
  });

  Map<String, dynamic> toJson();
}
