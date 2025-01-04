
import 'package:flutter/material.dart';
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

  static List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    JournalingScreen(),
    HistoryScreen()
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ]
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor:Colors.white,
                    textTheme: Theme
                        .of(context)
                        .textTheme
                        .copyWith(bodySmall: TextStyle(color: Colors.yellow)
                    )
                ),
                child: BottomNavigationBar(

                  type: BottomNavigationBarType.fixed,
                  backgroundColor:Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      label: 'Dashboard',
                      activeIcon: Icon(Icons.dashboard,color: AppColors.defaultBlue,),
                      icon: Icon(Icons.dashboard, color: AppColors.defaultBlue,),
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(Icons.message,color: AppColors.defaultBlue,),
                      icon: Icon(Icons.message,color: AppColors.defaultBlue,),
                      label: 'Message',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(Icons.history,color: AppColors.defaultBlue,),
                      icon: Icon(Icons.history,color: AppColors.defaultBlue,),
                      label: 'History',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.blue,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
