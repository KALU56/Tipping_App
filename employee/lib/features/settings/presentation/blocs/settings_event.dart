import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:tip_employee/shared/data/models/user_model.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends SettingEvent {}

class UpdateProfile extends SettingEvent {
  final User user;
  final File? imageFile;

  const UpdateProfile(this.user, {this.imageFile});

  @override
  List<Object?> get props => [user, imageFile];
}

class ChangePassword extends SettingEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class Logout extends SettingEvent {}

class LoadAccount extends SettingEvent {}

class UpdateAccount extends SettingEvent {
  final String accountName;
  final String accountNumber;

  const UpdateAccount({required this.accountName, required this.accountNumber});

  @override
  List<Object?> get props => [accountName, accountNumber];
}

class LoadBankAccount extends SettingEvent {}

class UpdateBankAccount extends SettingEvent {
  final String accountName;
  final String accountNumber;
  final String bankCode;

  const UpdateBankAccount({
    required this.accountName,
    required this.accountNumber,
    required this.bankCode,
  });

  @override
  List<Object?> get props => [accountName, accountNumber, bankCode];
}