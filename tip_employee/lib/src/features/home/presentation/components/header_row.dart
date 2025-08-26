// lib/src/features/home/presentation/components/header_row.dart
part of '../../home.dart';
class _HeaderRow extends StatelessWidget {
  final String userName; // <-- add this

  const _HeaderRow({this.userName = "Kali"}); // default name

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top row: Avatar + Name + Notification
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar + Name
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
              child: Row(
                children: [
                  // Avatar with border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(width: 12), // space between avatar and name
                  // User name text
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Notification icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Search box below
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search tips or customers...',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppTheme.primaryColor,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
