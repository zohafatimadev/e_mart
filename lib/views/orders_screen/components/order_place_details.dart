import 'package:emart_app/consts/consts.dart';

Widget orderPlaceDetails(
    {required d1,
    required d2,
    required String title1,
    required String title2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1.text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title2.text.fontFamily(semibold).make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
