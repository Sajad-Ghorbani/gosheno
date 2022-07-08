import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/modules/book/book_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/uim.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_theme.dart';

class SingleBookScreen extends GetView<BookController> {
  const SingleBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? heroTag = Get.parameters['tag'];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            GetBuilder<BookController>(
              initState: (_) =>
                  controller.getComments(int.parse(controller.book!.id)),
              builder: (_) {
                return SliverAppBar(
                  pinned: true,
                  title: AnimatedOpacity(
                    opacity: controller.opacityAnimation,
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      controller.book!.name,
                      style: const TextStyle(
                        color: kBlackColor,
                      ),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: kWhiteGreyColor,
                  expandedHeight: 280,
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
                                  height: 170,
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 10,
                                        child: Hero(
                                          tag: heroTag!,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${AppConstants.baseUrl}${controller.book!.pic}',
                                            width: 86,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            controller.book!.offCount() > 0,
                                        child: Positioned(
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(7),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kGreenAccentColor,
                                            ),
                                            child: Text(
                                              '${controller.book!.offCount()}%',
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
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: RatingBarIndicator(
                                    rating: double.parse(controller.book!.rate),
                                    itemBuilder: (context, index) =>
                                        const Iconify(
                                      Uim.star,
                                      color: kAmberColor,
                                    ),
                                    unratedColor: kAmberColor.withOpacity(0.3),
                                    itemCount: 5,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                  ),
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.book!.name,
                                                style: kBodyMedium.copyWith(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                controller.book!.enName,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                controller.book!.author,
                                                style: const TextStyle(
                                                  color: kGreyColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                controller.book!.short,
                                                overflow: TextOverflow.ellipsis,
                                                style: kSubTitle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Iconify(
                                            controller.isBookmarked
                                                ? Fluent.bookmark_28_filled
                                                : Fluent.bookmark_28_regular,
                                          ),
                                          onPressed: () {
                                            controller.toggleBookmark();
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible:
                                              controller.book!.offCount() > 0,
                                          child: Text(
                                            '${controller.book!.sPrice.seRagham()} تومان / ',
                                            style: kBodyText.copyWith(
                                              color: kDarkRedColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${controller.book!.price.seRagham()} تومان',
                                          style: TextStyle(
                                            color: kDarkRedColor,
                                            decoration:
                                                controller.book!.offCount() > 0
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.commentsScreen,
                                          arguments: controller.comments,
                                          parameters: {
                                            'bookId': controller.book!.id,
                                          },
                                        );
                                      },
                                      child: Text(
                                        'نظرها (${controller.commentCount})',
                                        style: const TextStyle(
                                            color: kLightGreenColor),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    CustomButtonWidget(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.audioPlayerScreen,
                                          arguments: controller.book,
                                        );
                                      },
                                      color: kGreenAccentColor,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Iconify(
                                            Ep.video_play,
                                            // size: 18,
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
                );
              },
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: GetBuilder<BookController>(
                  builder: (_) {
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
              sliver: GetBuilder<BookController>(builder: (_) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 10),
                      const Text(
                        'درباره کتاب',
                        style: kBodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.book!.about,
                        style: kBodyText.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'درباره نویسنده',
                        style: kBodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.book!.authorContent,
                        style: kBodyText.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }),
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
