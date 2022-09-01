import 'package:flutter/material.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class SubscribeCard extends StatelessWidget {
  const SubscribeCard({
    Key? key,
    required this.color,
    required this.subscribeMonth,
    required this.type,
    required this.booksViewCount,
    required this.price,
    required this.offPrice,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final String subscribeMonth;
  final String type;
  final String booksViewCount;
  final String price;
  final String offPrice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.6),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.6),
                      color,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: kWhiteColor,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                height: 75,
                width: 75,
                child: const Iconify(
                  Mdi.crown,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'اشتراک ',
                    style: TextStyle(color: kGreyColor),
                  ),
                  Text(
                    type,
                    style: kBodyMedium.copyWith(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'مدت اشتراک: ',
                style: TextStyle(color: kGreyColor),
              ),
              Text(
                '$subscribeMonth ماه',
                style: kBodyMedium.copyWith(color: kGreenAccentColor),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'سقف تعداد کتاب قابل مشاهده: ',
                style: TextStyle(color: kGreyColor),
              ),
              Text(
                booksViewCount,
                style: kBodyMedium.copyWith(color: kGreenAccentColor),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '$offPrice تومان',
                    style: const TextStyle(
                      color: kRedColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$price تومان',
                    style: kBodyMedium.copyWith(color: kGreenAccentColor),
                  ),
                ],
              ),
              CircleButtonWidget(
                onTap: onTap,
                color: kGreenAccentColor,
                width: 120,
                height: 40,
                child: Text(
                  'خرید',
                  style: kBodyMedium.copyWith(color: kWhiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
