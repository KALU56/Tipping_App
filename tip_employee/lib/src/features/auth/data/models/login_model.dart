class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  // Convert model to JSON (for API request)
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  // Convert JSON to model (for API response)
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json['email'],
        password: json['password'],
      );
}