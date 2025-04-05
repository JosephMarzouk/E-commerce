import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/Features/Profile/presentation/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "MY ORDERS"),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: RecentProductListView(physics: BouncingScrollPhysics(),),
            ),
          ),
    );
  }
}