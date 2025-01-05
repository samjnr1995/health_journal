import 'package:flutter/material.dart';
import 'package:health_journal/utils/styles.dart';
import '../../dashboard/view/home_page.dart';
import '../../history/view/history.dart';
import '../../journalling/view/journaling.dart';
import '../../utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // Define the screens for each tab.
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    JournalingScreen(),
    HistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: SizedBox(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.defaultBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                selectedLabelStyle: AppTextStyles.headerStyle
                    .copyWith(fontSize: 12, color: AppColors.defaultBlue),
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: 'Dashboard',
                    activeIcon: Icon(Icons.dashboard, color:AppColors.defaultBlue),
                    icon: const Icon(Icons.dashboard, color: Colors.grey),
                  ),
                  const BottomNavigationBarItem(
                    label: 'Journaling',
                    activeIcon: Icon(Icons.message, color: AppColors.defaultBlue),
                    icon: Icon(Icons.message, color: Colors.grey),
                  ),
                  const BottomNavigationBarItem(
                    label: 'History',
                    activeIcon: Icon(Icons.history, color: AppColors.defaultBlue),
                    icon: Icon(Icons.history, color: Colors.grey),
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
