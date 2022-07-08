import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/routes/app_pages.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.showMore = true,
    this.bookList,
  }) : super(key: key);
  final String title;
  final bool showMore;
  final List<Book>? bookList;

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
                  onTap: () {
                    Get.toNamed(
                      Routes.allBookScreen,
                      parameters: {'title': title},
                      arguments: bookList,
                    );
                  },
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
