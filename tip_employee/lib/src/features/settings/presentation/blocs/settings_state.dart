import 'package:equatable/equatable.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_resolution_response.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

// General
class SettingInitial extends SettingState {}
class SettingLoading extends SettingState {}
class SettingError extends SettingState {
  final String message;
  const SettingError(this.message);

  @override
  List<Object?> get props => [message];
}

// Profile
class ProfileLoaded extends SettingState {
  final User user;
  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

// Password
class PasswordChanged extends SettingState {}

// Logout
class LoggedOut extends SettingState {}

// Bank Account
class BankAccountUpdating extends SettingState {}
class BankAccountUpdated extends SettingState {
  final String subAccountId;
  const BankAccountUpdated({required this.subAccountId});

  @override
  List<Object?> get props => [subAccountId];
}
class BankAccountError extends SettingState {
  final String message;
  const BankAccountError(this.message);

  @override
  List<Object?> get props => [message];
}

// Account Resolution
class AccountResolving extends SettingState {
  final String accountNumber;
  final String? bankCode;

  const AccountResolving({
    required this.accountNumber,
    this.bankCode,
  });

  @override
  List<Object?> get props => [accountNumber, bankCode];
}

class AccountResolved extends SettingState {
  final BankResolutionResponse resolution;
  final String accountNumber;

  const AccountResolved({
    required this.resolution,
    required this.accountNumber,
  });

  bool get isValid => resolution.isValid;
  String? get accountName => resolution.accountName;
  String? get bankCode => resolution.bankCode;
  String? get bankName => resolution.bankName;

  @override
  List<Object?> get props => [resolution, accountNumber];
}

class AccountResolutionError extends SettingState {
  final String message;
  final String accountNumber;

  const AccountResolutionError({
    required this.message,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [message, accountNumber];
}
class BankListLoaded extends SettingState {
  final List<Bank> banks;
  const BankListLoaded(this.banks);

  @override
  List<Object?> get props => [banks];
}
class BankListLoading extends SettingState {}
