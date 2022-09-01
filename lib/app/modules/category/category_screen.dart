import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/category/category_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: CategoryController(),
      builder: (controller) {
        return LoadingWidget(
          isLoading: controller.showLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('دسته بندی ها'),
              centerTitle: true,
            ),
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

              ),
              padding: const EdgeInsets.all(10),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                BookCategory cat = controller.categories[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kLightGreenAccentColor.withOpacity(0.6),
                  ),
                  padding: const EdgeInsets.all(8),
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.categoryScreen,
                        parameters: {
                          'catId': cat.id.toString(),
                          'catName': cat.name,
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          ),
        );
      },
    );
  }
}
