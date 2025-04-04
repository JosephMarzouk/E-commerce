import 'package:cached_network_image/cached_network_image.dart';
import 'package:e__commerce/Shared/CustomSmallButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                 
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
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
                    child: const Text(
                      "15% OFF",
                      style:  TextStyle(
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                  ),
                ),
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
                          "Product Name",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: onTap,
                        //     icon: Icon(
                        //       Icons.favorite,
                        //       color: isFavorite
                        //           ? AppColors.kPrimaryColor
                        //           : AppColors.kGreyColor,
                        //     ))
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text(
                            "99LE",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "999 LE",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kGreyColor,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: IconButton(
                                iconSize: 35,
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.favorite_border_rounded)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomEBtn(text: "Buy now", onTap: () {})
                        ],
                      ),
                      // CustomEBtn(
                      //   text: "Buy Now",
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => PaymentView(
                      //           onPaymentSuccess:onPaymentSuccess,
                      //           onPaymentError: () {
                      //              log("Payment Failure");

                      //           },
                      //           price:
                      //               double.parse(product.price!), // Required: Total price (e.g., 100 for 100 EGP)
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
    //  Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Image.asset(
    //         "Assets/images/buy.jpg",
    //         fit: BoxFit.cover,
    //       ),
    //       const SizedBox(height: 8),
    //       const Text(
    //         "Product Name",
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //       ),
    //       const SizedBox(height: 4),
    //       const Text(
    //         "\$99.99",
    //         style: TextStyle(fontSize: 14, color: Colors.grey),
    //       ),
    //     ],
    //   ),
    // );
  }
}
