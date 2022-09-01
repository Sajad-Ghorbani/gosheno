import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/data/models/activity_model.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uim.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'activity_controller.dart';

class ActivityScreen extends GetView<ActivityController> {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityController>(
      builder: (_) {
        return DefaultTabController(
          length: 2,
          child: LoadingWidget(
            isLoading: controller.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('فعالیت ها'),
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
                bottom: const TabBar(
                  tabs: [
                    Text('نظرات'),
                    Text('امتیازات'),
                  ],
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              body: TabBarView(
                children: [
                  ListView.separated(
                    itemCount: controller.activities.length,
                    itemBuilder: (context, index) {
                      Activity activity = controller.activities[index];
                      String time = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(activity.time) * 1000)
                          .toPersianDateStr();
                      return ListTile(
                        title: Text(activity.text),
                        subtitle: Text(controller.books[index].name),
                        trailing: Text(time),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                  ListView.separated(
                    itemCount: controller.activities.length,
                    itemBuilder: (context, index) {
                      Activity activity = controller.activities[index];
                      String time = DateTime.fromMillisecondsSinceEpoch(
                              int.parse(activity.time) * 1000)
                          .toPersianDateStr();
                      return ListTile(
                        title: Text(controller.books[index].name),
                        subtitle: Text(time),
                        trailing: Directionality(
                          textDirection: TextDirection.ltr,
                          child: RatingBarIndicator(
                            rating:
                                double.parse(activity.rate),
                            itemBuilder: (context, index) => const Iconify(
                              Uim.star,
                              color: kAmberColor,
                            ),
                            unratedColor: kAmberColor.withOpacity(0.3),
                            itemCount: 5,
                            itemSize: 20,
                            direction: Axis.horizontal,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
