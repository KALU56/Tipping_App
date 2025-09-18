import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserSettingRepository userSettingRepository;
  final UserRepository userRepository;
  final BankAccountRepository bankAccountRepository;

  SettingBloc({
    required this.userSettingRepository,
    required this.userRepository,
    required this.bankAccountRepository,
  }) : super(SettingInitial()) {

    // Load Profile
    on<LoadProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final user = await userRepository.getProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(SettingError('Failed to load profile: ${e.toString()}'));
      }
    });
on<LoadBanks>((event, emit) async {
  emit(BankListLoading());
  try {
    final banks = await bankAccountRepository.getBanks();
    emit(BankListLoaded(banks));
  } catch (e) {
    emit(SettingError('Failed to load banks: ${e.toString()}'));
  }
});


    // Update Profile
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

    // Change Password
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

    // Logout
    on<Logout>((event, emit) async {
      emit(SettingLoading());
      try {
        await userSettingRepository.logout();
        emit(LoggedOut());
      } catch (e) {
        emit(SettingError('Failed to logout: ${e.toString()}'));
      }
    });

    // Load Bank Account
    on<LoadBankAccount>((event, emit) async {
      emit(BankAccountUpdating());
      try {
        final bankAccount = await bankAccountRepository.getBankAccount();
        emit(BankAccountUpdated(subAccountId: bankAccount?.subAccountId ?? ''));
      } catch (e) {
        emit(BankAccountError('Failed to load bank account: ${e.toString()}'));
      }
    });

    // Update Bank Account
    on<UpdateBankAccount>((event, emit) async {
      emit(BankAccountUpdating());
      try {
        final updatedAccount = await bankAccountRepository.updateBankAccount(event.request);
        emit(BankAccountUpdated(subAccountId: updatedAccount.subAccountId ?? ''));

        final updatedUser = await userRepository.getProfile();
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(BankAccountError('Failed to update bank account: ${e.toString()}'));
      }
    });

    // Resolve Account
    on<ResolveAccount>((event, emit) async {
      emit(AccountResolving(accountNumber: event.accountNumber, bankCode: event.bankCode));

      try {
        final resolution = await bankAccountRepository.resolveAccount(
          accountNumber: event.accountNumber,
          bankCode: event.bankCode,
        );
        emit(AccountResolved(resolution: resolution, accountNumber: event.accountNumber));
      } catch (e) {
        emit(AccountResolutionError(message: e.toString(), accountNumber: event.accountNumber));
      }
    });

// Validate & Create Bank Account (fetch-or-create)
on<ValidateAndCreateBankAccount>((event, emit) async {
  emit(BankAccountUpdating());
  try {
    final createdAccount = await bankAccountRepository.validateAndCreateBankAccount(
      businessName: event.businessName,  // ✅ Pass businessName
      accountName: event.accountName,
      accountNumber: event.accountNumber,
      bank: event.bank,
    );
    emit(BankAccountUpdated(subAccountId: createdAccount.subAccountId ?? ''));

    final updatedUser = await userRepository.getProfile();
    emit(ProfileLoaded(updatedUser));
  } catch (e) {
    emit(BankAccountError('Failed to validate/create bank account: ${e.toString()}'));
  }
});

  }
}
