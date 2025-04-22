
import 'package:e__commerce/Features/Home/data/models/CategoryModel.dart';
import 'package:e__commerce/Features/Home/presentation/Views/CategoryView.dart';
import 'package:e__commerce/Shared/Functions/NavigateTo.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: ()=> navigateTo(context,CategoryView(category: categories[index].text,)),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.kPrimaryColor,
                    foregroundColor: AppColors.kWhiteColor,
                    child: Icon(
                      categories[index].icon,
                      size: 40,
                    ),
                  ),
                  Text(categories[index].text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Category> categories = [
  Category(icon: Icons.sports, text: "Fitness"),
  Category(icon: Icons.tv, text: "Electronics"),
  Category(icon: Icons.collections, text: "Collections"),
  Category(icon: Icons.book, text: "Books"),
  Category(icon: Icons.games, text: "Games"),
  Category(icon: Icons.bike_scooter, text: "Bikes"),
];

