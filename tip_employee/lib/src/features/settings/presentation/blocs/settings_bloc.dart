import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserSettingRepository userSettingRepository;
  final UserRepository userRepository;
  final BankAccountRepository bankAccountRepository;

  SettingBloc({
    required this.userSettingRepository,
    required this.userRepository,
    required this.bankAccountRepository, 
  }) : super(SettingInitial()) {
    
    // Your existing event handlers (unchanged)
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

    on<Logout>((event, emit) async {
      emit(SettingLoading());
      try {
        await userSettingRepository.logout();
        emit(LoggedOut());
      } catch (e) {
        emit(SettingError('Failed to logout: ${e.toString()}'));
      }
    });

    // Your existing bank account handlers (unchanged)
    on<LoadBankAccount>((event, emit) async {
      emit(BankAccountUpdating());
      try {
        final bankAccount = await bankAccountRepository.getBankAccount();
        emit(BankAccountUpdated(subAccountId: bankAccount.subAccountId ?? ''));
      } catch (e) {
        emit(BankAccountError('Failed to load bank account: ${e.toString()}'));
      }
    });

    on<UpdateBankAccount>((event, emit) async {
      emit(BankAccountUpdating());
      try {
        final updatedAccount = await bankAccountRepository.updateBankAccount(event.request);
        emit(BankAccountUpdated(subAccountId: updatedAccount.subAccountId ?? ''));

        // Optionally reload profile
        final updatedUser = await userRepository.getProfile();
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(BankAccountError('Failed to update bank account: ${e.toString()}'));
      }
    });

    // NEW: Event handler for account resolution (auto-detection)
    on<ResolveAccount>((event, emit) async {
      // Emit loading state
      emit(AccountResolving(
        accountNumber: event.accountNumber,
        bankCode: event.bankCode.isEmpty ? null : event.bankCode,
      ));

      try {
        debugPrint('🔍 BLoC: Resolving account ${event.accountNumber} for bank ${event.bankCode}');
        
        final resolution = await bankAccountRepository.resolveAccount(
          accountNumber: event.accountNumber,
          bankCode: event.bankCode,
        );

        debugPrint('✅ BLoC: Account resolution completed: ${resolution.isValid}');
        
        // Emit success state with resolution result
        emit(AccountResolved(
          resolution: resolution,
          accountNumber: event.accountNumber,
        ));

      } catch (e) {
        debugPrint('❌ BLoC: Account resolution failed: $e');
        
        // Emit error state - but make it non-fatal for auto-detection
        emit(AccountResolutionError(
          message: e.toString(),
          accountNumber: event.accountNumber,
        ));
      }
    });
  }
}