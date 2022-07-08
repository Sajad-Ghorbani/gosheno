import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/global_widgets/section_title.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/book_card.dart';
import 'package:gosheno/app/modules/home/local_widget/wide_book_card.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/modules/search/search_screen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../../../core/utils/app_constants.dart';
import '../../../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return LoadingWidget(
        isLoading: controller.showLoading,
        child: RefreshIndicator(
          onRefresh: () {
            return controller.init();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('گوشنو'),
                centerTitle: true,
                floating: true,
                snap: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Iconify(
                    Ph.shopping_cart_simple,
                    color: kWhiteColor,
                  ),
                  splashRadius: 25,
                ),
                actions: [
                  OpenContainer(
                    closedBuilder: (context, action) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: Iconify(
                          Ep.search,
                          color: kWhiteColor,
                        ),
                      );
                    },
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    openBuilder: (context, action) {
                      return const SearchScreen();
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        height: 180,
                      ),
                      items: controller.sliders
                          .map((slide) => Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  '${AppConstants.baseUrl}${slide.image}'),
                                        ),
                                        Positioned.fill(
                                          child: Material(
                                            color: Colors.transparent,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: InkWell(
                                              highlightColor: kLightGreyColor
                                                  .withOpacity(0.4),
                                              onTap: () {
                                                controller.sliderTapped(slide);
                                              },
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 15,
                                    child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset(
                                        'assets/images/gosheno-logo2.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    SectionTitle(
                      title: 'کتاب های تخفیف دار',
                      bookList: controller.offersBooks,
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return BookCard(
                          books: controller.offersBooks,
                          tag: 'off',
                          onBookmarkPressed: (bookId) {
                            controller.bookmarkBook(bookId);
                          },
                          myBooks: controller.myBooks,
                        );
                      },
                    ),
                    const SectionTitle(title: 'دسته بندی ها', showMore: false),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return SizedBox(
                          height: 150,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              BookCategory cat = controller.categories[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      kLightGreenAccentColor.withOpacity(0.6),
                                ),
                                padding: const EdgeInsets.all(8),
                                width: 150,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.categoryScreen,
                                      parameters: {
                                        'catId': cat.id,
                                        'catName': cat.name,
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: '${AppConstants.baseUrl}${cat.icon}',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        cat.name,
                                        textAlign: TextAlign.center,
                                        style: kBodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        );
                      },
                    ),
                    WideBookCard(
                      onBuyTap: () {},
                      tag: 'sell',
                      books: controller.topSellsBooks,
                      myBooks: controller.myBooks,
                      onBookmarkPressed: (bookId) {
                        controller.bookmarkBook(bookId);
                      },
                    ),
                    const SizedBox(height: 10),
                    SectionTitle(
                      title: 'پر بازدید ترین ها',
                      bookList: controller.mostViewedBooks,
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return BookCard(
                          books: controller.mostViewedBooks,
                          tag: 'most',
                          onBookmarkPressed: (bookId) {
                            controller.bookmarkBook(bookId);
                          },
                          myBooks: controller.myBooks,
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: BookCard(
                            books: controller.queensBooks,
                            tag: 'women',
                            hasText: true,
                            text: 'کتاب هایی که از خانوم ها ملکه میسازد',
                            onBookmarkPressed: (bookId) {
                              controller.bookmarkBook(bookId);
                            },
                            myBooks: controller.myBooks,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    SectionTitle(
                      title: 'جدیدترین ترین ها',
                      bookList: controller.newestBooks,
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return BookCard(
                          books: controller.newestBooks,
                          tag: 'new',
                          onBookmarkPressed: (bookId) {
                            controller.bookmarkBook(bookId);
                          },
                          myBooks: controller.myBooks,
                        );
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GetBuilder<HomeController>(
                        builder: (controller) {
                          return BookCard(
                            books: controller.managersBooks,
                            tag: 'manager',
                            hasText: true,
                            text: 'کتاب های مخصوص مدیران حرفه ای',
                            onBookmarkPressed: (bookId) {
                              controller.bookmarkBook(bookId);
                            },
                            myBooks: controller.myBooks,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SectionTitle(
                      title: 'محبوب ترین ها',
                      bookList: controller.favoriteBooks,
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) {
                        return BookCard(
                          books: controller.favoriteBooks,
                          tag: 'fav',
                          onBookmarkPressed: (bookId) {
                            controller.bookmarkBook(bookId);
                          },
                          myBooks: controller.myBooks,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.categoryScreen,
                              parameters: {
                                'catId': '1',
                                'catName': 'کتاب های مخصوص مدیران حرفه ای',
                              },
                            );
                          },
                          child: Image.asset(
                            'assets/images/11.png',
                            width: size.width * 0.45,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.categoryScreen,
                              parameters: {
                                'catId': '5',
                                'catName':
                                    'کتاب هایی که بهت کمک میکنه بازاریاب بهتری بشی',
                              },
                            );
                          },
                          child: Image.asset(
                            'assets/images/12.png',
                            width: size.width * 0.45,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.categoryScreen,
                              parameters: {
                                'catId': '7',
                                'catName': 'کتاب هایی که ثروتمندت میکنه',
                              },
                            );
                          },
                          child: Image.asset(
                            'assets/images/13.png',
                            width: size.width * 0.45,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.categoryScreen,
                              parameters: {
                                'catId': '3',
                                'catName': 'با این کتاب ها خودتو بهتر بشناس',
                              },
                            );
                          },
                          child: Image.asset(
                            'assets/images/14.png',
                            width: size.width * 0.45,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
