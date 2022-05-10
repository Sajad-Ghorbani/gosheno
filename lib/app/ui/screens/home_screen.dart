import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/ui/screens/comments_screen.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';
import 'package:gosheno/app/ui/theme/app_text_theme.dart';
import 'package:gosheno/app/ui/widgets/book_card.dart';
import 'package:gosheno/app/ui/widgets/wide_book_card.dart';

import '../../routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          title: const Text('گوشنو'),
          centerTitle: true,
          floating: true,
          snap: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.shoppingCart),
            splashRadius: 25,
          ),
          actions: [
            OpenContainer(
              closedBuilder: (context, action) {
                return const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(FeatherIcons.search),
                );
              },
              closedColor: Colors.transparent,
              closedElevation: 0,
              openBuilder: (context, action) {
                return const CommentsScreen();
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
                  height: 170,
                ),
                items: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset('assets/images/carousel.png'),
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
                                  onTap: () {},
                                  borderRadius: const BorderRadius.all(
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
                        child: Container(
                          width: 30,
                          height: 40,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kBlueGreyColor.withOpacity(0.7),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.asset(
                            'assets/images/gosheno-logo.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'کتاب های تخفیف دار',
                      style: kBodyMedium,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'مشاهده همه',
                            style: TextStyle(color: kGreenAccentColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: kGreenAccentColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    BookCard(
                      imageAddress: 'assets/images/book (1).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 21,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book1',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book1',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (2).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 15,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book2',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book2',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (5).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 32,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book5',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book5',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (6).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 18,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book6',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book6',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (7).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 55,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book7',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book7',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (8).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 9,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      showTimer: true,
                      tag: 'off-book8',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'off-book8',
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  'دسته بندی ها',
                  style: kBodyMedium,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset('assets/images/11.png',
                          width: size.width * 0.45),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Image.asset('assets/images/12.png',
                          width: size.width * 0.45),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Image.asset('assets/images/13.png',
                          width: size.width * 0.45),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {},
                      child: Image.asset('assets/images/14.png',
                          width: size.width * 0.45),
                    ),
                  ],
                ),
              ),
              Container(
                color: kGreenAccentColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: Image.asset(
                          'assets/images/week-books.png',
                          height: 150,
                        ),
                      ),
                      const SizedBox(width: 20),
                      WideBookCard(onTap: () {}),
                      const SizedBox(width: 10),
                      WideBookCard(onTap: () {}),
                      const SizedBox(width: 10),
                      WideBookCard(onTap: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'پر بازدید ترین ها',
                      style: kBodyMedium,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'مشاهده همه',
                            style: TextStyle(color: kGreenAccentColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: kGreenAccentColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    BookCard(
                      imageAddress: 'assets/images/book (1).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 21,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book1',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book1',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (2).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 15,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book2',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book2',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (5).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 32,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book5',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book5',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (6).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 18,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book6',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book6',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (7).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 55,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book7',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book7',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (8).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 9,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'view-book8',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'view-book8',
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/2.png'),
                      fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          'کتاب هایی که از خانوم ها ملکه میسازد',
                          textAlign: TextAlign.center,
                          style: kBodyLarge.copyWith(
                              color: kWhiteColor, height: 1.5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (1).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 21,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book1',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book1',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (2).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 15,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book2',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (5).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 32,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book5',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book5',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (6).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 18,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book6',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book6',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (7).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 55,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book7',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book7',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (8).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 9,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'q-book8',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'q-book8',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'جدیدترین ترین ها',
                      style: kBodyMedium,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'مشاهده همه',
                            style: TextStyle(color: kGreenAccentColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: kGreenAccentColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    BookCard(
                      imageAddress: 'assets/images/book (1).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 21,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book1',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book1',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (2).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 15,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book2',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book2',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (5).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 32,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book5',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book5',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (6).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 18,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book6',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book6',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (7).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 55,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book7',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book7',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    BookCard(
                      imageAddress: 'assets/images/book (8).png',
                      bookTitle: 'کتاب صوتی مسیر نایکی',
                      moreContent: 'خلاصه 360 درجه',
                      offCount: 9,
                      writer: 'جولی استراسر و لاوری بکلاند',
                      tag: 'new-book8',
                      onTap: () {
                        Get.toNamed(
                          Routes.singleBookScreen,
                          arguments: 'new-book8',
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          'کتاب های مخصوص مدیران حرفه ای',
                          textAlign: TextAlign.center,
                          style: kBodyLarge.copyWith(
                              color: kWhiteColor, height: 1.5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (1).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 21,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book1',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book1',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (2).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 15,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book2',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book2',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (5).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 32,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book5',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book5',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (6).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 18,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book6',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book6',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (7).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 55,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book7',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book7',
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BookCard(
                        imageAddress: 'assets/images/book (8).png',
                        bookTitle: 'کتاب صوتی مسیر نایکی',
                        moreContent: 'خلاصه 360 درجه',
                        offCount: 9,
                        writer: 'جولی استراسر و لاوری بکلاند',
                        tag: 'man-book8',
                        onTap: () {
                          Get.toNamed(
                            Routes.singleBookScreen,
                            arguments: 'man-book8',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/11.png',
                        width: size.width * 0.45),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/12.png',
                        width: size.width * 0.45),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/13.png',
                        width: size.width * 0.45),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/14.png',
                        width: size.width * 0.45),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
