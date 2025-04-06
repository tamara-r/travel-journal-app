import 'package:flutter/material.dart';
import 'package:travel_journal/features/home/presentation/home_screen.dart';
import 'package:travel_journal/features/journey/presentation/screens/add_journey_screen.dart';
import 'package:travel_journal/features/notifications/presentation/screens/notification_screen.dart';
import 'package:travel_journal/features/settings/presentation/screens/settings_screen.dart';
import 'package:travel_journal/features/user/presentation/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    SizedBox(), // Add Journey placeholder
    ProfileScreen(),
    SettingsScreen(),
    NotificationScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddJourneyScreen()),
      );
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 10,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(Icons.home, 'Home', 0),
              _buildTabItem(Icons.person, 'Profile', 2),
              const SizedBox(width: 20), // space for the floating action button
              _buildTabItem(Icons.settings, 'Settings', 3),
              _buildTabItem(Icons.notifications, 'Notifications', 4),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddJourneyScreen()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildTabItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColor.withOpacity(0.4);

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
