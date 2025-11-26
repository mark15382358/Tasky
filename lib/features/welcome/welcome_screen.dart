import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: AppSizes.h16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(
                        path: 'assets/images/logo.svg',
                        height: AppSizes.h42,
                        width: AppSizes.w42,
                      ),
                      SizedBox(width: AppSizes.w16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h118),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomSvgPicture.withoutColor(path: "assets/images/waving_hand.svg"),
                    ],
                  ),
                  SizedBox(height: AppSizes.h8),
                  Text(
                    "Your productivity journey starts here.",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
                  ),
                  SizedBox(height: AppSizes.h24),
                  CustomSvgPicture.withoutColor(
                    path: 'assets/images/welcome.svg',
                    width: AppSizes.w215,
                    height: AppSizes.w200,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:AppSizes.h24),
                        CustomTextFormField(
                          controller: controller,
                          hintText: 'e.g. Sarah Khalid',
                          title: "Full Name",
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please Enter Your Full Name ";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: AppSizes.h24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width.w, AppSizes.h40),
                          ),
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PreferencesManager().setString(StorageKey.username, controller.value.text);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please Enter Your Full Name"),
                                ),
                              );
                            }
                          },
                          child: Text("Let’s Get Started"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
