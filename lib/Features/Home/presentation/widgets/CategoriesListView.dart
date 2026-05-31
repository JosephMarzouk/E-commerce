import 'package:e__commerce/Features/Home/data/models/CategoryModel.dart';
import 'package:e__commerce/Features/Home/presentation/Views/CategoryView.dart';
import 'package:e__commerce/Shared/Functions/NavigateTo.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final bgColor = AppColors.kCategoryColors[
              index % AppColors.kCategoryColors.length];
          final iconColor = AppColors.kCategoryIconColors[
              index % AppColors.kCategoryIconColors.length];

          return GestureDetector(
            onTap: () => navigateTo(
              context,
              CategoryView(category: category.text),
            ),
            child: Container(
              width: 88,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.kBordersideColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(category.icon, size: 28, color: iconColor),
                  const SizedBox(height: 8),
                  Text(
                    category.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kBlackColor,
                    ),
                  ),
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
  Category(icon: Icons.fitness_center_rounded, text: 'Fitness'),
  Category(icon: Icons.devices_rounded, text: 'Electronics'),
  Category(icon: Icons.style_rounded, text: 'Collections'),
  Category(icon: Icons.menu_book_rounded, text: 'Books'),
  Category(icon: Icons.sports_esports_rounded, text: 'Games'),
  Category(icon: Icons.pedal_bike_rounded, text: 'Bikes'),
];
