import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/modules/home/local_widget/category_book.dart';

class AllBookScreen extends GetView<HomeController> {
  const AllBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = Get.parameters['title']!;
    List<Book> books = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kWhiteColor,
          ),
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Get.width / 2 - 20,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 320,
        ),
        children: books
            .map(
              (Book book) => GetBuilder<HomeController>(
                builder: (controller) {
                  bool isBookmarked =
                      controller.myBooks.any((myBook) => myBook.id == book.id);
                  return CategoryBook(
                    tag: 'cat',
                    book: book,
                    isBookmarked: isBookmarked,
                    bookmarkBook: controller.bookmarkBook,
                  );
                },
              ),
            ).toList(),
      ),
    );
  }
}
