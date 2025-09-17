// lib/src/features/home/home.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/app/themes/app_theme.dart';
import 'package:tip_employee/app/themes/themeNotifier.dart';
import 'package:tip_employee/features/home/presentation/blocs/home_bloc.dart';
import 'package:tip_employee/features/home/presentation/blocs/home_event.dart';
import 'package:tip_employee/features/home/presentation/blocs/home_state.dart';
import 'package:tip_employee/shared/widgets/tip_list.dart';


// UI parts
part './presentation/screens/home_screen.dart';
part './presentation/components/promotional_banner.dart';
part './presentation/components/recent_tips_header.dart';
part './presentation/components/header_row.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return const _HomeScreen();
  }
}
