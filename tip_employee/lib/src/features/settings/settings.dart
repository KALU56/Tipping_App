// lib/src/features/settings/settings.dart
import 'package:flutter/material.dart';

// domain
import 'domain/models/user_profile.dart';
import 'domain/repositories/user_repository.dart';

// data
import 'data/mock_user_repository.dart';

// UI
part './presentation/screens/settings_screen.dart';
part './presentation/screens/change_password.dart';
part './presentation/screens/profile_details.dart';
part './presentation/components/logout_dialog.dart';
part './presentation/components/settings_switch_option.dart';
part './presentation/components/settings_option.dart';
part './presentation/components/profile_section.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(repository: MockUserRepository()); 
    // 🔥 later swap MockUserRepository with ApiUserRepository
  }
}
