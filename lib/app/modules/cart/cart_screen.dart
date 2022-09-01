import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/core/utils/constants_methods.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/cart/cart_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';

// import 'package:iconify_flutter/icons/gg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return LoadingWidget(
          isLoading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('سبد خرید'),
              centerTitle: true,
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: GetBuilder<CartController>(
                      builder: (_) {
                        if (controller.books.isEmpty) {
                          return Center(
                            child: Text(
                              'سبد خرید خالی است',
                              style:
                                  kBodyMedium.copyWith(color: kDarkBlueColor),
                            ),
                          );
                        } //
                        else {
                          return ListView.builder(
                            itemCount: controller.books.length,
                            itemBuilder: (context, index) {
                              var book = controller.books[index];
                              // int count = controller.booksCount[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kWhiteColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          '${AppConstants.baseUrl}${book.pic}',
                                      width: 80,
                                      height: 80,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SizedBox(
                                        height: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        book.name,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 1,
                                                        style: kBodyMedium
                                                            .copyWith(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            book.offCount > 0
                                                                ? book.sPrice!
                                                                    .seRagham()
                                                                : book.price
                                                                    .seRagham(),
                                                            style: kBodyMedium
                                                                .copyWith(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            ' تومان',
                                                            style: kBodyMedium
                                                                .copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  kGreenAccentColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .removeBook(index);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: const Iconify(
                                                      Bi.trash,
                                                      color: kRedColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     // Row(
                                            //     //   children: [
                                            //     //     IconButton(
                                            //     //       icon: const Iconify(
                                            //     //         Gg.math_plus,
                                            //     //         size: 20,
                                            //     //         color: kGreyColor,
                                            //     //       ),
                                            //     //       onPressed: () {
                                            //     //         controller
                                            //     //             .addBook(index);
                                            //     //       },
                                            //     //       color: kDarkBlueColor,
                                            //     //     ),
                                            //     //     Text(
                                            //     //       '$count',
                                            //     //       style: kBodyMedium,
                                            //     //     ),
                                            //     //     IconButton(
                                            //     //       icon: const Iconify(
                                            //     //         Gg.math_minus,
                                            //     //         size: 20,
                                            //     //         color: kGreyColor,
                                            //     //       ),
                                            //     //       onPressed: () {
                                            //     //         controller.decreaseBook(
                                            //     //             index);
                                            //     //       },
                                            //     //     ),
                                            //     //   ],
                                            //     // ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('مجموع سبد خرید', style: kBodyMedium),
                        Row(
                          children: [
                            Text(
                              '${controller.totalCartPrice}'.seRagham(),
                              style: kBodyMedium.copyWith(
                                color: kGreenAccentColor,
                              ),
                            ),
                            Text(
                              ' تومان',
                              style: kBodyMedium.copyWith(
                                color: kGreenAccentColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: CircleButtonWidget(
                      onTap: () {
                        controller.books.isNotEmpty
                            ? Get.toNamed(Routes.paymentScreen)
                            : ConstantsMethods.showToast(
                                'سبد خرید خالی است',
                                kRedColor,
                              );
                      },
                      width: 200,
                      height: 45,
                      color: kGreenAccentColor,
                      child: Text(
                        'ادامه',
                        style: kBodyMedium.copyWith(
                          fontSize: 20,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
