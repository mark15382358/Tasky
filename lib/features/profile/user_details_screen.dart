import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;

  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(text: widget.motivationQuote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userNameController,
                hintText: 'Usama Elgendy',
                title: "User Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter User Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer.',
                title: "Motivation Quote",
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Motivation Quote";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await PreferencesManager().setString(StorageKey.username, userNameController.value.text);
                    await PreferencesManager().setString(StorageKey.motivationQuote, motivationQuoteController.value.text);

                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text('Save Changes'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
