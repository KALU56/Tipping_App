import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends SettingEvent {}

class UpdateProfile extends SettingEvent {
  final User user;
  const UpdateProfile(this.user);

  @override
  List<Object?> get props => [user];
}

class ChangePassword extends SettingEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class Logout extends SettingEvent {}
