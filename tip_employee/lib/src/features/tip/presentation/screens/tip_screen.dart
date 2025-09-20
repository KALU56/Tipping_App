// 
part of '../../tip.dart';
class TipHistoryScreen extends StatefulWidget {
  const TipHistoryScreen({super.key});

  @override
  State<TipHistoryScreen> createState() => _TipHistoryScreenState();
}

class _TipHistoryScreenState extends State<TipHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _tabs = ['All', 'Month', 'Week', 'Today'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    // Fetch all transactions on init
    context.read<TipHistoryBloc>().add(FetchAllTransactions());
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final period = _tabs[_tabController.index].toLowerCase();
      context.read<TipHistoryBloc>().add(FilterTransactions(period));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Search by amount',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<TipHistoryBloc>().add(SearchTransactions(value));
              },
            ),
          ),

          // Transaction list
          Expanded(
            child: BlocBuilder<TipHistoryBloc, TipHistoryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                }

                return TransactionHistoryList(
                  transactions: state.filteredTransactions,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
