class LoginModel {
  final String email;
  final String password;
  final String? employeeCode;
  final String? firstName;
  final String? lastName;
  final String? token;

  LoginModel({
    required this.email,
    this.token, 
    required this.password,
    this.employeeCode,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        if (token != null) 'token': token,
      };

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'] ?? '',
        password: '',
        token: json['token'] ?? '', 
        employeeCode: json['employee_code'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
      );
}
