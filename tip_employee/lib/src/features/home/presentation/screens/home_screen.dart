import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/themes/app_theme.dart';
import 'package:tip_employee/src/features/home/presentation/widgets/balance_card.dart';
import 'package:tip_employee/src/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:tip_employee/src/features/home/presentation/widgets/recent_tips_list.dart';
import 'package:tip_employee/src/features/home/presentation/widgets/time_filter_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header Row (Avatar + Search + Notifications)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  // Avatar with border - fixed height container
                  Container(
                    height: 44, // Fixed height to match other elements
                    width: 44, // Fixed width to make it square
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/Ellipse 7.png'),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Search box - with consistent background color
                  Expanded(
                    child: Container(
                      height: 44, // Fixed height to match avatar and notification
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Light background color
                        borderRadius: BorderRadius.circular(12), // Half of height for pill shape
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search tips or customers...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: AppTheme.primaryColor, size: 20),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Notification icon - in a container with same background color
                  Container(
                    height: 44, // Fixed height to match other elements
                    width: 44, // Fixed width to make it square
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[100], // Same background as search bar
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: AppTheme.textPrimary,
                        size: 24,
                      ),
                      padding: EdgeInsets.zero, // Remove default padding
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Balance Card (optional)
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            //   child: BalanceCard(),
            // ),

            // 🔹 Time Filter Buttons
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.0),
            //   child: TimeFilterButton(),
            // ),

            // 🔹 Recent Tips Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Tips',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Recent tips list expands to fill space
            const Expanded(
              child: RecentTipsList(),
            ),
          ],
        ),
      ),

      // 🔹 Bottom navigation
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}