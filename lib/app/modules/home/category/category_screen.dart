import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/global_widgets/book_card.dart';
import 'package:gosheno/app/global_widgets/section_title.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/uim.dart';

class CategoryScreen extends GetView<HomeController> {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String catId = Get.parameters['catId']!;
    String catName = Get.parameters['catName']!;
    return WillPopScope(
      onWillPop: () async {
        controller.willPopCategoryScreen();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(catName),
          leading: IconButton(
            splashRadius: 25,
            onPressed: () {
              controller.willPopCategoryScreen();
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhiteColor,
            ),
          ),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            GetBuilder<HomeController>(
              initState: (_) =>
                  Get.find<HomeController>().initCategoryBooks(catId),
              builder: (controller) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (controller.categoryOfferBooks.isNotEmpty)
                        const SizedBox(height: 10),
                      if (controller.categoryOfferBooks.isNotEmpty)
                        SectionTitle(title: 'کتاب های تخفیف دار', onTap: () {}),
                      if (controller.categoryOfferBooks.isNotEmpty)
                        BookCard(
                          books: controller.categoryOfferBooks,
                          tag: 'off',
                          onBookmarkPressed: () {},
                          showTimer: true,
                        ),
                      if (controller.categoryMostViewedBooks.isNotEmpty)
                        const SizedBox(height: 10),
                      if (controller.categoryMostViewedBooks.isNotEmpty)
                        SectionTitle(title: 'پر بازدید ترین ها', onTap: () {}),
                      if (controller.categoryMostViewedBooks.isNotEmpty)
                        BookCard(
                          books: controller.categoryMostViewedBooks,
                          tag: 'most',
                          onBookmarkPressed: () {},
                        ),
                      if (controller.categoryFavoriteBooks.isNotEmpty)
                        const SizedBox(height: 10),
                      if (controller.categoryFavoriteBooks.isNotEmpty)
                        SectionTitle(title: 'محبوب ترین ها', onTap: () {}),
                      if (controller.categoryFavoriteBooks.isNotEmpty)
                        BookCard(
                          books: controller.categoryFavoriteBooks,
                          tag: 'fav',
                          onBookmarkPressed: () {},
                        ),
                      const SizedBox(height: 10),
                      const SectionTitle(title: 'کتاب های این دسته',showMore: false),
                      const SizedBox(height: 10),
                      Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceEvenly,
                        children: controller.categoryBooks
                            .map(
                              (Book book) => Stack(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                                padding:
                                                const EdgeInsets.all(7),
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                            style: kBodyMedium.copyWith(
                                                fontSize: 16),
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
                                        rating: double.parse(book.rate!),
                                        itemBuilder: (context, index) =>
                                        const Iconify(
                                          Uim.star,
                                          color: kAmberColor,
                                        ),
                                        unratedColor:
                                        kAmberColor.withOpacity(0.3),
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
                                    highlightColor:
                                    kLightGreyColor.withOpacity(0.4),
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.singleBookScreen,
                                        parameters: {
                                          'tag': '$tag-${book.name}'
                                        },
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
                                  icon:
                                  const Iconify(Fluent.bookmark_28_regular),
                                  onPressed: () {},
                                  padding: const EdgeInsets.all(0),
                                ),
                              ),
                            ],
                          ),
                        )
                            .toList(),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
