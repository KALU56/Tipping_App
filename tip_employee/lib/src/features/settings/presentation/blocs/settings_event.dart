import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

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
class LoadBankAccount extends SettingEvent {}

class UpdateBankAccount extends SettingEvent {
  final BankAccountRequest request;

  const UpdateBankAccount(this.request);

  @override
  List<Object?> get props => [request];
}
class ResolveAccount extends SettingEvent {
  final String accountNumber;
  final String bankCode;

  const ResolveAccount({
    required this.accountNumber,
    required this.bankCode,
  });

  @override
  List<Object?> get props => [accountNumber, bankCode];
}