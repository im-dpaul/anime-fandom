// ignore_for_file: use_build_context_synchronously

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/features/authentication/controllers/signin_controller.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/utils/common_widgets/custom_button.dart';
import 'package:anime_fandom/utils/common_widgets/custom_password_field.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPasswordScreen extends StatefulWidget {
  const SigninPasswordScreen({super.key});

  @override
  State<SigninPasswordScreen> createState() => _SigninPasswordScreenState();
}

class _SigninPasswordScreenState extends State<SigninPasswordScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  SigninController signinController = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    return SizedBox(
                      height: signinController.forgetPassword.value
                          ? 85 * SizeConfig.heightMultiplier!
                          : 100 * SizeConfig.heightMultiplier!,
                    );
                  },
                ),
                // SvgPicture.asset(
                //   ImagePath.icSplash,
                //   width: 96 * SizeConfig.widthMultiplier!,
                //   height: 96 * SizeConfig.heightMultiplier!,
                // ),
                //SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                const Text(
                  "Wellcome back!!",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.f24W700White,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 32 * SizeConfig.heightMultiplier!),
                      Obx(
                        () {
                          return CustomTextField(
                            focusNode: _emailFocusNode,
                            onChanged: (email) {
                              signinController.validEmailCheck();
                              if (email.isNotEmpty) {
                                signinController.setEmailIconColor(true);
                              } else if (email.isEmpty) {
                                signinController.setEmailIconColor(false);
                              }
                            },
                            hintText: 'Email / Phone number',
                            //maxLength: 10,
                            textEditingController:
                                signinController.emailController.value,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: 12 * SizeConfig.widthMultiplier!),
                                Icon(
                                  Icons.person_3_outlined,
                                  color: !signinController.emailIconColor.value
                                      ? AppColors.grey2
                                      : AppColors.whiteOpacity60,
                                ),
                                SizedBox(
                                    width: 10 * SizeConfig.widthMultiplier!),
                                Container(
                                    color: AppColors.grey2,
                                    height: 16 * SizeConfig.heightMultiplier!,
                                    width: 1 * SizeConfig.widthMultiplier!),
                                SizedBox(
                                    width: 8 * SizeConfig.widthMultiplier!),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),
                      Obx(
                        () {
                          return CustomPasswordField(
                            focusNode: _passwordFocusNode,
                            obsecureText:
                                signinController.passwordVisibility.value,
                            onChanged: (password) {
                              signinController.validPasswordCheck();
                              if (password.isNotEmpty) {
                                signinController.setPasswordIconColor(true);
                              } else if (password.isEmpty) {
                                signinController.setPasswordIconColor(false);
                              }
                            },
                            hintText: 'Password',
                            //maxLength: 10,
                            textEditingController:
                                signinController.passwordController.value,
                            keyboardType: TextInputType.text,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: 12 * SizeConfig.widthMultiplier!),
                                Icon(
                                  Icons.key_outlined,
                                  color:
                                      !signinController.passwordIconColor.value
                                          ? AppColors.grey2
                                          : AppColors.whiteOpacity60,
                                ),
                                SizedBox(
                                    width: 10 * SizeConfig.widthMultiplier!),
                                Container(
                                    color: AppColors.grey2,
                                    height: 16 * SizeConfig.heightMultiplier!,
                                    width: 1 * SizeConfig.widthMultiplier!),
                                SizedBox(
                                    width: 8 * SizeConfig.widthMultiplier!),
                              ],
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signinController.setPasswordVisible();
                              },
                              child: Icon(
                                signinController.passwordVisibility.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: signinController.passwordIconColor.value
                                    ? AppColors.whiteOpacity60
                                    : AppColors.grey2,
                              ),
                            ),
                          );
                        },
                      ),
                      Obx(
                        () {
                          return Visibility(
                            visible: signinController.forgetPassword.value,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    "Forgot password?",
                                    style: AppTextStyles.f12W400Red,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      Obx(
                        () {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomButton(
                              title: "Verify",
                              color:
                                  signinController.isEmailPasswordComplete.value
                                      ? AppColors.white
                                      : AppColors.grey2,
                              onTap: () async {
                                if (signinController
                                    .isEmailPasswordComplete.value) {
                                  FocusScope.of(context).unfocus();

                                  bool val =
                                      await signinController.userExist(false);
                                  if (val) {
                                    bool? userActive =
                                        HiveServices.getIsUserActive();
                                    bool? userExist =
                                        HiveServices.getIsUserExist();

                                    if (userExist! && userActive!) {
                                      int val = await signinController
                                          .signInWithPassword();
                                      if (val == 200) {
                                        signinController.setForgetPassword(
                                            val: false);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.homeScreen,
                                            (route) => false);
                                      } else if (val == 401) {
                                        signinController.setForgetPassword(
                                            val: true);
                                        CustomSnackbar.showSnackbar(
                                          context: context,
                                          backgroundColor: AppColors.red1,
                                          message: 'Wrong password.',
                                        );
                                      } else {
                                        CustomSnackbar.showSnackbar(
                                          context: context,
                                          backgroundColor: AppColors.red1,
                                          message: 'Something went wrong.',
                                        );
                                      }
                                    } else if (userExist && !userActive!) {
                                      CustomSnackbar.showSnackbar(
                                        context: context,
                                        backgroundColor: AppColors.red1,
                                        message:
                                            'Your account is deactivated. Please contact at anime.fandom@gmail.com to reactivate your account.',
                                      );
                                    } else {
                                      CustomSnackbar.showSnackbar(
                                        context: context,
                                        backgroundColor: AppColors.red1,
                                        message:
                                            'User does not exist. Please sign up to continue.',
                                      );
                                    }
                                  } else {
                                    CustomSnackbar.showSnackbar(
                                      context: context,
                                      backgroundColor: AppColors.red1,
                                      message: 'Something went wrong',
                                    );
                                  }
                                } else if (!signinController
                                    .isValidEmail.value) {
                                  CustomSnackbar.showSnackbar(
                                      context: context,
                                      message:
                                          'Please enter a valid email or phone number.');
                                }
                                // else if (!widgetRef.read(
                                //     signinProvider.select((value) =>
                                //         value.isValidPassword))) {
                                //   CustomSnackbar.showSnackbar(
                                //       context: context,
                                //       message:
                                //           'Please enter valid password.');
                                // }
                                else {
                                  CustomSnackbar.showSnackbar(
                                      context: context,
                                      message:
                                          'Please enter valid credentials.');
                                }
                              },
                              textStyle:
                                  signinController.isEmailPasswordComplete.value
                                      ? AppTextStyles.f16W600Black
                                      : AppTextStyles.f16W600Grey3,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 104 * SizeConfig.heightMultiplier!),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.white.withOpacity(0.1),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'OR',
                            style: AppTextStyles.f14W400White,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.white.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 4 * SizeConfig.heightMultiplier!,
                        ),
                        height: 48 * SizeConfig.heightMultiplier!,
                        icon: Row(
                          children: [
                            Image.asset(
                              ImagePath.icOtp,
                              height: 28 * SizeConfig.heightMultiplier!,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ), //const Icon(Icons.phone_iphone_sharp),
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SF-Pro",
                            color: AppColors.black2,
                            letterSpacing: .0025),
                        color: AppColors.white,
                        title: 'Sign in with OTP',
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.signinOtpScreen,
                          );
                          //Navigator.of(context).
                        },
                      ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: AppTextStyles.f12W400White,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.userDetailsScreen,
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: AppTextStyles.f15W500Blue,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24 * SizeConfig.heightMultiplier!),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'By signing in or continuing, you agree to our ',
                          style: AppTextStyles.f12W300Grey5.copyWith(
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms \n& Conditions ',
                              style: AppTextStyles.f12W400White,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(
                              text: 'and',
                              style: AppTextStyles.f12W300Grey5,
                            ),
                            TextSpan(
                              text: ' Privacy Policies',
                              style: AppTextStyles.f12W400White,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
