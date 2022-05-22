import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کتابخانه'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text('همه'),
                    labelStyle: kBodyMedium.copyWith(color: kWhiteColor),
                    backgroundColor: kLightGreenAccentColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text('خریداری شده'),
                    labelStyle: kBodyMedium.copyWith(color: kWhiteColor),
                    backgroundColor: kLightGreenAccentColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text('در حال مطالعه'),
                    labelStyle: kBodyMedium.copyWith(color: kWhiteColor),
                    backgroundColor: kLightGreenAccentColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text('مورد علاقه'),
                    labelStyle: kBodyMedium.copyWith(color: kWhiteColor),
                    backgroundColor: kLightGreenAccentColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text('پخش آفلاین'),
                    labelStyle: kBodyMedium.copyWith(color: kWhiteColor),
                    backgroundColor: kLightGreenAccentColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.singleBookScreen,
                      arguments: 'book$index',
                    );
                  },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          child: Hero(
                            tag: 'book$index',
                            child: Image.asset(
                              'assets/images/book (5).png',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'کتاب صوتی مسیر نایکی',
                                  style: kBodyMedium.copyWith(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'جولی استراسر و لاواری بکلاند',
                                style: TextStyle(
                                  color: kGreyColor,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text('پخش آفلاین'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
