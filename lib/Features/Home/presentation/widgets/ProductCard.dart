import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/Views/ProductDetailsView.dart';
import 'package:e__commerce/Shared/CustomSmallButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
    this.onTap,
    required this.isFavorite,
    required this.onPaymentSuccess,
  });
  final ProductModel product;
  final Function()? onTap;
  
  final VoidCallback onPaymentSuccess;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsView(product: product),
        ),
      ),
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: product.imageUrl!,
                      ),
                    ),
                  ),
                  product.oldPrice != null
                      ? Positioned(
                          child: Container(
                            alignment: Alignment.center,
                            width: 65,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                )),
                            child: Text(
                              "${product.sale}% OFF",
                              style: const TextStyle(
                                color: AppColors.kWhiteColor,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName ?? "Product Name",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: onTap,
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kGreyColor,
                              ))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${product.price} LE",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            product.oldPrice != null
                                ? Text(
                                    "${product.oldPrice} LE",
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kGreyColor,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        CustomEBtn(
                          text: "Buy Now",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentView(
                                  onPaymentSuccess: onPaymentSuccess,
                                  onPaymentError: () {
                                    log("Faild");
                                  },
                                  price:
                                    double.parse(product.price!),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
