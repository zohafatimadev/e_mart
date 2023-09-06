import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 90, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(250)
      .margin(const EdgeInsets.symmetric(horizontal: 12))
      .white
      .padding(const EdgeInsets.all(12))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
