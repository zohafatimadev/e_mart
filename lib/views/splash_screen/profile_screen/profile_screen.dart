import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/splash_screen/auth_screen/login_screen.dart';
import 'package:emart_app/views/splash_screen/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/splash_screen/profile_screen/components/details_card.dart';
import 'package:emart_app/views/splash_screen/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());

    return bgWidget(
      Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      //Edit profile Button

                      const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: whiteColor,
                          )).onTap(() {
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfileScreen(data: data));
                      }),

                      //user detail section
                      Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.network(imgProfile2,
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.network(data['imageUrl'],
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.heightBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              10.heightBox,
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: whiteColor),
                              ),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: logout.text
                                  .fontFamily(semibold)
                                  .white
                                  .make()),
                        ],
                      ),

                      20.heightBox,
                      FutureBuilder(
                          future: FirestoreServices.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: loadingIndicator());
                            } else {
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(
                                      count: countData[0].toString(),
                                      title: "in your cart",
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countData[1].toString(),
                                      title: "in your wishlist",
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countData[2].toString(),
                                      title: "your orders",
                                      width: context.screenWidth / 3.4),
                                ],
                              );
                            }
                          }),

                      //buttons section

                      40.heightBox,
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: profileButtonsList.length,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const OrdersScreen());
                                  break;
                                case 1:
                                  Get.to(() => const WishlistScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessagesScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: profileButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(Colors.black)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      Scaffold: null,
    );
  }
}
