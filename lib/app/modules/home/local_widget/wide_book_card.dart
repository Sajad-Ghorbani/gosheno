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
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_theme.dart';

class WideBookCard extends StatelessWidget {
  const WideBookCard({
    Key? key,
    required this.onBuyTap,
    required this.tag,
    required this.onBookmarkPressed,
    required this.myBooks,
    required this.books,
  }) : super(key: key);
  final VoidCallback onBuyTap;
  final String tag;
  final ValueChanged<Book> onBookmarkPressed;
  final List<Book> myBooks;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreenAccentColor,
      height: 220,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        itemCount: books.length,
        itemBuilder: (context, index) {
          Book book = books[index];
          bool isBookmarked = myBooks.any((myBook) => myBook.id == book.id);
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20),
              child: Image.asset(
                'assets/images/week-books.png',
                height: 150,
              ),
            );
          }
          return Stack(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    Container(
                      height: 160,
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 10,
                            child: Hero(
                              tag: '$tag-${book.enName}',
                              child: CachedNetworkImage(
                                imageUrl: '${AppConstants.baseUrl}${book.pic}',
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: book.offCount > 0,
                            child: Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kGreenAccentColor,
                                ),
                                child: Text(
                                  '${book.offCount}%',
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
                    Container(
                      width: 250,
                      padding: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            book.short,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: kGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 200,
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '${book.price.seRagham()} تومان',
                                style: TextStyle(
                                  color:
                                  book.offCount > 0 ? kGreyColor : kDarkRedColor,
                                  decoration: book.offCount > 0
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontSize: 12,
                                ),
                              ),
                              Visibility(
                                visible: book.offCount > 0,
                                child: Text(
                                  ' / ${book.sPrice?.seRagham()} تومان',
                                  style: kBodyText.copyWith(
                                    color: kDarkRedColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: RatingBarIndicator(
                              rating: double.parse(book.rate),
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
                        ],
                      ),
                    ),
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
                        parameters: {'tag': '$tag-${book.enName}'},
                        arguments: {book, isBookmarked},
                      );
                    },
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  icon: isBookmarked
                      ? const Iconify(Fluent.bookmark_28_filled)
                      : const Iconify(Fluent.bookmark_28_regular),
                  onPressed: () {
                    onBookmarkPressed(book);
                  },
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
