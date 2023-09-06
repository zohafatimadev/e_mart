import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../widgets_common/applogo_widget.dart';
import '../../../widgets_common/bg_widget.dart';
import '../../../widgets_common/custom_textfield.dart';
import '../../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return signup_state();
  }
}

// ignore: camel_case_types
class signup_state extends State<SignupScreen> {
  bool? get newVlaue => true;

  bool? get isCheck => true;

  set isCheck(bool? isCheck) {
    isCheck = newVlaue;
  }

  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "join the $appname".text.fontFamily(bold).white.size(18).make(),
              35.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: nameHint,
                        title: name,
                        controller: nameController,
                        isPass: false),
                    customTextField(
                        hint: emailHint,
                        title: email,
                        controller: emailController,
                        isPass: false),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        controller: passwordController,
                        isPass: true),
                    customTextField(
                        hint: passwordHint,
                        title: retypePassword,
                        controller: passwordRetypeController,
                        isPass: true),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make())),

                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: "& ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacypolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                            ],
                          )),
                        ),
                      ],
                    ),

                    10.heightBox,
                    controller.isloading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: isCheck == true ? redColor : lightGrey,
                            title: signup,
                            textColor: whiteColor,
                            onPress: () async {
                              if (isCheck != false) {
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    );
                                  }).then((value) => {
                                            VxToast.show(context,
                                                msg: loggedin),
                                            Get.offAll(() => const Home())
                                          });
                                  // ignore: empty_catches
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                }
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    //wrapping into gesture detector of velocity X
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            ),
                          )
                        ],
                      ),
                    ).onTap(() {
                      Get.back();
                    }),
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
