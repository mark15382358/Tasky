import 'package:flutter/material.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/widget/custom_text_form_field.dart';
import 'package:project1/screens/profile_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

final TextEditingController usernameController = TextEditingController();
final TextEditingController motivationController = TextEditingController();
GlobalKey<FormState> _key = GlobalKey<FormState>();
String? username;
String? motivate;

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _loadusername();
  }

  void _loadusername() async {
    setState(() {
      username = PreferencesManager().getString("username");
    });
    print("username $username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: usernameController,
                hintText: "$username",
                title: "User Name",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter the Username";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: motivationController,
                hintText: motivate ?? "One task at a time. One step closer.",
                title: "Motivation Quote",
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter the Username";
                  } else {
                    return null;
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManager().setString(
                      "username",
                      usernameController.text,
                    );
                    username = PreferencesManager().getString("username");

                    await PreferencesManager().setString(
                      "motivate",
                      motivationController.text,
                    );
                    motivate = PreferencesManager().getString("motivate");
                    print("Motivateeee $motivate");
                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  "Save Changes",
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
