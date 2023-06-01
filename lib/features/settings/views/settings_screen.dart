import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Settings",
        isBack: true,
      ),
      body: const Center(
        child: Text("Settings"),
      ),
    );
  }
}
