import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class ProfileLoaded extends SettingState {
  final User user;
  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class PasswordChanged extends SettingState {}

class LoggedOut extends SettingState {}

class SettingError extends SettingState {
  final String message;
  const SettingError(this.message);

  @override
  List<Object?> get props => [message];
}
