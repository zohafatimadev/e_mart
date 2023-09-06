import 'package:emart_app/consts/consts.dart';

Widget applogoWidget() {
  //using velocity x here
  return Image.asset(icAppLogo)
      .box
      .white
      .size(80, 80)
      .padding(const EdgeInsets.all(8.0))
      .rounded
      .make();
}
