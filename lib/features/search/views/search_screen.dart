import 'package:anime_fandom/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentContext: context,
        title: "Search",
      ),
      body: const Center(
        child: Text("Search"),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
