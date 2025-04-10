import 'package:cached_network_image/cached_network_image.dart';
import 'package:e__commerce/Features/Home/data/cubit/FeedBackCubit/feed_back_cubit.dart';
import 'package:e__commerce/Features/Home/data/models/ProductModel.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/UsersCommentsListView.dart';
import 'package:e__commerce/Features/Profile/presentation/widgets/CustomAppBar.dart';
import 'package:e__commerce/Features/Profile/presentation/widgets/CustomTextField.dart';
import 'package:e__commerce/core/CustomCircleProgIndicator.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FeedBackCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<FeedBackCubit, FeedBackState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          FeedBackCubit cubit = context.read<FeedBackCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(context, 'Product Details'),
            body: state is GetRateLoading || state is AddCommentLoading
                ? const CustomCircleProgIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.imageUrl!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.product.description??'',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "${widget.product.price} LE",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    widget.product.oldPrice != null
                                        ? Text(
                                            "${widget.product.oldPrice} LE",
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.kGreyColor,
                                              fontSize: 18,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  iconSize: 25,
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.favorite_border_rounded)),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   widget.product.description ?? "",
                          //   style: const TextStyle(
                          //       fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            initialRating: cubit.userRate.toDouble()  ,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                             cubit.addOrUpdateUserRate(
                                  productId: widget.product.productId!,
                                  data: {
                                    "rate": rating.toInt(),
                                    "for_user": cubit.userId,
                                    "for_product": widget.product.productId,
                                  },
                                );
                                setState(() {
                                  
                                });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              labelText: "Type your comment here",
                              suffIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "User Comments",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "------------------",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UsersCommentsListView(),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
