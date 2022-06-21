import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/uim.dart';

import '../core/theme/app_color.dart';
import '../core/theme/app_text_theme.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.books,
    required this.tag,
    this.showTimer,
    this.hasText = false,
    this.text,
    required this.onBookmarkPressed,
  }) : super(key: key);
  final bool? showTimer;
  final String tag;
  final List<Book> books;
  final bool hasText;
  final String? text;
  final VoidCallback onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showTimer == true ? 360 : 320,
      child: ListView.separated(
        itemCount: books.length > 8 ? 8 : books.length,
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          Book book = books[index];
          if (hasText) {
            if (index == 0) {
              return SizedBox(
                width: 160,
                child: Center(
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: kBodyLarge.copyWith(color: kWhiteColor, height: 1.5),
                  ),
                ),
              );
            }
          }
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: kGreyColor,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 10,
                            child: Hero(
                              tag: '$tag-${book.name}',
                              child: CachedNetworkImage(
                                imageUrl: '$baseUrl${book.pic}',
                                width: 80,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: book.offCount() > 0,
                            child: Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kGreenAccentColor,
                                ),
                                child: Text(
                                  '${book.offCount()}%',
                                  style: kBodyText.copyWith(
                                    color: kWhiteColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            book.short,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: kGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: Text(
                            book.name,
                            style: kBodyMedium.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.author,
                          style: const TextStyle(
                            color: kGreyColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: RatingBarIndicator(
                        rating: double.parse(book.rate!),
                        itemBuilder: (context, index) => const Iconify(
                          Uim.star,
                          color: kAmberColor,
                        ),
                        unratedColor: kAmberColor.withOpacity(0.3),
                        itemCount: 5,
                        itemSize: 20,
                        direction: Axis.horizontal,
                      ),
                    ),
                    showTimer == true
                        ? Column(
                            children: [
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                    color: kBorderColor,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: const [
                                    Text('06:22:38'),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    highlightColor: kLightGreyColor.withOpacity(0.4),
                    onTap: () {
                      Get.toNamed(
                        Routes.singleBookScreen,
                        parameters: {'tag': '$tag-${book.name}'},
                        arguments: book,
                      );
                    },
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Iconify(Fluent.bookmark_28_regular),
                  onPressed: onBookmarkPressed,
                  padding: const EdgeInsets.all(0),

                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }
}
