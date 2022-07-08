import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/global_widgets/book_card.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/global_widgets/section_title.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';

import '../local_widget/category_book.dart';

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
      child: GetX<HomeController>(
          initState: (_) => Get.find<HomeController>().initCategoryBooks(catId),
          builder: (_) {
            return LoadingWidget(
              isLoading: controller.showCategoryLoading.value,
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
                body: GetBuilder<HomeController>(builder: (_) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            if (controller.categoryOfferBooks.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              SectionTitle(
                                title: 'کتاب های تخفیف دار',
                                bookList: controller.categoryOfferBooks,
                              ),
                              BookCard(
                                books: controller.categoryOfferBooks,
                                tag: 'off',
                                onBookmarkPressed: (bookId) {
                                  controller.bookmarkBook(bookId);
                                },
                                myBooks: controller.myBooks,
                              ),
                            ],
                            if (controller
                                .categoryMostViewedBooks.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              SectionTitle(
                                title: 'پر بازدید ترین ها',
                                bookList: controller.categoryMostViewedBooks,
                              ),
                              BookCard(
                                books: controller.categoryMostViewedBooks,
                                tag: 'most',
                                onBookmarkPressed: (bookId) {
                                  controller.bookmarkBook(bookId);
                                },
                                myBooks: controller.myBooks,
                              ),
                            ],
                            if (controller
                                .categoryFavoriteBooks.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              SectionTitle(
                                title: 'محبوب ترین ها',
                                bookList: controller.categoryFavoriteBooks,
                              ),
                              BookCard(
                                books: controller.categoryFavoriteBooks,
                                tag: 'fav',
                                onBookmarkPressed: controller.bookmarkBook,
                                myBooks: controller.myBooks,
                              ),
                            ],
                            const SizedBox(height: 10),
                            const SectionTitle(
                              title: 'کتاب های این دسته',
                              showMore: false,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              runSpacing: 10,
                              alignment: WrapAlignment.spaceEvenly,
                              children: controller.categoryBooks
                                  .map(
                                    (Book book) => GetBuilder<HomeController>(
                                      builder: (controller) {
                                        bool isBookmarked = controller.myBooks
                                            .any((myBook) =>
                                                myBook.id == book.id);
                                        return CategoryBook(
                                          tag: 'cat',
                                          book: book,
                                          isBookmarked: isBookmarked,
                                          bookmarkBook: controller.bookmarkBook,
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          }),
    );
  }
}
