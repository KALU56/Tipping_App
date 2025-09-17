class Bank {
  final String name;
  final String code; // string because your UI dropdown uses string values

  Bank({required this.name, required this.code});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      name: json['name'],
      code: json['code'].toString(), // ensure it's a string
    );
  }
}
