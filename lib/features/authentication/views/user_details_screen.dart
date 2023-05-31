import 'dart:developer';

import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:anime_fandom/main.dart';
import 'package:anime_fandom/utils/common_widgets/custom_bottom_sheet.dart';
import 'package:anime_fandom/utils/common_widgets/custom_button.dart';
import 'package:anime_fandom/utils/common_widgets/custom_dialog_widget.dart';
import 'package:anime_fandom/utils/common_widgets/custom_snackbar.dart';
import 'package:anime_fandom/utils/common_widgets/custom_text_field.dart';
import 'package:anime_fandom/utils/common_widgets/custom_gender_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

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
                SizedBox(height: 100 * SizeConfig.heightMultiplier!),
                // SvgPicture.asset(
                //   ImagePath.icSplash,
                //   width: 96 * SizeConfig.widthMultiplier!,
                //   height: 96 * SizeConfig.heightMultiplier!,
                // ),
                // SizedBox(height: 30 * SizeConfig.heightMultiplier!),
                const Text(
                  "Let's get started",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.f24W700White,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 32 * SizeConfig.heightMultiplier!),

                      // ----- First name field for sign up -----

                      CustomTextField(
                        focusNode: _firstNameFocusNode,
                        onChanged: (firstName) {
                          ref.read(signupProvider.notifier).isNameValid();
                        },
                        hintText: 'First name',
                        maxLength: 10,
                        textEditingController: ref.watch(
                          signupProvider
                              .select((value) => value.firstNameController),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),

                      // ----- Last name field for sign up -----

                      CustomTextField(
                        focusNode: _lastNameFocusNode,
                        onChanged: (lastName) {
                          ref.read(signupProvider.notifier).isNameValid();
                        },
                        hintText: 'Last name',
                        maxLength: 10,
                        textEditingController: ref.watch(
                          signupProvider
                              .select((value) => value.lastNameController),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 8 * SizeConfig.heightMultiplier!),

                      // ----- Gender & DOB field for sign up -----

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ----- Gender field for sign up -----

                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showModalBottomSheet(
                                backgroundColor: AppColors.bgColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                context: context,
                                builder: (context) => CustomBottomSheet(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 32 *
                                        //       SizeConfig
                                        //           .heightMultiplier!,
                                        // ),
                                        // const Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: 4),
                                        //   child: Text(
                                        //     "What’s your gender?",
                                        //     style: AppTextStyles
                                        //         .f16W400White,
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height:
                                              24 * SizeConfig.heightMultiplier!,
                                        ),
                                        SizedBox(
                                          height: 180,
                                          child: Center(
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  int tempG = ref.watch(
                                                    signupProvider.select(
                                                        (value) =>
                                                            value.tempGender!),
                                                  );
                                                  log("in $tempG, $index");
                                                  return CustomGenderWidget(
                                                    icon: tempG == index
                                                        ? ref.watch(signupProvider
                                                            .select((value) =>
                                                                value.selectedGenderIcons[
                                                                    index]))
                                                        : ref.watch(
                                                            signupProvider.select(
                                                                (value) => value
                                                                    .genders[
                                                                        index]
                                                                    .icon)),
                                                    title: ref.watch(
                                                        signupProvider.select(
                                                            (value) => value
                                                                .genders[index]
                                                                .gender)),
                                                    onTap: () {
                                                      ref
                                                          .read(signupProvider
                                                              .notifier)
                                                          .selectTempGender(
                                                              index);
                                                    },
                                                    color: tempG == index
                                                        ? AppColors.lime
                                                        : AppColors.grey2,
                                                    textStyle: ref.watch(
                                                                signupProvider
                                                                    .select(
                                                                        (value) {
                                                              log("in $index ${value.tempGender}");
                                                              return value
                                                                  .tempGender;
                                                            })) ==
                                                            index
                                                        ? AppTextStyles
                                                            .f16W400White
                                                        : AppTextStyles
                                                            .f16W400Grey4,
                                                  );
                                                },
                                                separatorBuilder: (context,
                                                        index) =>
                                                    SizedBox(
                                                        width: 16 *
                                                            SizeConfig
                                                                .widthMultiplier!),
                                                itemCount: ref
                                                    .read(signupProvider.select(
                                                        (value) =>
                                                            value.genders))
                                                    .length),
                                          ),
                                        ),
                                        //
                                        CustomButton(
                                            title: "Save",
                                            color: AppColors.white,
                                            onTap: () {
                                              Navigator.pop(context);
                                              ref
                                                  .read(signupProvider.notifier)
                                                  .selectGender();
                                            },
                                            textStyle:
                                                AppTextStyles.f16W600Grey1),
                                        SizedBox(
                                          height:
                                              24 * SizeConfig.heightMultiplier!,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.bgColor,
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.grey2,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 54,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        ref.watch(signupProvider
                                            .select((value) => value.gender)),
                                        style: ref.watch(signupProvider.select(
                                                    (value) => value.gender)) ==
                                                "Gender"
                                            ? AppTextStyles.f16W400Grey3
                                            : AppTextStyles.f16W400White,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: ref.watch(signupProvider
                                          .select((value) => value.gender)) !=
                                      "Gender",
                                  child: Positioned(
                                    top: -2 * SizeConfig.heightMultiplier!,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              12 * SizeConfig.widthMultiplier!),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      color: AppColors.bgColor,
                                      child: const Text(
                                        'Gender',
                                        style: AppTextStyles.f14W400Grey3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ----- DOB field for sign up -----

                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              customDialogWidget(
                                context,
                                Container(
                                  width: 300 * SizeConfig.widthMultiplier!,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.calenderGradient,
                                    border: Border.all(
                                      color: AppColors.grey2,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      top: 25,
                                      bottom: 15,
                                    ),
                                    child: SfDateRangePicker(
                                      headerHeight: 70,
                                      headerStyle:
                                          const DateRangePickerHeaderStyle(
                                        textStyle: AppTextStyles.f20W600White,
                                      ),
                                      monthViewSettings:
                                          const DateRangePickerMonthViewSettings(
                                        viewHeaderStyle:
                                            DateRangePickerViewHeaderStyle(
                                          textStyle: AppTextStyles.f16W500White,
                                        ),
                                      ),
                                      monthCellStyle:
                                          const DateRangePickerMonthCellStyle(
                                              textStyle:
                                                  AppTextStyles.f14W400White),
                                      yearCellStyle:
                                          const DateRangePickerYearCellStyle(
                                        textStyle: AppTextStyles.f14W500White,
                                        leadingDatesTextStyle:
                                            AppTextStyles.f14W500White,
                                      ),
                                      initialSelectedDate: DateTime.now()
                                          .subtract(const Duration(days: 365)),
                                      selectionShape:
                                          DateRangePickerSelectionShape
                                              .rectangle,
                                      toggleDaySelection: true,
                                      showActionButtons: true,
                                      maxDate: DateTime.now()
                                          .subtract(const Duration(days: 365)),
                                      minDate: DateTime(1985),
                                      onSubmit: (value) {
                                        String? date = "Date of Birth";
                                        List<String> dateList = [];
                                        if (value != null) {
                                          date = value.toString().split(' ')[0];
                                          dateList = date.split("-");
                                          date =
                                              "${dateList[2]}-${dateList[1]}-${dateList[0]}";
                                        }
                                        ref
                                            .read(signupProvider.notifier)
                                            .setDateOfBirth(date);
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.bgColor,
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.grey2,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 54,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        ref.watch(signupProvider.select(
                                            (value) => value.dateOfBirth)),
                                        style: ref.watch(signupProvider.select(
                                                    (value) =>
                                                        value.dateOfBirth)) ==
                                                "Date of Birth"
                                            ? AppTextStyles.f16W400Grey3
                                            : AppTextStyles.f16W400White,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: ref.watch(signupProvider.select(
                                          (value) => value.dateOfBirth)) !=
                                      "Date of Birth",
                                  child: Positioned(
                                    top: -2 * SizeConfig.heightMultiplier!,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              12 * SizeConfig.widthMultiplier!),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      color: AppColors.bgColor,
                                      child: const Text(
                                        'Date of Birth',
                                        style: AppTextStyles.f14W400Grey3,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * SizeConfig.heightMultiplier!),

                      // ----- Continue button for sign up -----

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomButton(
                          title: "Continue",
                          color: ref.watch(signupProvider
                                  .select((value) => value.isNameValid))
                              ? AppColors.white
                              : AppColors.grey2,
                          textStyle: ref.watch(signupProvider
                                  .select((value) => value.isNameValid))
                              ? AppTextStyles.f16W600Black
                              : AppTextStyles.f16W600Grey3,
                          onTap: () {
                            if (ref.watch(signupProvider
                                .select((value) => value.isNameValid))) {
                              FocusScope.of(context).unfocus();
                              Navigator.pushNamed(
                                context,
                                AppRoutes.signupScreen,
                              );
                            } else if (ref
                                        .read(signupProvider.select((value) =>
                                            value.firstNameController))
                                        .text
                                        .length <
                                    3 ||
                                ref
                                        .read(signupProvider.select((value) =>
                                            value.lastNameController))
                                        .text
                                        .length <
                                    3) {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message:
                                      'First name & Last name both should contain atleast 3 characters');
                            } else if (ref.read(signupProvider.select(
                                    (value) => value.isfirstNameValid)) ||
                                ref.read(
                                    signupProvider.select((value) => value.islastNameValid))) {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message: 'Name should contain only alphabet');
                            } else {
                              CustomSnackbar.showSnackbar(
                                  context: context,
                                  message:
                                      'Enter valid First name & Last name');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 130 * SizeConfig.heightMultiplier!),
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
