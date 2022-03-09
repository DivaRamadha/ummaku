import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ummaku/model/fitur_model.dart';

class FiturCard extends StatelessWidget {
  final Fitur? f;
  const FiturCard({Key? key, this.f}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(14)),
          child: SvgPicture.asset(
            f!.imgPath!,
            height: 18,
            color: Get.isDarkMode ? Colors.white : Colors.black54,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          f!.name!,
          style: theme.textTheme.caption,
        )
      ],
    );
  }
}
