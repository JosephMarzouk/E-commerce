import 'package:e__commerce/Features/Favorite/presentation/Views/FavoriteView.dart';
import 'package:e__commerce/Features/Home/presentation/Views/HomeView.dart';
import 'package:e__commerce/Features/NavBar/data/manager/cubit/nav_bar_cubit.dart';
import 'package:e__commerce/Features/Profile/presentation/Views/Profile.dart';
import 'package:e__commerce/Features/Store/presentation/Views/StoreView.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainHomeView extends StatefulWidget {
  MainHomeView({super.key, });

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
 late List<Widget> _screens;
  @override
  void initState() {
     _screens = [
     HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView(),
  ];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        NavBarCubit cubit = context.read<NavBarCubit>();
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: _screens[cubit.currentIndex],
          )),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.kWhiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              child: GNav(
                  onTabChange: (index) {
                    cubit.changeCurrentIndex(index);
                  },
                  rippleColor: AppColors
                      .kPrimaryColor, // tab button ripple color when pressed
                  hoverColor: AppColors.kPrimaryColor, // tab button hover color
                  duration: const Duration(
                      milliseconds: 400), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: AppColors.kGreyColor, // unselected icon color
                  activeColor:
                      AppColors.kWhiteColor, // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor:
                      AppColors.kPrimaryColor, // selected tab background color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ), // navigation bar padding
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.store,
                      text: 'Store',
                    ),
                    GButton(
                      icon: Icons.favorite,
                      text: 'Favorite',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
