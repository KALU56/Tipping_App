import 'package:tip_employee/core/service/profile_server.dart';
import 'package:tip_employee/features/home/data/model/profile_model.dart';
import 'package:tip_employee/features/home/domain/employ_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService profileService;

  ProfileRepositoryImpl({required this.profileService});

  @override
  Future<ProfileInfo> getProfileInfo() async {
    return await profileService.getProfileInfo();
  }
}
