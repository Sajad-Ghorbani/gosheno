import 'package:flutter/material.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';

import '../core/theme/app_color.dart';
import '../core/theme/app_text_theme.dart';

class WideBookCard extends StatelessWidget {
  const WideBookCard({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            height: 160,
            width: 120,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  child: Image.asset(
                    'assets/images/book (5).png',
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGreenAccentColor,
                    ),
                    child: Text(
                      '20%',
                      style: kBodyText.copyWith(
                        color: kWhiteColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 250,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'خلاصه 360 درجه',
                          style: TextStyle(
                              color: kGreyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 150,
                          child: Text(
                            'کتاب صوتی مسیر نایکی',
                            style: kBodyMedium.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'جولی استراسر و لاواری بکلاند',
                          style: TextStyle(
                            color: kGreyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Iconify(Fluent.bookmark_28_regular),
                  ],
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                  onTap: onTap,
                  color: kDarkRedColor,
                  child: const Text(
                    'خرید نسخه صوتی',
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '15000 تومان',
                      style: TextStyle(color: kDarkRedColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
