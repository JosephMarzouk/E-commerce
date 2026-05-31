import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/Views/ProductDetailsView.dart';
import 'package:e__commerce/Shared/CustomSmallButton.dart';
import 'package:e__commerce/Shared/Functions/ShowMessageFunction.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

void _openProductPayment(
  BuildContext context, {
  required bool demoMode,
  required ProductModel product,
  required VoidCallback onPaymentSuccess,
}) {
  if (demoMode) {
    showMsg(context, 'Demo mode — checkout disabled');
    onPaymentSuccess();
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentView(
        onPaymentSuccess: onPaymentSuccess,
        onPaymentError: () => log('Failed'),
        price: double.parse(product.price!),
      ),
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
    this.onTap,
    required this.isFavorite,
    required this.onPaymentSuccess,
    this.compact = false,
    this.demoMode = false,
  });

  final ProductModel product;
  final Function()? onTap;
  final VoidCallback onPaymentSuccess;
  final bool isFavorite;
  final bool compact;
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _CompactProductCard(
        product: product,
        onTap: onTap,
        isFavorite: isFavorite,
        onPaymentSuccess: onPaymentSuccess,
        demoMode: demoMode,
      );
    }
    return _FullProductCard(
      product: product,
      onTap: onTap,
      isFavorite: isFavorite,
      onPaymentSuccess: onPaymentSuccess,
      demoMode: demoMode,
    );
  }
}

class _CompactProductCard extends StatelessWidget {
  const _CompactProductCard({
    required this.product,
    required this.onTap,
    required this.isFavorite,
    required this.onPaymentSuccess,
    required this.demoMode,
  });

  final ProductModel product;
  final Function()? onTap;
  final bool isFavorite;
  final VoidCallback onPaymentSuccess;
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsView(product: product),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kSurfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kBordersideColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlackColor.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrl ?? '',
                      placeholder: (_, __) => Container(
                        color: AppColors.kPrimaryLight,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.kPrimaryLight,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                ),
                if (product.oldPrice != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kAccentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.sale}% OFF',
                        style: const TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.kAccentColor
                          : AppColors.kWhiteColor,
                      size: 22,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.kBlackColor.withValues(
                        alpha: 0.35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? 'Product',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kBlackColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${product.price} LE',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      const Spacer(),
                      _BuyIconButton(
                        onTap: () => _openProductPayment(
                          context,
                          demoMode: demoMode,
                          product: product,
                          onPaymentSuccess: onPaymentSuccess,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuyIconButton extends StatelessWidget {
  const _BuyIconButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kPrimaryColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.kWhiteColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _FullProductCard extends StatelessWidget {
  const _FullProductCard({
    required this.product,
    required this.onTap,
    required this.isFavorite,
    required this.onPaymentSuccess,
    required this.demoMode,
  });

  final ProductModel product;
  final Function()? onTap;
  final bool isFavorite;
  final VoidCallback onPaymentSuccess;
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsView(product: product),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.kSurfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.kBordersideColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlackColor.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrl ?? '',
                    ),
                  ),
                ),
                if (product.oldPrice != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kAccentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${product.sale}% OFF',
                        style: const TextStyle(
                          color: AppColors.kWhiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.kAccentColor
                          : AppColors.kWhiteColor,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.kBlackColor.withValues(
                        alpha: 0.35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.productName ?? 'Product Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.kBlackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.price} LE',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                          if (product.oldPrice != null)
                            Text(
                              '${product.oldPrice} LE',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.kTextSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      CustomEBtn(
                        text: 'Buy Now',
                        onTap: () => _openProductPayment(
                          context,
                          demoMode: demoMode,
                          product: product,
                          onPaymentSuccess: onPaymentSuccess,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
