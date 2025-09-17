import 'package:tip_employee/core/service/profile_server.dart';
import 'package:tip_employee/features/home/data/model/profile_model.dart';


abstract class ProfileRepository {
  Future<ProfileInfo> getProfileInfo();
}
