import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';
import 'package:gosheno/app/ui/theme/app_text_theme.dart';
import 'package:gosheno/app/ui/widgets/custom_button_widget.dart';
import 'package:gosheno/app/ui/widgets/scores_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CommentsScreen extends StatelessWidget {
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
          splashRadius: 25,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'علی زارعی',
                              style: kBodyMedium,
                            ),
                            const Spacer(),
                            const ScoresWidget(),
                            const SizedBox(width: 5),
                            Text(DateTime.now()
                                .add(Duration(days: index))
                                .toPersianDateStr()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان '
                          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان '
                          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان '
                          'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ،',
                          maxLines: 1 * (index + 1),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('${((35 * (index + 5)) + 2) ~/ (index + 1)}'),
                            const SizedBox(width: 5),
                            const Icon(
                              FeatherIcons.thumbsUp,
                              size: 18,
                              color: kGreyColor,
                            ),
                            const SizedBox(width: 20),
                            Text('${((12 * index + 5) + 12) ~/ (index + 1)}'),
                            const SizedBox(width: 5),
                            const Icon(
                              FeatherIcons.thumbsDown,
                              size: 18,
                              color: kGreyColor,
                            ),
                          ],
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('5 ستاره'),
                    SizedBox(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: kGreyColor.withOpacity(0.2)),
                              color: kGreyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kAmberColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('36'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('4 ستاره'),
                    SizedBox(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: kGreyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kAmberColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('30'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('3 ستاره'),
                    SizedBox(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: kGreyColor.withOpacity(0.2)),
                              color: kGreyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kAmberColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('24'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('2 ستاره'),
                    SizedBox(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: kGreyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kAmberColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('18'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('1 ستاره'),
                    SizedBox(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: kGreyColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kAmberColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('6'),
                  ],
                ),
                const SizedBox(height: 10),
                CustomButtonWidget(
                    child: Text(
                      'ارسال نظر',
                      style: kBodyMedium.copyWith(color: kWhiteColor),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {},
                    color: kGreenAccentColor,
                    width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
