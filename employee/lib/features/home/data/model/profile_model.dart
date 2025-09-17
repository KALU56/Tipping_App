import 'package:equatable/equatable.dart';

class ProfileInfo extends Equatable {
  final String fullName;
  final String? imageUrl;

  const ProfileInfo({required this.fullName, this.imageUrl});

  @override
  List<Object?> get props => [fullName, imageUrl];
}