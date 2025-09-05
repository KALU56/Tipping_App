import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/features/settings/data/mock_user_repository.dart';
import 'package:tip_employee/src/features/settings/domain/models/user.dart' hide User;
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
part './presentation/screens/settings_screen.dart';
part './presentation/screens/change_password.dart';
part './presentation/screens/profile_details.dart';
part './presentation/components/logout_dialog.dart';

part './presentation/components/settings_option.dart';
part './presentation/components/profile_section.dart';
part './presentation/components/profile_edit_dialog.dart';
part './presentation/components/change_password_screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
