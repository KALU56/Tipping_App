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

class AccountLoaded extends SettingState {
  final String? accountNumber;
  final String? accountName;

  const AccountLoaded({this.accountNumber, this.accountName});

  @override
  List<Object?> get props => [accountNumber, accountName];
}

class AccountUpdated extends SettingState {
  final String? accountNumber;
  final String? accountName;

  const AccountUpdated({this.accountNumber, this.accountName});

  @override
  List<Object?> get props => [accountNumber, accountName];
}

class BankAccountLoaded extends SettingState {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;

  const BankAccountLoaded({this.accountNumber, this.accountName, this.bankCode});

  @override
  List<Object?> get props => [accountNumber, accountName, bankCode];
}

class BankAccountUpdated extends SettingState {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;

  const BankAccountUpdated({this.accountNumber, this.accountName, this.bankCode});

  @override
  List<Object?> get props => [accountNumber, accountName, bankCode];
}