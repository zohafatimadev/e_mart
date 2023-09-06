import 'package:emart_app/consts/consts.dart';

Widget ourButton({
  onPress,
  color,
  textColor,
  String? title,
}) {
  // ignore: prefer_typing_uninitialized_variables

  return ElevatedButton(
    style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
        backgroundColor: MaterialStatePropertyAll(color)),
    onPressed: () {
      onPress();
    },
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
