abstract class User {
  final String? id, contactNo, address;
  final String firstName, lastName, email, password;
  final Map<String, dynamic>? verification;
  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.contactNo,
    this.address,
    this.verification,
  });

  Map<String, dynamic> toJson();
}
