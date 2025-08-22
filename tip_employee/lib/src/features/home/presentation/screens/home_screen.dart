import 'package:flutter/material.dart';
import 'package:tip_employee/src/app/routes/app_routes.dart';
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Row(
                children: [
                  // Avatar with border - fixed height container (now clickable)
                  GestureDetector(
                    onTap: () {
                      // Navigate to settings page
                      Navigator.pushNamed(context, AppRoutes.settings);
                    },
                    child: Container(
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
                        backgroundImage: AssetImage(
                          'assets/images/Ellipse 7.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Search box - with consistent background color
                  Expanded(
                    child: Container(
                      height:
                          44, // Fixed height to match avatar and notification
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Light background color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search tips or customers...',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
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

            // 🔹 Promotional Banner with background image
            Container(
              width: double.infinity,
              height: 220, // Increased height to accommodate additional content
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/birr.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black54, // Dark overlay to improve text visibility
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Financial information section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total money earned',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$1,234.56',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total withdrawn',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$1,200.00',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Available balance',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$34.56',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(), // Pushes the button to the bottom
                    // Right-aligned button
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Show all transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
            const Expanded(child: RecentTipsList()),
          ],
        ),
      ),
    );
  }
}