import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ummaku/controllers/location_controller.dart';
import 'package:ummaku/controllers/product_controller.dart';
import 'package:ummaku/model/product_model.dart';
import 'package:ummaku/page/location/detail_map.dart';
import 'package:ummaku/style/color.dart';
import 'package:ummaku/widget/product_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(LocationController());
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Pencarian',
                      style: theme.textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Get.isDarkMode
                            ? Colors.grey[700]
                            : Colors.grey[200],
                      ),
                      child: GetBuilder<LocationController>(
                          init: LocationController(),
                          builder: (controllers) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controllers.test == false
                                          ? theme.backgroundColor
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Jual',
                                        style: controllers.test == false
                                            ? theme.textTheme.bodyText1
                                            : theme.textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controllers.test == false
                                          ? Colors.transparent
                                          : theme.backgroundColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sewa',
                                        style: theme.textTheme.caption,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[200],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi',
                                style: theme.textTheme.headline6,
                              ),
                              Text(
                                'Setia Budi, Jakarta',
                                style: theme.textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const DetailMapsPage());
                        },
                        child: Container(
                          height: 80,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pencarian Terakhir',
                          style: theme.textTheme.bodyText1,
                        ),
                        Text(
                          'Lihat Lainnya',
                          style: theme.textTheme.caption,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child:
              // ),
              Container(
                height: 88,
                color: Colors.transparent,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, i) => Padding(
                    padding:
                        EdgeInsets.only(left: i == 0 ? 16.0 : 0.0, right: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      width: MediaQuery.of(context).size.width / 1.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Get.isDarkMode == false
                                  ? Colors.grey[700]!
                                  : Colors.grey[200]!)),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Get.isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[200],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.timer,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Container(
                              // height: 44,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bandung, Jawa Barat',
                                    style: theme.textTheme.bodyText1,
                                  ),
                                  Text(
                                    '24 Result',
                                    style: theme.textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Rekomendasi',
                      style: theme.textTheme.caption,
                    ),
                    const Spacer(),
                    Text(
                      'Lihat Lainnya',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<ProductController>(
                init: ProductController(),
                builder: (controller) {
                  return Container(
                    height: 300,
                    color: Colors.transparent,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: controller.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => ProductCard(
                        product: listProduct[i],
                        i: i,
                        isFull: false,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
