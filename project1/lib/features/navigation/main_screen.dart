import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project1/features/tasks/complete_tasks_screen.dart';
import 'package:project1/features/home/home_screen.dart';
import 'package:project1/features/profile/profile_screen.dart';
import 'package:project1/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[currentindex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Home.svg",0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/ToDo.svg",1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Completed.svg",2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Profile.svg",3),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  SvgPicture _buildSvgPicture(String path,int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        currentindex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
