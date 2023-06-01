import 'dart:async';
import 'dart:developer';

import 'package:anime_fandom/constants/hive_keys.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/features/authentication/repository/auth_repository.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class SigninController extends GetxController {
  RxBool passwordVisibility = false.obs;
  RxBool passwordIconColor = false.obs;
  RxBool emailIconColor = false.obs;
  RxBool isPhoneValid = false.obs;
  RxBool isPhoneComplete = false.obs;
  RxBool isEmailPasswordComplete = false.obs;
  RxBool isValidEmail = false.obs;
  RxBool isValidPassword = false.obs;
  RxBool forgetPassword = false.obs;
  RxBool keyboardOn = false.obs;
  RxString countryCode = '+91'.obs;

  FirebaseAuth firbaseAuth = FirebaseAuth.instance;
  AuthCredential? authCredential;
  RxBool isOtpVerified = true.obs;
  RxString verificationId = ''.obs;
  RxInt? resendToken;

  RxInt timerSeconds = 30.obs;
  Timer? timer;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final otpController = TextEditingController().obs;

  final AuthRepository authRepository = AuthRepository();

  setKeyboardOn(bool val) {
    keyboardOn.value = val;
  }

  setForgetPassword({required bool val}) {
    forgetPassword.value = val;
  }

  setIsPhoneValid() {
    if (phoneController.value.text.length == 10) {
      isPhoneValid.value = true;
    } else {
      isPhoneValid.value = false;
    }
    enableContinueButton();
  }

  enableContinueButton() {
    if (isPhoneValid.value) {
      isPhoneComplete.value = true;
    } else {
      isPhoneComplete.value = false;
    }
  }

  validEmailCheck() {
    String email = emailController.value.text;

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (emailValid) {
      isValidEmail.value = true;
    } else {
      isValidEmail.value = false;
    }
    enableVerifyButton();
  }

  validPasswordCheck() {
    if (passwordController.value.text.length >= 8) {
      isValidPassword.value = true;
    } else {
      isValidPassword.value = false;
    }
    enableVerifyButton();
  }

  enableVerifyButton() {
    String emailPh = emailController.value.text;

    final bool emailPhValid = RegExp(r'^[0-9]{10}$').hasMatch(emailPh);

    if ((isValidEmail.value || emailPhValid) && isValidPassword.value) {
      isEmailPasswordComplete.value = true;
    } else {
      isEmailPasswordComplete.value = false;
    }
  }

  void selectCountryCode(String code) {
    countryCode.value = code;
  }

  void setEmailIconColor(bool val) {
    emailIconColor.value = val;
  }

  void setPasswordIconColor(bool val) {
    passwordIconColor.value = val;
  }

  void setPasswordVisible() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  changeOtpVerified() {
    isOtpVerified.value = true;
  }

  Future<void> verifyOTP({required BuildContext context}) async {
    try {
      var newAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.value.text,
      );

      authCredential = newAuthCredential;
      await login(context: context);
    } catch (e) {
      log("exception-->$e", name: "exception");
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    await firbaseAuth.verifyPhoneNumber(
      phoneNumber: '$countryCode ${phoneController.value.text}',
      verificationCompleted: ((phoneAuthCredential) {
        verificationCompleted(context, phoneAuthCredential);
      }),
      verificationFailed: verficationFailed,
      codeSent: (verificationId, forceResendingToken) {
        codeSent(
          verifyId: verificationId,
          forceResendingToken: forceResendingToken,
          isResend: true,
          context: context,
        );
      },
      forceResendingToken: resendToken?.value,
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verificationCompleted(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    authCredential = phoneAuthCredential;
    isOtpVerified.value = true;
    login(context: context);
  }

  verficationFailed(FirebaseAuthException e) {
    isOtpVerified.value = false;
    log('${e.message} Login Verification Failed');
  }

  codeSent(
      {required String verifyId,
      required int? forceResendingToken,
      required bool isResend,
      required BuildContext context}) {
    resendToken?.value = forceResendingToken ?? 0;
    verificationId.value = verifyId;
    // if (!isResend) {
    //   Navigator.pushNamed(context, RouteName.otpScreen);
    // }
  }

  codeAutoRetrievalTimeout(String verificationId) {}

  login({required BuildContext context}) async {
    try {
      // final UserCredential authResult =
      await firbaseAuth.signInWithCredential(authCredential!);

      isOtpVerified.value = true;

      dio.Response response = await signInWithOtp();

      if (response.statusCode == 200) {
        // final phoneNo = authResult.user!.phoneNumber;
        // await HiveServices.setStringValue(
        //     key: HiveKeys.phoneNumber, value: phoneNo!);
        final token = response.data['token'];
        await HiveServices.setStringValue(key: HiveKeys.token, value: token);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeScreen, (route) => false);
        emailController.value.dispose();
        passwordController.value.dispose();
        phoneController.value.clear();
        otpController.value.clear();
      }
    } catch (e) {
      isOtpVerified.value = false;
      log('SignIn Error: ${e.toString()}');
    }
  }

  userExist(bool isPhone) async {
    dio.Response response;
    if (isPhone) {
      log("success-->${phoneController.value.text}");
      response = await authRepository.userExist(
        phoneNo: phoneController.value.text,
      );
      log("success-->${phoneController.value.text}");
    } else {
      log(emailController.value.text);
      if (isValidEmail.value) {
        response = await authRepository.userExist(
          email: emailController.value.text,
        );
      } else {
        response = await authRepository.userExist(
          phoneNo: emailController.value.text,
        );
      }
    }
    log("success-->${response}");

    if (response.statusCode == 200 ||
        response.statusCode == 403 ||
        response.statusCode == 404) {
      log("success-->${response.data['success']}");
      log("active-->${response.data['is_Active']}");

      final userExist = response.data['success'];
      final userActive = response.data['is_Active'];

      HiveServices.setBoolValue(key: HiveKeys.isUserExist, value: userExist);
      HiveServices.setBoolValue(key: HiveKeys.isUserActive, value: userActive);

      return true;
    }
    return false;
  }

  signInWithPassword() async {
    dio.Response response;

    if (isValidEmail.value) {
      response = await authRepository.signInWithPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
    } else {
      response = await authRepository.signInWithPassword(
        phoneNo: emailController.value.text,
        password: passwordController.value.text,
      );
    }

    if (response.statusCode == 200) {
      final token = response.data['token'];
      HiveServices.setStringValue(key: HiveKeys.token, value: token);
      emailController.value.dispose();
      passwordController.value.dispose();
      phoneController.value.clear();
      otpController.value.clear();
    }
    return response.statusCode;
  }

  signInWithOtp() async {
    dio.Response response =
        await authRepository.signInWithOtp(phoneNo: phoneController.value.text);
    return response;
  }
}
