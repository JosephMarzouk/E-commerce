import 'package:e__commerce/Features/Home/presentation/widgets/CategoriesListView.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/CustomSearchBar.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:e__commerce/core/constants.dart';
import 'package:e__commerce/core/demo_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

import '../../../auth/data/cubit/AuthCubit/auth_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserDataModel? user;
  bool _paymobInitialized = false;

  @override
  void initState() {
    super.initState();
    _syncUserProfile();
  }

  void _syncUserProfile() {
    final profile =
        context.read<AuthCubit>().userDataModel ?? (kDemoMode ? kDemoGuest : null);
    if (profile == null || _paymobInitialized) return;
    user = profile;
    if (!kDemoMode) {
      PaymentData.initialize(
        apiKey: Constants().apiKey,
        iframeId: Constants().iframeId,
        integrationCardId: Constants().integrationCardId,
        integrationMobileWalletId: Constants().integrationMobileWalletId,
        userData: UserData(
          email: profile.email,
          name: profile.name,
        ),
      );
    }
    _paymobInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    user ??=
        context.watch<AuthCubit>().userDataModel ?? (kDemoMode ? kDemoGuest : null);
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
      );
    }
    final firstName = user!.name.split(' ').first;

    return ColoredBox(
      color: AppColors.kScaffoldColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HomeHeader(firstName: firstName),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: const CustomSearchbar(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _PromoBanner(),
            ),
            const SizedBox(height: 28),
            _SectionHeader(
              title: 'Popular categories',
              subtitle: 'Browse by interest',
            ),
            const SizedBox(height: 12),
            const CategoriesListView(),
            const SizedBox(height: 28),
            _SectionHeader(
              title: 'New arrivals',
              subtitle: 'Fresh picks for you',
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RecentProductListView(
                useGridLayout: true,
                demoProducts: kDemoMode ? kDemoProducts : null,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.firstName});

  final String firstName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back 👋',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.kTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hello, $firstName',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.kBlackColor,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDark],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDark],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Limited offer',
                    style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Up to 40% off\nselected items',
                  style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Shop the latest deals today',
                  style: TextStyle(
                    color: AppColors.kWhiteColor.withValues(alpha: 0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_offer_rounded,
              color: AppColors.kWhiteColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.kBlackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.kTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
