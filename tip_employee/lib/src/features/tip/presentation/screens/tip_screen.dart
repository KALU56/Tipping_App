part of '../../tip.dart';

class TipHistoryScreen extends StatefulWidget {
  const TipHistoryScreen({super.key});

  @override
  State<TipHistoryScreen> createState() => _TipHistoryScreenState();
}

class _TipHistoryScreenState extends State<TipHistoryScreen> {
  int _selectedFilter = 3; // Default "All"
  final List<String> _filters = ['Today', 'This Week', 'This Month', 'All'];

  @override
  void initState() {
    super.initState();
    context.read<TipBloc>().add(LoadTips());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(
                onSearchChanged: (query) =>
                    context.read<TipBloc>().add(SearchTips(query)),
              ),
              const SizedBox(height: 12),
              FilterChips(
                filters: _filters,
                selectedIndex: _selectedFilter,
                onFilterChanged: (index) {
                  setState(() => _selectedFilter = index);
                  context.read<TipBloc>().add(FilterTips(index));
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<TipBloc, TipState>(
                  builder: (context, state) {
                    if (state is TipLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TipLoaded) {
                      return TipList(tips: state.tips);
                    } else if (state is TipError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}