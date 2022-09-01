import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/global_widgets/book_card.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/global_widgets/section_title.dart';
import 'package:gosheno/app/modules/category/category_controller.dart';
import 'package:gosheno/app/global_widgets/category_book.dart';

class BooksOfCategoryScreen extends StatelessWidget {
  const BooksOfCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String catId = Get.parameters['catId']!;
    String catName = Get.parameters['catName']!;
    return GetBuilder<CategoryController>(
      init: CategoryController(),
      initState: (_) =>
          Get.find<CategoryController>().initCategoryBooks(int.parse(catId)),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.willPopCategoryScreen();
            return true;
          },
          child: LoadingWidget(
            isLoading: controller.showCategoryLoading,
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
                            onBookmarkPressed: controller.bookmarkBook,
                            myBooks: controller.myBooks,
                          ),
                        ],
                        if (controller.categoryMostViewedBooks.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          SectionTitle(
                            title: 'پر بازدید ترین ها',
                            bookList: controller.categoryMostViewedBooks,
                          ),
                          BookCard(
                            books: controller.categoryMostViewedBooks,
                            tag: 'most',
                            onBookmarkPressed: controller.bookmarkBook,
                            myBooks: controller.myBooks,
                          ),
                        ],
                        if (controller.categoryFavoriteBooks.isNotEmpty) ...[
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
                          children: controller.categoryBooks.map(
                            (Book book) {
                              bool isBookmarked = controller.myBooks
                                  .any((myBook) => myBook.id == book.id);
                              return CategoryBook(
                                tag: 'cat',
                                book: book,
                                isBookmarked: isBookmarked,
                                bookmarkBook: controller.bookmarkBook,
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
