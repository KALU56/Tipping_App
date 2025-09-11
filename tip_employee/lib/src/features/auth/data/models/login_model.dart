class LoginModel {
  final String email;
  final String password;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;

  LoginModel({
    required this.email,
    required this.password,
    this.employeeCode,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'] ?? '',
        password: '',
        employeeCode: json['employee_code'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
      );
}
