class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String employeeCode; // ⚡ note: 'employeeCode'

  SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.employeeCode,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'employee_code': employeeCode, // ⚡ must match Laravel API exactly
      };

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        password: '', // usually API doesn’t return password
        employeeCode: json['employee_code'] ?? '',
      );
}
