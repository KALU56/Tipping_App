import 'package:tip_employee/core/service/http_service/http_service.dart';
import 'package:tip_employee/features/home/data/model/profile_model.dart';

class ProfileService {
  final HttpService httpService;

  ProfileService({required this.httpService});

  Future<ProfileInfo> getProfileInfo() async {
    try {
      final response = await httpService.get('/api/employee/profile');

      print('ProfileService Response: statusCode=${response.staticCode}');
      print('ProfileService Response Data: ${response.data}');

      // Ensure response is a map
      if (response.staticCode == 200 && response.data is Map<String, dynamic>) {
        final data = response.data['data'] as Map<String, dynamic>?;

        // If profile data is null, return defaults
        if (data == null) {
          print('ProfileService: Profile data is null, returning defaults.');
          return ProfileInfo(fullName: 'Unknown', imageUrl: null);
        }

        // Safely parse first_name, last_name, and image_url
        final firstName = data['first_name']?.toString() ?? '';
        final lastName = data['last_name']?.toString() ?? '';
        final fullName = (firstName + ' ' + lastName).trim();
        final imageUrl = data['image_url']?.toString(); // nullable

        print('ProfileService Parsed: fullName="$fullName", imageUrl="$imageUrl"');

        return ProfileInfo(
          fullName: fullName.isEmpty ? 'Unknown' : fullName,
          imageUrl: imageUrl,
        );
      } else {
        print('ProfileService Error: Unexpected response format: ${response.data}');
        return ProfileInfo(fullName: 'Unknown', imageUrl: null);
      }
    } catch (e, stackTrace) {
      print('ProfileService Exception: $e');
      print(stackTrace);
      // Return defaults instead of crashing
      return ProfileInfo(fullName: 'Unknown', imageUrl: null);
    }
  }
}
