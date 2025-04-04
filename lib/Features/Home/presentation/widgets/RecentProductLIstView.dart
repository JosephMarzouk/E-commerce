import 'package:e__commerce/Features/Home/presentation/widgets/ProductCard.dart';
import 'package:flutter/material.dart';

class RecentProductListView extends StatelessWidget {
  const RecentProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (count, index) {
          return ProductCard();
        },
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true);
  }
}
