import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project1/core/services/preferences_manager.dart';
import 'package:project1/core/widget/custom_text_form_field.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/screens/main_screen.dart';
import 'package:project1/widgets/custom_svg_picture_widget.dart';

class Welcomescreen extends StatelessWidget {
  Welcomescreen({super.key});

  final TextEditingController controller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPictureWidget(
                      path: "assets/images/1.svg",
                      withColorFilter: false,
                    ),

                    SizedBox(width: 16),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky ",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomSvgPictureWidget(
                      path: "assets/images/3.svg",
                      withColorFilter: false,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Your productivity journey starts here. ",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 36),
                 SvgPicture.asset(
                    "assets/images/5.svg",
                    width: 215,
                    height: 204,
                  ),
             
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: CustomTextFormField(
                    controller: controller,
                    hintText: 'e.g. Sarah Khalid',
                    title: "Full Name",
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty ?? false) {
                        return "Please Enter the Full Name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      await PreferencesManager().setString(
                        "username",
                        controller.value.text,
                      );
                      String? username = PreferencesManager().getString(
                        "username",
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainScreen();
                          },
                        ),
                      );
                    } else {
                      SnackBar(content: Text("please enter the full name"));
                    }
                  },

                  child: Text(
                    "Let’s Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
