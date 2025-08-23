
part of '../../home.dart';
class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Row
            const _HeaderRow(),
            
            // Promotional Banner
            const _PromotionalBanner(),
            
            // Recent Tips Header
            const _RecentTipsHeader(),
            
            const SizedBox(height: 8),
            
            // Recent tips list expands to fill space
            const Expanded(child: RecentTipsList()),
          ],
        ),
      ),
    );
  }
}