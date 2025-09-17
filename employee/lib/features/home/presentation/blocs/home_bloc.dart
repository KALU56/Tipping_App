import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/core/service/profile_server.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProfileService profileService;

  HomeBloc({required this.profileService}) : super(HomeInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<HomeState> emit) async {
    print('HomeBloc: Processing LoadProfile event');
    emit(HomeLoading());
    try {
      final profile = await profileService.getProfileInfo();
      print('HomeBloc: Emitting ProfileLoaded with fullName=${profile.fullName}, imageUrl=${profile.imageUrl}');
      emit(ProfileLoaded(profile));
    } catch (e, stackTrace) {
      print('HomeBloc: Emitting ProfileError: $e, StackTrace: $stackTrace');
      emit(ProfileError(e.toString()));
    }
  }
}