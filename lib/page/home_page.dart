import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ummaku/controllers/product_controller.dart';
import 'package:ummaku/model/fitur_model.dart';
import 'package:ummaku/model/product_model.dart';
import 'package:ummaku/widget/fitur_card.dart';
import 'package:ummaku/widget/product_card.dart';

class HomePge extends StatelessWidget {
  const HomePge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.pin_drop_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Anda',
                          style: theme.textTheme.caption,
                        ),
                        Text(
                          'Cirebon, Jawa Barat',
                          style: theme.textTheme.caption,
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kategori',
                  style: theme.textTheme.caption,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: fiturHomePage.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisExtent: 68),
                itemBuilder: (context, i) {
                  Fitur f = fiturHomePage[i];
                  return FiturCard(
                    f: f,
                  );
                },
              ),
              const SizedBox(
                height: 20,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Sekitar Anda',
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
                    // height: 300,
                    color: Colors.transparent,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: controller.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => ProductCard(
                        product: listProduct[i],
                        i: i,
                        isFull: true,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
