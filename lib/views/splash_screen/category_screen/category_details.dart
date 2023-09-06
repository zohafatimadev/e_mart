import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/splash_screen/category_screen/item_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import '../../../controllers/product_controller.dart';

import '../../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  State<CategoryDetails> createStater() => _CategoryDetailsState();

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        Scaffold(
          appBar: AppBar(
            title: widget.title!.text.fontFamily(bold).white.make(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(whiteColor)
                          .makeCentered()
                          .box
                          .white
                          .rounded
                          .size(120, 60)
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .make()),
                ),
              ),
              20.heightBox,
              StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: "No products found!"
                            .text
                            .color(darkFontGrey)
                            .make(),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 550,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(data[index]['p_imgs'][0],
                                          height: 460,
                                          width: 200,
                                          fit: BoxFit.cover)
                                      .box
                                      .roundedSM
                                      .clip(Clip.antiAlias)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              )
                                  .box
                                  .color(lightGolden)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .rounded
                                  .outerShadow
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                controller.checkIfFav(data[index]);

                                Get.to(() => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index]));
                              });
                            }),
                      );
                    }
                  }),
            ],
          ),
        ),
        Scaffold: null);
  }
}
