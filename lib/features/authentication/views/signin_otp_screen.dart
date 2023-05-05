import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/constants/constant_data.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/features/authentication/controllers/signin_provider.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_sheet.dart';
import 'package:anime_fandom/utils/common_widgets/custom_button.dart';
import 'package:anime_fandom/utils/common_widgets/custom_otp_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;

class SigninOtpScreen extends StatefulWidget {
  const SigninOtpScreen({super.key});

  @override
  State<SigninOtpScreen> createState() => _SigninOtpScreenState();
}

class _SigninOtpScreenState extends State<SigninOtpScreen> {
  final FocusNode _phoneFocusNode = FocusNode();

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
                SizedBox(height: 100 * SizeConfig.heightMultiplier!),
                // SvgPicture.asset(
                //   ImagePath.icSplash,
                //   width: 96 * SizeConfig.widthMultiplier!,
                //   height: 96 * SizeConfig.heightMultiplier!,
                // ),
                SizedBox(height: 30 * SizeConfig.heightMultiplier!),
                const Text(
                  "Wellcome back!!",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.f24W700White,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer(
                    builder: (context, widgetRef, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 32 * SizeConfig.heightMultiplier!),
                          CustomTextField(
                            focusNode: _phoneFocusNode,
                            onChanged: (value) {
                              widgetRef
                                  .read(signinProvider.notifier)
                                  .isPhoneValid();
                            },
                            hintText: 'Phone Number',
                            maxLength: 10,
                            textEditingController: widgetRef.watch(
                              signinProvider
                                  .select((value) => value.phoneController),
                            ),
                            keyboardType: TextInputType.number,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButton2<String>(
                                  offset: Offset(
                                      0, -24 * SizeConfig.heightMultiplier!),
                                  icon: Image.asset(ImagePath.icDropdownArrow),
                                  underline: const SizedBox(),
                                  customButton: Row(
                                    children: [
                                      SizedBox(
                                          width:
                                              10 * SizeConfig.widthMultiplier!),
                                      Text(
                                          widgetRef.watch(signinProvider.select(
                                              (value) => value.countryCode)),
                                          style: AppTextStyles.f16W400White
                                              .copyWith(fontFamily: 'SF-Pro')),
                                      SizedBox(
                                          width:
                                              6 * SizeConfig.widthMultiplier!),
                                      Image.asset(ImagePath.icDropdownArrow),
                                    ],
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        8 * SizeConfig.heightMultiplier!,
                                      ),
                                      color:
                                          AppColors.countryCodeSelectorColor),
                                  dropdownWidth:
                                      MediaQuery.of(context).size.width - 50,
                                  dropdownMaxHeight: 250,
                                  style: AppTextStyles.f16W400White,
                                  value: widgetRef.watch(signinProvider
                                      .select((value) => value.countryCode)),
                                  items: dialCodes
                                      .map(
                                          (country) => DropdownMenuItem<String>(
                                                value: country['dial_code']!,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      country['emoji']!,
                                                      style: const TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                        width: 14 *
                                                            SizeConfig
                                                                .widthMultiplier!),
                                                    Expanded(
                                                      child: Text(
                                                        country['name']!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                    widgetRef
                                        .read(signinProvider.notifier)
                                        .selectCountryCode(value!);
                                  },
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
                          ),
                          SizedBox(height: 20 * SizeConfig.heightMultiplier!),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CustomButton(
                              title: "Continue",
                              color: widgetRef.watch(signinProvider
                                      .select((value) => value.isPhoneComplete))
                                  ? AppColors.white
                                  : AppColors.grey2,
                              onTap: () async {
                                if (widgetRef.watch(signinProvider.select(
                                    (value) => value.isPhoneComplete))) {
                                  FocusScope.of(context).unfocus();

                                  bool value = await widgetRef
                                      .read(signinProvider.notifier)
                                      .userExist(true);

                                  if (value) {
                                    bool? userActive =
                                        HiveServices.getIsUserActive();
                                    bool? userExist =
                                        HiveServices.getIsUserExist();

                                    if (userActive! && userExist!) {
                                      widgetRef
                                          .read(signinProvider)
                                          .otpController
                                          .clear();
                                      // ignore: use_build_context_synchronously
                                      widgetRef
                                          .read(signinProvider.notifier)
                                          .sendOTP(context);

                                      // if (widgetRef.read(authenticationProvider
                                      //         .select((value) => value.timer)) !=
                                      //     null) {
                                      //   widgetRef.read(authenticationProvider
                                      //       .select((value) => value.timer!.cancel()));
                                      //   //provider.timer!.cancel();
                                      // }
                                      // widgetRef
                                      //     .read(authenticationProvider.notifier)
                                      //     .startTimer();
                                      // // provider.startTimer();
                                      // widgetRef
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
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: p.Consumer<LoginProvider>(
                                              builder: (context, loginProvider,
                                                      child) =>
                                                  CustomOtpWidget(
                                                countryCode: widgetRef.read(
                                                    signinProvider.select(
                                                        (value) =>
                                                            value.countryCode)),
                                                phoneController: widgetRef.read(
                                                    signinProvider.select(
                                                        (value) => value
                                                            .phoneController
                                                            .text)),
                                                otpController: widgetRef.watch(
                                                    signinProvider.select(
                                                        (value) => value
                                                            .otpController)),
                                                // isOtpVerified:
                                                //     loginProvider.isOtpValid,
                                                isOtpVerified: widgetRef.watch(
                                                    signinProvider.select(
                                                        (value) => value
                                                            .isOtpVerified)),
                                                otpControllerClear: () {
                                                  Navigator.pop(context);
                                                  widgetRef
                                                      .read(signinProvider)
                                                      .otpController
                                                      .clear();
                                                  _phoneFocusNode
                                                      .requestFocus();
                                                },
                                                verifyOTP: (value) async {
                                                  await widgetRef
                                                      .read(signinProvider
                                                          .notifier)
                                                      .verifyOTP(
                                                          context: context);
                                                },
                                                changeOtpVerified: (value) {
                                                  widgetRef
                                                      .read(signinProvider
                                                          .notifier)
                                                      .changeOtpVerified();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (userExist! && !userActive) {
                                      // ignore: use_build_context_synchronously
                                      CustomSnackbar.showSnackbar(
                                        context: context,
                                        backgroundColor: AppColors.red1,
                                        message:
                                            'Your account is deactivated. Please contact at anime.fandom@gmail.com to reactivate your account.',
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      CustomSnackbar.showSnackbar(
                                        context: context,
                                        backgroundColor: AppColors.red1,
                                        message:
                                            'User does not exist. Please sign up to continue.',
                                      );
                                    }
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    CustomSnackbar.showSnackbar(
                                      context: context,
                                      backgroundColor: AppColors.red1,
                                      message: 'Something went wrong',
                                    );
                                  }
                                } else if (widgetRef
                                    .watch(signinProvider.select(
                                        (value) => value.phoneController))
                                    .text
                                    .isEmpty) {
                                  CustomSnackbar.showSnackbar(
                                      context: context,
                                      message: 'Please enter Phone number');
                                } else {
                                  CustomSnackbar.showSnackbar(
                                      context: context,
                                      message: 'Enter a valid Phone number');
                                }
                              },
                              textStyle: widgetRef.watch(signinProvider
                                      .select((value) => value.isPhoneComplete))
                                  ? AppTextStyles.f16W600Black
                                  : AppTextStyles.f16W600Grey3,
                            ),
                          ),
                          SizedBox(height: 150 * SizeConfig.heightMultiplier!),
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
                                  ImagePath.icPassword,
                                  height: 28 * SizeConfig.heightMultiplier!,
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                            //const Icon(Icons.phone_iphone_sharp),
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "SF-Pro",
                                color: AppColors.black2,
                                letterSpacing: .0025),
                            color: AppColors.white,
                            title: 'Sign in with Password',
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.signinPasswordScreen,
                              );
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
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(
                                  text: 'and',
                                  style: AppTextStyles.f12W300Grey5,
                                ),
                                TextSpan(
                                  text: ' Privacy Policies',
                                  style: AppTextStyles.f12W400White,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
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
