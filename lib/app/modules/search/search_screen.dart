import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/global_widgets/category_book.dart';
import 'package:gosheno/app/modules/search/search_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController controller = Get.put<SearchController>(SearchController());
    return WillPopScope(
      onWillPop: () async {
        return controller.popSearch();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: CustomTextField(
                  labelText: 'جست و جو',
                  controller: controller.searchController,
                  height: 50,
                  autofocus: true,
                  textAlign: TextAlign.start,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Iconify(
                      Ep.search,
                      size: 12,
                      color: kGreenAccentColor,
                    ),
                  ),
                  onChanged: (value) {
                    controller.search(value);
                  },
                ),
              ),
              Expanded(
                child: GetBuilder<SearchController>(
                  builder: (_) {
                    if (controller.books.isEmpty) {
                      return const Center(
                        child: Text('هیچ داده ای برای نمایش وجود ندارد.'),
                      );
                    } //
                    else {
                      return GridView(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: Get.width / 2 - 20,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 320,
                        ),
                        children: controller.books
                            .map(
                              (Book book) => GetBuilder<HomeController>(
                                builder: (controller) {
                                  bool isBookmarked = controller.myBooks
                                      .any((myBook) => myBook.id == book.id);
                                  return CategoryBook(
                                    tag: 'se',
                                    book: book,
                                    isBookmarked: isBookmarked,
                                    bookmarkBook: controller.bookmarkBook,
                                  );
                                },
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
