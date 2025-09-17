import 'package:equatable/equatable.dart';
import 'package:tip_employee/features/home/data/model/profile_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class ProfileLoaded extends HomeState {
  final ProfileInfo profile;
  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends HomeState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}