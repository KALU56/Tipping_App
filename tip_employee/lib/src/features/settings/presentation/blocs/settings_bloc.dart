import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserSettingRepository userSettingRepository;
  final UserRepository userRepository;

  SettingBloc({
    required this.userSettingRepository,
    required this.userRepository,
  }) : super(SettingInitial()) {
    // Event: Load profile
    on<LoadProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final user = await userRepository.getProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(SettingError('Failed to load profile: ${e.toString()}'));
      }
    });

    // Event: Update profile
    on<UpdateProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final updatedUser = await userSettingRepository.updateProfile(
          firstName: event.user.firstname,
          lastName: event.user.lastname,
          imageUrl: event.user.imageUrl,
        );
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(SettingError('Failed to update profile: ${e.toString()}'));
      }
    });

    // Event: Change password
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

    // Event: Logout
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
