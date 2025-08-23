part of '../../home.dart';


class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                backgroundImage: AssetImage('assets/images/Ellipse 7.png'),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Search box - with consistent background color
          Expanded(
            child: Container(
              height: 44, // Fixed height to match avatar and notification
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
    );
  }
}