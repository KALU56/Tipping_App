class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String employCode;

  SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.employCode,
  });

  // Convert model to JSON (for API request)
  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'employ_code': employCode,
      };

  // Convert JSON to model (for API response)
  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        employCode: json['employ_code'],
      );
}