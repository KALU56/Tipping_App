import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';


class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserRepository userRepository;

  SettingBloc(this.userRepository) : super(SettingInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        final user = await userRepository.getProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(SettingError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(SettingLoading());
      try {
        await userRepository.updateProfile(event.user);
        final updated = await userRepository.getProfile();
        emit(ProfileLoaded(updated));
      } catch (e) {
        emit(SettingError(e.toString()));
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(SettingLoading());
      try {
        await userRepository.changePassword(event.oldPassword, event.newPassword);
        emit(PasswordChanged());
      } catch (e) {
        emit(SettingError(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      emit(SettingLoading());
      try {
        await userRepository.logout();
        emit(LoggedOut());
      } catch (e) {
        emit(SettingError(e.toString()));
      }
    });
  }
}
