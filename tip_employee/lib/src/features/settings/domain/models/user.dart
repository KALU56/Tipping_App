class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String description;
  final String accountNumber;
  final String? imagePath;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.description,
    required this.accountNumber,
    this.imagePath,
  });

  User copyWith({
    String? name,
    String? username,
    String? email,
    String? description,
    String? accountNumber,
    String? imagePath,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      description: description ?? this.description,
      accountNumber: accountNumber ?? this.accountNumber,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}