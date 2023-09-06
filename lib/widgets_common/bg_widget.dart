// ignore_for_file: non_constant_identifier_names

import 'package:emart_app/consts/consts.dart';

Widget bgWidget(
    // ignore: avoid_types_as_parameter_names
    Widget? child,
    // ignore: avoid_types_as_parameter_names
    {required Scaffold}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}
