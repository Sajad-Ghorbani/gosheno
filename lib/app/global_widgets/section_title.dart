import 'package:flutter/material.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {Key? key,
      required this.title,
      this.onTap,
      this.showMore = true})
      : super(key: key);
  final String title;
  final VoidCallback? onTap;
  final bool showMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kBodyMedium,
          ),
          showMore
              ? InkWell(
                  onTap: onTap,
                  child: Row(
                    children: const [
                      Text(
                        'مشاهده همه',
                        style: TextStyle(color: kGreenAccentColor),
                      ),
                      Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: kGreenAccentColor,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
