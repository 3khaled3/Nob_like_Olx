import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nob/features/Settings/presentation/widget/settings_app_bar.dart';
import 'package:nob/routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: settingsAppBar(context),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kEditProfile);
            },
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profile"),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.info_outline),
            title: const Text("about us"),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {},
            splashColor: Colors.red,
            iconColor: Colors.red,
            textColor: Colors.red,
            leading: const Icon(Icons.logout),
            title: const Text("logout"),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

 
}
