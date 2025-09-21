import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/core/service/account_service.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/welcome.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_request.dart';
import 'package:tip_employee/src/features/settings/data/model/bank_account_response.dart' show BankAccountResponse;
import 'package:tip_employee/src/features/settings/data/model/bank_model.dart';
import 'package:tip_employee/src/features/settings/data/user_s_repository_impl.dart';
import 'package:tip_employee/src/features/settings/domain/bank_account_repository.dart';
import 'package:tip_employee/src/features/settings/domain/user_s_repository.dart';

import 'package:tip_employee/src/features/settings/presentation/blocs/settings_bloc.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_event.dart';
import 'package:tip_employee/src/features/settings/presentation/blocs/settings_state.dart';
import 'package:tip_employee/src/shared/data/models/user_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/user_repository.dart';
part './presentation/screens/settings_screen.dart';
part './presentation/screens/change_password.dart';
part './presentation/screens/profile_details.dart';
part './presentation/components/logout_dialog.dart';
part './presentation/components/bank_dropdown.dart';
part './presentation/components/settings_option.dart';
part './presentation/components/accountedit.dart';
part './presentation/components/profile_section.dart';
part './presentation/components/profile_edit_dialog.dart';
part './presentation/components/change_password_screen.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}