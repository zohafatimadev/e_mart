import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/splash_screen/auth_screen/signup_screen.dart';
import 'package:emart_app/views/splash_screen/home_screen/home.dart';

import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../../consts/consts.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(AuthController());
    // ignore: prefer_typing_uninitialized_variables

    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              35.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make())),
                    10.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isloading(true);

                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    10.heightBox,
                    ourButton(
                        color: Colors.blue,
                        title: 'signup',
                        textColor: whiteColor,
                        onPress: () {
                          // ignore: avoid_print
                          print("btn clicked");
                          Get.to(() => const SignupScreen());
                        }).box.width(context.screenWidth - 50).make(),
                    15.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  ),
                                ),
                              )),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
      Scaffold: null,
    );
  }
}
