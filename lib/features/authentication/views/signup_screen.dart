import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/constant_data.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_sheet.dart';
import 'package:anime_fandom/utils/common_widgets/custom_button.dart';
import 'package:anime_fandom/utils/common_widgets/custom_otp_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_password_field.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    textStyle: AppTextStyles.f24W600White,
    width: 64,
    height: 56,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grey2),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> dialCodes = ConstantData.countryList
        .where((element) => element['dial_code'] != null)
        .toList();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 120 * SizeConfig.heightMultiplier!),
                // SvgPicture.asset(
                //   ImagePath.icSplash,
                //   width: 96 * SizeConfig.widthMultiplier!,
                //   height: 96 * SizeConfig.heightMultiplier!,
                // ),
                // SizedBox(height: 30 * SizeConfig.heightMultiplier!),
                // const Text(
                //   "Let's get started",
                //   textAlign: TextAlign.center,
                //   style: AppTextStyles.f24W700White,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 32 * SizeConfig.heightMultiplier!),

                      // ----- Phone number field for sign up -----

                      CustomTextField(
                        focusNode: _phoneFocusNode,
                        onChanged: (value) {
                          ref.read(signupProvider.notifier).isPhoneValid();
                        },
                        hintText: 'Phone Number',
                        maxLength: 10,
                        textEditingController: ref.watch(
                          signupProvider
                              .select((value) => value.phoneController),
                        ),
                        keyboardType: TextInputType.number,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton2<String>(
                              offset:
                                  Offset(0, -24 * SizeConfig.heightMultiplier!),
                              icon: Image.asset(ImagePath.icDropdownArrow),
                              underline: const SizedBox(),
                              customButton: Row(
                                children: [
                                  SizedBox(
                                      width: 10 * SizeConfig.widthMultiplier!),
                                  Text(
                                      ref.watch(signupProvider.select(
                                          (value) => value.countryCode)),
                                      // authProvider.countryCode,
                                      style: AppTextStyles.f16W400White
                                          .copyWith(fontFamily: 'SF-Pro')),
                                  SizedBox(
                                      width: 6 * SizeConfig.widthMultiplier!),
                                  Image.asset(ImagePath.icDropdownArrow),
                                ],
                              ),
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    8 * SizeConfig.heightMultiplier!,
                                  ),
                                  color: AppColors.countryCodeSelectorColor),
                              dropdownWidth:
                                  MediaQuery.of(context).size.width - 50,
                              dropdownMaxHeight: 250,
                              style: AppTextStyles.f16W400White,
                              value: ref.watch(signupProvider
                                  .select((value) => value.countryCode)),
                              items: dialCodes
                                  .map((country) => DropdownMenuItem<String>(
                                        value: country['dial_code']!,
                                        child: Row(
                                          children: [
                                            Text(
                                              country['emoji']!,
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                            SizedBox(
                                                width: 14 *
                                                    SizeConfig
                                                        .widthMultiplier!),
                                            Expanded(
                                              child: Text(
                                                country['name']!,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              country['dial_code']!,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                ref
                                    .read(signupProvider.notifier)
                                    .selectCountryCode(value!);
                                //authProvider.selectCountryCode(value!);
                              },
                            ),
                            SizedBox(width: 10 * SizeConfig.widthMultiplier!),
                            Container(
                                color: AppColors.grey2,
                                height: 16 * SizeConfig.heightMultiplier!,
                                width: 1 * SizeConfig.widthMultiplier!),
                            SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                          ],
                        ),
                      ),

                      // ----- Email address field for sign up -----

                      // SizedBox(height: 8 * SizeConfig.heightMultiplier!),
                      // CustomTextField(
                      //   focusNode: _emailFocusNode,
                      //   onChanged: (email) {
                      //     // authProvider.enableVerifyButton();
                      //     if (email.isNotEmpty) {
                      //       ref
                      //           .read(signupProvider.notifier)
                      //           .setEmailIconColor(true);
                      //       // authProvider.setEmailIconColor(true);
                      //     } else if (email.isEmpty) {
                      //       ref
                      //           .read(signupProvider.notifier)
                      //           .setEmailIconColor(false);
                      //       // authProvider.setEmailIconColor(false);
                      //     }
                      //   },
                      //   hintText: 'Email address',
                      //   //maxLength: 10,
                      //   textEditingController: ref.watch(
                      //     signupProvider
                      //         .select((value) => value.emailController),
                      //   ),
                      //   // authProvider.emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   prefixIcon: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       SizedBox(width: 12 * SizeConfig.widthMultiplier!),
                      //       Icon(
                      //         Icons.email_outlined,
                      //         color: !ref.watch(signupProvider
                      //                 .select((value) => value.emailIconColor))
                      //             ? AppColors.grey2
                      //             : AppColors.whiteOpacity60,
                      //       ),
                      //       SizedBox(width: 10 * SizeConfig.widthMultiplier!),
                      //       Container(
                      //           color: AppColors.grey2,
                      //           height: 16 * SizeConfig.heightMultiplier!,
                      //           width: 1 * SizeConfig.widthMultiplier!),
                      //       SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),

                      // ----- Password field for sign up -----

                      CustomPasswordField(
                        focusNode: _passwordFocusNode,
                        obsecureText: ref.watch(signupProvider
                            .select((value) => value.passwordVisibility)),
                        onChanged: (password) {
                          ref.read(signupProvider.notifier).isPasswordValid();
                          if (password.isNotEmpty) {
                            ref
                                .read(signupProvider.notifier)
                                .setPasswordIconColor(true);
                          } else if (password.isEmpty) {
                            ref
                                .read(signupProvider.notifier)
                                .setPasswordIconColor(false);
                          }
                        },
                        hintText: 'Password',
                        //maxLength: 10,
                        textEditingController: ref.watch(
                          signupProvider
                              .select((value) => value.passwordController),
                        ),
                        keyboardType: TextInputType.text,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12 * SizeConfig.widthMultiplier!),
                            Icon(
                              Icons.password_outlined,
                              color: !ref.watch(signupProvider.select(
                                      (value) => value.passwordIconColor))
                                  // authProvider.passwordController.text.isEmpty
                                  ? AppColors.grey2
                                  : AppColors.whiteOpacity60,
                            ),
                            SizedBox(width: 10 * SizeConfig.widthMultiplier!),
                            Container(
                                color: AppColors.grey2,
                                height: 16 * SizeConfig.heightMultiplier!,
                                width: 1 * SizeConfig.widthMultiplier!),
                            SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                          ],
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            ref
                                .read(signupProvider.notifier)
                                .setPasswordVisible();
                            // authProvider.setPasswordVisible();
                          },
                          child: Icon(
                            ref.watch(signupProvider.select(
                                    (value) => value.passwordVisibility))
                                // authProvider.passwordVisibility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: ref.watch(signupProvider
                                    .select((value) => value.passwordIconColor))
                                // authProvider.passwordIconColor
                                ? AppColors.whiteOpacity60
                                : AppColors.grey2,
                          ),
                        ),
                      ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),

                      // ----- Confirm password field for sign up -----

                      CustomPasswordField(
                        focusNode: _confirmPasswordFocusNode,
                        obsecureText: ref.watch(signupProvider.select(
                            (value) => value.confirmPasswordVisibility)),
                        onChanged: (password) {
                          ref.read(signupProvider.notifier).isPasswordValid();
                          if (password.isNotEmpty) {
                            ref
                                .read(signupProvider.notifier)
                                .setConfirmPasswordIconColor(true);
                          } else if (password.isEmpty) {
                            ref
                                .read(signupProvider.notifier)
                                .setConfirmPasswordIconColor(false);
                          }
                        },
                        hintText: 'Confirm password',
                        textEditingController: ref.watch(
                          signupProvider.select(
                              (value) => value.confirmPasswordController),
                        ),
                        keyboardType: TextInputType.text,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12 * SizeConfig.widthMultiplier!),
                            Icon(
                              Icons.key_outlined,
                              color: !ref.watch(signupProvider.select((value) =>
                                      value.confirmPasswordIconColor))
                                  // authProvider.passwordController.text.isEmpty
                                  ? AppColors.grey2
                                  : AppColors.whiteOpacity60,
                            ),
                            SizedBox(width: 10 * SizeConfig.widthMultiplier!),
                            Container(
                                color: AppColors.grey2,
                                height: 16 * SizeConfig.heightMultiplier!,
                                width: 1 * SizeConfig.widthMultiplier!),
                            SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                          ],
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            ref
                                .read(signupProvider.notifier)
                                .setConfirmPasswordVisible();
                            // authProvider.setPasswordVisible();
                          },
                          child: Icon(
                            ref.watch(signupProvider.select(
                                    (value) => value.confirmPasswordVisibility))
                                // authProvider.passwordVisibility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: ref.watch(signupProvider.select(
                                    (value) => value.confirmPasswordIconColor))
                                // authProvider.passwordIconColor
                                ? AppColors.whiteOpacity60
                                : AppColors.grey2,
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomButton(
                          title: "Register",
                          color: ref.watch(signupProvider.select(
                                  (value) => value.isPhonePassowrdComplete))
                              ? AppColors.white
                              : AppColors.grey2,
                          textStyle: ref.watch(signupProvider.select(
                                  (value) => value.isPhonePassowrdComplete))
                              ? AppTextStyles.f16W600Black
                              : AppTextStyles.f16W600Grey3,
                          onTap: () async {
                            if (ref.watch(signupProvider.select(
                                (value) => value.isPhonePassowrdComplete))) {
                              FocusScope.of(context).unfocus();
                              ref.read(signupProvider).otpController.clear();

                              final val = await ref
                                  .read(signupProvider.notifier)
                                  .userExist();

                              if (val) {
                                bool? userActive =
                                    HiveServices.getIsUserActive();
                                bool? userExist = HiveServices.getIsUserExist();

                                if (!userExist!) {
                                  // ignore: use_build_context_synchronously
                                  await ref
                                      .read(signupProvider.notifier)
                                      .sendOTP(context);

                                  // if (ref.read(authenticationProvider
                                  //         .select((value) => value.timer)) !=
                                  //     null) {
                                  //   ref.read(authenticationProvider
                                  //       .select((value) => value.timer!.cancel()));
                                  //   //provider.timer!.cancel();
                                  // }
                                  // ref
                                  //     .read(authenticationProvider.notifier)
                                  //     .startTimer();
                                  // // provider.startTimer();
                                  // ref
                                  //     .read(authenticationProvider.notifier)
                                  //     .setTimerInSeconds();
                                  // // provider.timerSeconds = 30;

                                  // ignore: use_build_context_synchronously
                                  showModalBottomSheet(
                                    backgroundColor: AppColors.bgColor,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    context: context,
                                    builder: (context) => CustomBottomSheet(
                                      child: Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: CustomOtpWidget(
                                          countryCode: ref.read(
                                              signupProvider.select((value) =>
                                                  value.countryCode)),
                                          phoneController: ref.read(
                                              signupProvider.select((value) =>
                                                  value.phoneController.text)),
                                          otpController: ref.watch(
                                              signupProvider.select((value) =>
                                                  value.otpController)),
                                          isOtpVerified: ref.watch(
                                              signupProvider.select((value) =>
                                                  value.isOtpVerified)),
                                          otpControllerClear: () {
                                            Navigator.pop(context);
                                            ref
                                                .read(signupProvider)
                                                .otpController
                                                .clear();
                                            _phoneFocusNode.requestFocus();
                                          },
                                          verifyOTP: (value) async {
                                            await ref
                                                .read(signupProvider.notifier)
                                                .verifyOTP(context: context);
                                          },
                                          changeOtpVerified: (value) {
                                            ref
                                                .read(signupProvider.notifier)
                                                .changeOtpVerified();
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (userExist && !userActive!) {
                                  // ignore: use_build_context_synchronously
                                  CustomSnackbar.showSnackbar(
                                    context: context,
                                    backgroundColor: AppColors.red1,
                                    message:
                                        'Your account is deactivated. Please contact at anime.fandom@gmail.com to reactivate your account.',
                                  );
                                } else if (userExist && userActive!) {
                                  // ignore: use_build_context_synchronously
                                  CustomSnackbar.showSnackbar(
                                    context: context,
                                    backgroundColor: AppColors.red1,
                                    message:
                                        'Account already exists with this phone number.',
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  CustomSnackbar.showSnackbar(
                                    context: context,
                                    backgroundColor: AppColors.red1,
                                    message: 'Something went wrong.',
                                  );
                                }
                              }
                            } else if (!ref.read(signupProvider
                                .select((value) => value.isPhoneValid))) {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message:
                                      'Enter valid Phone number to register');
                            } else if (!(ref
                                    .read(signupProvider.select(
                                        (value) => value.passwordController))
                                    .text
                                    .length >=
                                8)) {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message:
                                      'Password length should be atleast 8');
                            } else if (ref
                                    .read(signupProvider.select(
                                        (value) => value.passwordController))
                                    .text
                                    .length !=
                                ref
                                    .read(signupProvider.select((value) =>
                                        value.confirmPasswordController))
                                    .text
                                    .length) {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message:
                                      'Password & confirm password are different');
                            } else {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message: 'Enter valid details to register');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 132 * SizeConfig.heightMultiplier!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: AppTextStyles.f12W400White,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.signinPasswordScreen,
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Sign in",
                              style: AppTextStyles.f15W500Blue,
                            ),
                          ),
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
