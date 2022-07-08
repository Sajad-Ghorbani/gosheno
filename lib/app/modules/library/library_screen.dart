import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/modules/library/local_widget/book_item.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';

import 'library_controller.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LibraryController>(
        init: LibraryController(),
        builder: (controller) {
          return LoadingWidget(
            isLoading: controller.showLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('کتابخانه'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.selectedIndex = 0;
                            controller.update();
                          },
                          child: Chip(
                            label: const Text('همه'),
                            labelStyle:
                                kBodyMedium.copyWith(color: kWhiteColor),
                            backgroundColor: controller.selectedIndex == 0
                                ? kGreenAccentColor
                                : kLightGreenAccentColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            controller.selectedIndex = 1;
                            controller.update();
                          },
                          child: Chip(
                            label: const Text('خریداری شده'),
                            labelStyle:
                                kBodyMedium.copyWith(color: kWhiteColor),
                            backgroundColor: controller.selectedIndex == 1
                                ? kGreenAccentColor
                                : kLightGreenAccentColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            controller.selectedIndex = 2;
                            controller.update();
                          },
                          child: Chip(
                            label: const Text('اشتراکی'),
                            labelStyle:
                                kBodyMedium.copyWith(color: kWhiteColor),
                            backgroundColor: controller.selectedIndex == 2
                                ? kGreenAccentColor
                                : kLightGreenAccentColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            controller.selectedIndex = 3;
                            controller.update();
                          },
                          child: Chip(
                            label: const Text('مورد علاقه'),
                            labelStyle:
                                kBodyMedium.copyWith(color: kWhiteColor),
                            backgroundColor: controller.selectedIndex == 3
                                ? kGreenAccentColor
                                : kLightGreenAccentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.getListLength(),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        Book book = controller.getBook(index);
                        List<Book> myBooks = Get.find<HomeController>().myBooks;
                        if (controller.selectedIndex == 1) {
                          bool isBookmarked =
                              myBooks.any((myBook) => myBook.id == book.id);
                          return BookItem(
                            isBookmarked: isBookmarked,
                            book: book,
                          );
                        } else if (controller.selectedIndex == 2) {
                          bool isBookmarked =
                              myBooks.any((myBook) => myBook.id == book.id);
                          return BookItem(
                              book: book, isBookmarked: isBookmarked);
                        } else if (controller.selectedIndex == 3) {
                          bool isBookmarked =
                              myBooks.any((myBook) => myBook.id == book.id);
                          return BookItem(
                              book: book, isBookmarked: isBookmarked);
                        } else {
                          bool isBookmarked =
                              myBooks.any((myBook) => myBook.id == book.id);
                          return BookItem(
                              book: book, isBookmarked: isBookmarked);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
