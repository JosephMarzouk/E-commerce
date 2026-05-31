import 'package:e__commerce/Features/Home/presentation/widgets/CustomSearchBar.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/core/demo_data.dart';
import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Welcome to the Store ☺️',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const CustomSearchbar(),
        RecentProductListView(
          demoProducts: kDemoMode ? kDemoProducts : null,
        ),
      ],
    );
  }
}