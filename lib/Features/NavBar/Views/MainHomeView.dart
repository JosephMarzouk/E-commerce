import 'package:flutter/material.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(),
      )),
      bottomNavigationBar: GNav(
        tabs : GButton(
      icon: LineIcons.home,
      text: 'Home',
    ),
    GButton(
      icon: LineIcons.heart_o,
      text: 'Likes',
    ),
    GButton(
      icon: LineIcons.search,
      text: 'Search',
    ),
    GButton(
      icon: LineIcons.user,
      text: 'Profile',
    ),
      )
    );
  }
}
