
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tip_employee/features/tip/presentation/blocs/tip_bloc.dart';
import 'package:tip_employee/features/tip/presentation/blocs/tip_event.dart';
import 'package:tip_employee/features/tip/presentation/blocs/tip_state.dart';
import 'package:tip_employee/features/tip/presentation/components/filter_chips.dart';
import 'package:tip_employee/shared/widgets/tip_list.dart';
import 'package:tip_employee/features/tip/presentation/components/search_bar.dart';



part 'presentation/screens/tip_screen.dart';


class TransactionFeature extends StatelessWidget {
  const TransactionFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return const TipHistoryScreen();
  }
}
