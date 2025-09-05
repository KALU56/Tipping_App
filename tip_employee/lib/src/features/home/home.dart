// lib/src/features/home/home.dart
import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/app/themes/themeNotifier.dart';
import 'package:tip_employee/src/features/settings/settings.dart';
import 'package:tip_employee/src/shared/data/mock_tip_repository.dart';
import 'package:tip_employee/src/shared/data/models/tip_model.dart';
import 'package:tip_employee/src/shared/domain/repositories/tip_repository.dart';


// UI parts
part './presentation/screens/home_screen.dart';
part './presentation/components/promotional_banner.dart';
part './presentation/components/recent_tips_header.dart';
part './presentation/components/header_row.dart';
part './presentation/components/recent_tips_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScreen(
      repository: MockTipRepository(), // 🔥 Swap here later with API repo
    );
  }
}
