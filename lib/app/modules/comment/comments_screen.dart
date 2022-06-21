import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/modules/comment/comment_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uim.dart';

import '../../data/models/comment_model.dart';

class CommentsScreen extends GetView<CommentController> {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دیدگاه کاربران'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: kWhiteColor,
          splashRadius: 25,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.comments.isEmpty
                ? const Center(
                    child: Text('دیدگاهی ثبت نشده است', style: kBodyMedium),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(10),
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.comments.length,
                    itemBuilder: (context, index) {
                      BookComment comment = controller.comments[index];
                      return Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(comment.text),
                              ),
                              const SizedBox(width: 10),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: RatingBarIndicator(
                                  rating: double.parse(comment.rate),
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
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: kWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: kBlackColor.withOpacity(0.4),
                  offset: const Offset(0, -1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: CustomButtonWidget(
              onTap: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    color: kWhiteColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'نظر خود را بنویسید',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.commentController,
                          labelText: 'نظر خود را بنویسید',
                          height: null,
                          maxLines: 3,
                          minLines: 3,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'امتیاز خود را بدهید',
                        ),
                        const SizedBox(height: 10),
                        RatingBar.builder(
                          onRatingUpdate: (double value) {
                            controller.commentRating = value;
                          },
                          initialRating: controller.commentRating,
                          itemBuilder: (BuildContext context, int index) =>
                              const Iconify(
                            Uim.star,
                            color: kAmberColor,
                          ),
                          unratedColor: kAmberColor.withOpacity(0.3),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(height: 10),
                        CustomButtonWidget(
                          onTap: () {
                            controller.addComment();
                          },
                          color: kGreenAccentColor,
                          width: double.infinity,
                          child: Text(
                            'ارسال',
                            style: kBodyMedium.copyWith(color: kWhiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              color: kGreenAccentColor,
              width: double.infinity,
              child: Text(
                'ارسال نظر',
                style: kBodyMedium.copyWith(color: kWhiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
