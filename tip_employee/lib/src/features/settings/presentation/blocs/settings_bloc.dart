import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/settings/domain/account_repository.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserSettingRepository userSettingRepository;
  final UserRepository userRepository;
  final AccountRepository accountRepository;

  SettingBloc({
    required this.userSettingRepository,
    required this.userRepository,
    required this.accountRepository,
  }) : super(SettingInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final user = await userRepository.getProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(SettingError('Failed to load profile: ${e.toString()}'));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final updatedUser = await userSettingRepository.updateProfile(
          firstName: event.user.firstname,
          lastName: event.user.lastname,
          imageFile: event.imageFile,
        );
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(SettingError('Failed to update profile: ${e.toString()}'));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(SettingLoading());
      try {
        await userSettingRepository.updatePassword(
          currentPassword: event.oldPassword,
          newPassword: event.newPassword,
          confirmPassword: event.newPassword,
        );
        emit(PasswordChanged());
      } catch (e) {
        emit(SettingError('Failed to change password: ${e.toString()}'));
      }
    });

    on<LoadAccount>((event, emit) async {
      emit(SettingLoading());
      try {
        final account = await accountRepository.getMyAccount();
        emit(AccountLoaded(
          accountNumber: account.accountNumber,
          accountName: account.accountName,
        ));
      } catch (e) {
        emit(SettingError('Failed to load account: ${e.toString()}'));
      }
    });

    on<UpdateAccount>((event, emit) async {
      emit(SettingLoading());
      try {
        final updatedAccount = await accountRepository.updateAccount(
          accountNumber: event.accountNumber,
          accountName: event.accountName,
        );
        emit(AccountUpdated(
          accountNumber: updatedAccount.accountNumber,
          accountName: updatedAccount.accountName,
        ));
      } catch (e) {
        emit(SettingError('Failed to update account: ${e.toString()}'));
      }
    });

    on<LoadBankAccount>((event, emit) async {
      emit(SettingLoading());
      try {
        final bankAccount = await userSettingRepository.getBankAccount();
        emit(BankAccountLoaded(
          accountNumber: bankAccount['account_number'],
          accountName: bankAccount['account_name'],
          bankCode: bankAccount['bank_code'],
        ));
      } catch (e) {
        emit(SettingError('Failed to load bank account: ${e.toString()}'));
      }
    });

    on<UpdateBankAccount>((event, emit) async {
      emit(SettingLoading());
      try {
        final updatedBankAccount = await userSettingRepository.updateBankAccount(
          accountName: event.accountName,
          accountNumber: event.accountNumber,
          bankCode: event.bankCode,
        );
        emit(BankAccountUpdated(
          accountNumber: updatedBankAccount['account_number'],
          accountName: updatedBankAccount['account_name'],
          bankCode: updatedBankAccount['bank_code'],
        ));
      } catch (e) {
        emit(SettingError('Failed to update bank account: ${e.toString()}'));
      }
    });

    on<Logout>((event, emit) async {
      emit(SettingLoading());
      try {
        await userSettingRepository.logout();
        emit(LoggedOut());
      } catch (e) {
        emit(SettingError('Failed to logout: ${e.toString()}'));
      }
    });
  }
}