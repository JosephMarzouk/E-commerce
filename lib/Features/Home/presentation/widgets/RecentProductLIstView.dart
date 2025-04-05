import 'package:e__commerce/Features/Home/presentation/Views/ProductDetails.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/ProductCard.dart';
import 'package:flutter/material.dart';

class RecentProductListView extends StatelessWidget {
  const RecentProductListView({super.key, this.shrinkWrap, this.physics});

final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (count, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails()));},
              child: ProductCard()),
          );
        },
        itemCount: 5,
        physics:  physics ?? const NeverScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap ?? true,);
  }
}
