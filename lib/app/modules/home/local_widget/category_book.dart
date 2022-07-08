import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/uim.dart';

class CategoryBook extends StatelessWidget {
  const CategoryBook({
    Key? key,
    required this.tag,
    required this.book,
    required this.isBookmarked,
    required this.bookmarkBook,
  }) : super(key: key);
  final String tag;
  final Book book;
  final bool isBookmarked;
  final ValueChanged<String> bookmarkBook;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          imageUrl: '${AppConstants.baseUrl}${book.pic}',
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
                  SizedBox(
                    width: 150,
                    child: Text(
                      book.author,
                      style: const TextStyle(
                        color: kGreyColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
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
                  arguments: {book,isBookmarked},
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
            icon: Iconify(
              isBookmarked
                  ? Fluent.bookmark_28_filled
                  : Fluent.bookmark_28_regular,
            ),
            onPressed: () {
              bookmarkBook(book.id);
            },
            padding: const EdgeInsets.all(0),
          ),
        ),
      ],
    );
  }
}
