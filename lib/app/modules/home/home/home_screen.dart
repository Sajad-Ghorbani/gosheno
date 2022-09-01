import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/global_widgets/section_title.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
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
                  onPressed: () {
                    Get.toNamed(Routes.cartScreen);
                  },
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
                          onBookmarkPressed: (book) {
                            controller.bookmarkBook(book);
                          },
                          myBooks: controller.myBooks,
                        );
                      },
                    ),
                    WideBookCard(
                      onBuyTap: () {},
                      tag: 'sell',
                      books: controller.topSellsBooks,
                      myBooks: controller.myBooks,
                      onBookmarkPressed: (book) {
                        controller.bookmarkBook(book);
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
                          onBookmarkPressed: (book) {
                            controller.bookmarkBook(book);
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
                            onBookmarkPressed: (book) {
                              controller.bookmarkBook(book);
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
                          onBookmarkPressed: (book) {
                            controller.bookmarkBook(book);
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
                            onBookmarkPressed: (book) {
                              controller.bookmarkBook(book);
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
                          onBookmarkPressed: (book) {
                            controller.bookmarkBook(book);
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
