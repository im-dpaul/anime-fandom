import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class CustomOtpWidget extends StatefulWidget {
  String? countryCode;
  String? phoneController;
  TextEditingController otpController;
  bool isOtpVerified = false;

  final VoidCallback otpControllerClear;
  final void Function(String)? verifyOTP;
  final void Function(String)? changeOtpVerified;
  // final VoidCallback verifyOTP;
  // final VoidCallback changeOtpVerified;
  CustomOtpWidget({
    required this.countryCode,
    required this.phoneController,
    required this.otpController,
    required this.isOtpVerified,
    required this.otpControllerClear,
    required this.verifyOTP,
    required this.changeOtpVerified,
    super.key,
  });

  @override
  State<CustomOtpWidget> createState() => _CustomOtpWidgetState();
}

class _CustomOtpWidgetState extends State<CustomOtpWidget> {
  final FocusNode _otpFocusNode = FocusNode();

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 46 * SizeConfig.heightMultiplier!,
          ),
          const Text(
            "OTP Verification",
            style: AppTextStyles.f22W600White,
          ),
          SizedBox(
            height: 34 * SizeConfig.heightMultiplier!,
          ),
          const Text(
            'Enter the code sent to the number',
            style: AppTextStyles.f16W300Grey5,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 28 * SizeConfig.heightMultiplier!,
          ),
          Text(
            '${widget.countryCode} ${widget.phoneController}',
            style: AppTextStyles.f16W400White,
          ),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.otpControllerClear,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit',
                  style: AppTextStyles.f16W400Grey5,
                ),
                SizedBox(width: 8 * SizeConfig.widthMultiplier!),
                const Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: AppColors.grey5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40 * SizeConfig.heightMultiplier!,
          ),
          Pinput(
            controller: widget.otpController,
            focusNode: _otpFocusNode,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            mainAxisAlignment: MainAxisAlignment.start,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                border: Border.all(color: AppColors.textFieldOuterBorder),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textFieldOuterBorder.withOpacity(.3),
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 0,
                    spreadRadius: 4.0,
                  ),
                ],
              ),
            ),
            length: 6,
            submittedPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(
                color: widget.isOtpVerified ? AppColors.grey5 : AppColors.red1,
              ),
            ),
            onCompleted: widget.verifyOTP,
            onChanged: widget.changeOtpVerified,
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: AppColors.red1),
            ),
            defaultPinTheme: widget.isOtpVerified
                ? defaultPinTheme
                : defaultPinTheme.copyBorderWith(
                    border: Border.all(color: AppColors.red1),
                  ),
          ),
          SizedBox(
            height: 12 * SizeConfig.heightMultiplier!,
          ),
          Visibility(
            visible: !widget.isOtpVerified,
            child: const Text('Incorrect OTP',
                textAlign: TextAlign.center, style: AppTextStyles.f14W400Red),
          ),
          SizedBox(height: 32 * SizeConfig.heightMultiplier!),
          // GestureDetector(
          //   onTap: () {
          //     if (ref.watch(authenticationProvider
          //             .select((value) => value
          //                 .timerSeconds)) <=
          //         0) {
          //       // provider.onResend(context);
          //     }
          //   },
          //   child: RichText(
          //     text: TextSpan(
          //       text: ref.watch(authenticationProvider
          //                   .select((value) => value
          //                       .timerSeconds)) <=
          //               0
          //           ? 'Resend Code'
          //           : "Resend Code in "
          //               '00:${ref.watch(authenticationProvider.select((value) => value.timerSeconds)).toString().length == 1 ? '0${ref.watch(authenticationProvider.select((value) => value.timerSeconds))}' : '${ref.watch(authenticationProvider.select((value) => value.timerSeconds))}'}',
          //       style: ref.watch(authenticationProvider
          //                   .select((value) => value
          //                       .timerSeconds)) <=
          //               0
          //           ? AppTextStyles.f14W400Blue
          //           : AppTextStyles
          //               .f14W400Grey5,
          //       // children: [
          //       //   // TextSpan(
          //       //   //   text: provider.timerSeconds <= 0
          //       //   //       ? ''
          //       //   //       : '00:${provider.timerSeconds.toString().length == 1 ? '0${provider.timerSeconds}' : '${provider.timerSeconds}'}',
          //       //   //   style: AppTextStyles.f14W400Grey5,
          //       //   //   recognizer: TapGestureRecognizer()
          //       //   //     ..onTap = () async {
          //       //   //       if (provider.timerSeconds <= 0) {
          //       //   //         provider.onResend(context);
          //       //   //       }
          //       //   //     },
          //       //   // ),
          //       // ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 46 * SizeConfig.heightMultiplier!),
        ],
      ),
    );
  }
}
