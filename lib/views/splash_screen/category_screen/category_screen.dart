import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/splash_screen/category_screen/category_details.dart';
import 'package:get/get.dart';

import '../../../widgets_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        Scaffold(
          appBar: AppBar(
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 200),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(categoriesImages[index],
                          height: 170, width: 180, fit: BoxFit.cover),
                      10.heightBox,
                      categoriesList[index]
                          .text
                          .color(Colors.black)
                          .align(TextAlign.center)
                          .make(),
                    ],
                  )
                      .box
                      .color(lightGolden)
                      .rounded
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .make()
                      .onTap(() {
                    controller.getSubCategories(categoriesList[index]);

                    Get.to(() => CategoryDetails(title: categoriesList[index]));
                  });
                }),
          ),
        ),
        Scaffold: null);
  }
}
