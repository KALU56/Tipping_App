// lib/src/features/home/home.dart
import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';

part './presentation/screens/home_screen.dart';
part './presentation/components/promotional_banner.dart';
part './presentation/components/recent_tips_header.dart';
part './presentation/components/header_row.dart';
part './presentation/components/recent_tips_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}