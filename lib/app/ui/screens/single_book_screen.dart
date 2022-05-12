import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/controllers/single_book_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/ui/widgets/custom_button_widget.dart';
import 'package:gosheno/app/ui/widgets/scores_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';

class SingleBookScreen extends GetView<SingleBookController> {
  const SingleBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              title: GetBuilder<SingleBookController>(
                init: SingleBookController(),
                builder: (controller) {
                  return AnimatedOpacity(
                    opacity: controller.opacityAnimation,
                    duration: const Duration(milliseconds: 200),
                    child: const Text(
                      'کتاب صوتی مسیر نایکی',
                      style: TextStyle(
                        color: kBlackColor,
                      ),
                    ),
                  );
                },
              ),
              elevation: 0,
              backgroundColor: kWhiteGreyColor,
              expandedHeight: 260,
              stretch: true,
              leading: IconButton(
                splashRadius: 25,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kBlackColor,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 160,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: 10,
                                    child: Hero(
                                      tag: controller.heroTag,
                                      child: Image.asset(
                                        'assets/images/book (5).png',
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kGreenAccentColor,
                                      ),
                                      child: Text(
                                        '20%',
                                        style: kBodyText.copyWith(
                                          color: kWhiteColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const ScoresWidget(),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'خلاصه 360 درجه',
                                          style: kSubTitle.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            'کتاب صوتی مسیر نایکی',
                                            style: kBodyMedium.copyWith(
                                                fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          'اثر جولی استراسر و لاواری بکلاند',
                                          style: TextStyle(
                                            color: kGreyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const SizedBox(
                                          width: 200,
                                          child: Text(
                                            'شجاعانه کار کن.سخت مذاکره کن و اشتیاق زیاد داشته باش',
                                            overflow: TextOverflow.ellipsis,
                                            style: kSubTitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(FeatherIcons.bookmark),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '15000'.seRagham() + ' تومان',
                                  style: const TextStyle(color: kDarkRedColor),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: const [
                                    Icon(
                                      FeatherIcons.clock,
                                      size: 14,
                                      color: kGreyColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text('45 دقیقه', style: kSubTitle),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.commentsScreen);
                                  },
                                  child: const Text(
                                    'نظرها (4)',
                                    style: TextStyle(color: kLightGreenColor),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomButtonWidget(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        FeatherIcons.playCircle,
                                        size: 18,
                                        color: kWhiteColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'گوش دادن نسخه دمو',
                                        style: TextStyle(
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.audioPlayerScreen,
                                    );
                                  },
                                  color: kGreenAccentColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: GetBuilder<SingleBookController>(
                  builder: (controller) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: kGreenAccentColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(controller.containerRadius),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: controller.containerMargin),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'خرید نسخه صوتی',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: kWeightBold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'خرید نسخه الکترونیکی',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: kWeightBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10),
                    const Text(
                      'درباره کتاب',
                      style: kBodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل'
                      'حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'مناسب چه کسانی است؟',
                      style: kBodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل'
                      'حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'درباره نویسنده',
                      style: kBodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حا'
                      'و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو'
                      'در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل'
                      'حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
                      style: kBodyText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
