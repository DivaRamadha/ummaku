import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ummaku/controllers/product_controller.dart';
import 'package:ummaku/model/product_model.dart';
import 'package:intl/intl.dart';

final format = NumberFormat("#,##0", "en_US");

class ProductCard extends StatelessWidget {
  final Product? product;
  final int? i;
  final bool? isFull;

  const ProductCard({Key? key, this.product, this.i, this.isFull})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 1,
      margin: isFull!
          ? const EdgeInsets.only(left: 16, right: 16, bottom: 16)
          : EdgeInsets.only(left: i == 0 ? 16 : 0, right: 16, bottom: 8),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 170,
                width: isFull!
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 1.4,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: product!.img!.isEmpty
                      ? const Icon(Icons.error)
                      : Image.network(
                          product!.img!.first,
                          fit: BoxFit.cover,
                          cacheHeight: 600,
                          errorBuilder: (_, __, ___) => const Icon(Icons.error),
                          // cacheWidth: 600,
                        ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GetBuilder<ProductController>(
                  init: ProductController(),
                  builder: (controller) {
                    return InkWell(
                      onTap: () {
                        productController.likeProduct(i!);
                      },
                      child: SvgPicture.asset(
                        product!.isLike!
                            ? 'assets/image/heart.svg'
                            : 'assets/image/heart-outline.svg',
                        width: 20,
                        color: product!.isLike! ? Colors.red : null,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            width: isFull!
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 1.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rp. ${format.format(product!.price)}',
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  product!.name!,
                  style: theme.textTheme.caption,
                ),
                Row(
                  children: [
                    Text(
                      product!.lt.toString() + 'm² lt',
                      style: theme.textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      product!.lb.toString() + 'm² lb',
                      style: theme.textTheme.subtitle1,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      product!.lantai.toString() + ' Lantai',
                      style: theme.textTheme.subtitle1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 18,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      product!.location!,
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductLocationCard extends StatelessWidget {
  final Product? product;
  final int? i;

  const ProductLocationCard({
    Key? key,
    this.product,
    this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final theme = Theme.of(context);
    return Container(
      height: 220,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 150,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 120),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product!.name.toString(),
                        style: theme.textTheme.caption,
                      ),
                      const Spacer(),
                      GetBuilder<ProductController>(
                        init: ProductController(),
                        builder: (controller) {
                          return InkWell(
                            onTap: () {
                              productController.likeProduct(i!);
                            },
                            child: SvgPicture.asset(
                              product!.isLike!
                                  ? 'assets/image/heart.svg'
                                  : 'assets/image/heart-outline.svg',
                              width: 20,
                              color: product!.isLike! ? Colors.red : null,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Rp. ${format.format(product!.price)}',
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      product!.lt.toString() + 'm² lt',
                      style: theme.textTheme.caption,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      product!.lb.toString() + 'm² lb',
                      style: theme.textTheme.caption,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      product!.lantai.toString() + ' Lantai',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product!.img!.isEmpty
                  ? const Icon(Icons.error)
                  : Image.network(
                      product!.img!.first,
                      fit: BoxFit.cover,
                      cacheHeight: 600,
                      // cacheWidth: 600,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
