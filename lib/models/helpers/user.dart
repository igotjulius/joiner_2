abstract class User {
  final String? id, firstName, lastName, email, password, contactNo, address;
  final Map<String, dynamic>? verification;
  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.contactNo,
    this.address,
    this.verification,
  });

  Map<String, dynamic> toJson();
}
