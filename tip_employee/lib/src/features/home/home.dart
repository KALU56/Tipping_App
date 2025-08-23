import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';

import 'package:tip_employee/src/features/home/presentation/components/recent_tips_list.dart';

part './presentation/screens/promotional_banner.dart';
part './presentation/screens/recent_tip_header.dart';
part './presentation/screens/hearder_row.dart';
part './presentation/screens/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
