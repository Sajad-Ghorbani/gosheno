import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/routes/app_pages.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
    required this.book,
    required this.isBookmarked,
  }) : super(key: key);
  final Book book;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.singleBookScreen,
          parameters: {'tag': 'lib-${book.enName}'},
          arguments: {book, isBookmarked},
        );
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 100,
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: 'lib-${book.enName}',
                child: CachedNetworkImage(
                  imageUrl: '${AppConstants.baseUrl}${book.pic}',
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    // width: 150,
                    child: Text(
                      book.name,
                      style: kBodyMedium.copyWith(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    book.author,
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('پخش آفلاین'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
