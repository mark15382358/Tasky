import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/theme/theme_controller.dart';
import 'package:project1/main.dart';
import 'package:project1/screens/user_details_screen.dart';
import 'package:project1/screens/welcomescreen.dart';
import 'package:project1/widgets/custom_svg_picture_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  bool isDarkMode = true;

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString("username");
      motivate = PreferencesManager().getString("motivate");
      // isDarkMode = PreferencesManager().getBool("theme")!;
    });
  }

  // String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/6.png"),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              // color: Color(0xff282828),
                            ),
                            child: Icon(Icons.camera_alt, size: 26),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "$username",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 4),
                    Text(
                      motivate ?? "One task at a time. One step closer.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text(
                "Profile Info",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserDetailsScreen();
                      },
                    ),
                  );
                  PreferencesManager();
                  setState(() {
                    _loadData();
                  });
                },
                contentPadding: EdgeInsets.all(0),
                title: Text("User Details"),
                leading: CustomSvgPictureWidget(
                  path: "assets/images/user_details.svg",
                  withColorFilter: true,
                ),

                trailing: CustomSvgPictureWidget(
                  path: "assets/images/arrow.svg",
                  withColorFilter: true,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.all(0),
                title: Text("Dark Mode"),
                leading: CustomSvgPictureWidget(
                  path: "assets/images/dark_mode.svg",
                  withColorFilter: true,
                ),
                trailing: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (context, value, Widget? child) {
                    return Switch(
                      value: value == ThemeMode.dark,
                      onChanged: (bool value) async {
                        ThemeController.toggleTheme();
                      },
                    );
                  },
                ),
              ),

              Divider(),
              ListTile(
                onTap: () async {
                  PreferencesManager().remove("username");
                  PreferencesManager().remove("tasks");
                  PreferencesManager().remove("motivate");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Welcomescreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                contentPadding: EdgeInsets.all(0),
                title: Text("Log Out"),
                leading: CustomSvgPictureWidget(
                  path: "assets/images/log_out.svg",
                  withColorFilter: true,
                ),
                trailing: CustomSvgPictureWidget(
                  path: "assets/images/arrow.svg",
                  withColorFilter: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
