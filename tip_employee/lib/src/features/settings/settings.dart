import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part './presentation/screens/settings_screen.dart';
part './presentation/screens/change_password.dart';
part './presentation/screens/profile_details.dart';
part './presentation/components/logout_dialog.dart';
part './presentation/components/settings_switch_option.dart';
part './presentation/components/settings_option.dart';
part './presentation/components/profile_section.dart';
part './presentation/screens/Profileedit_Screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
