import 'dart:async';
import 'dart:developer';

import 'package:anime_fandom/constants/hive_keys.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/features/authentication/models/gender_model.dart';
import 'package:anime_fandom/features/authentication/repository/auth_repository.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class SignupController extends GetxController {
  RxString gender = "Gender".obs;
  RxString dateOfBirth = "Date of Birth".obs;
  RxInt? selectedGender = 0.obs;
  RxInt? tempGender = 0.obs;
  RxBool isNameValid = false.obs;
  RxBool isPhonePassowrdComplete = false.obs;
  RxBool emailIconColor = false.obs;
  RxString countryCode = '+91'.obs;
  RxBool passwordVisibility = false.obs;
  RxBool passwordIconColor = false.obs;
  RxBool confirmPasswordVisibility = false.obs;
  RxBool confirmPasswordIconColor = false.obs;
  RxBool isPasswordValid = false.obs;
  RxBool isPhoneValid = false.obs;
  RxBool isfirstNameValid = false.obs;
  RxBool islastNameValid = false.obs;

  FirebaseAuth firbaseAuth = FirebaseAuth.instance;
  AuthCredential? authCredential;
  RxBool isOtpVerified = true.obs;
  RxString verificationId = ''.obs;
  RxInt? resendToken = 0.obs;

  RxInt timerSeconds = 30.obs;
  Timer? timer;

  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final otpController = TextEditingController().obs;

  List<GenderModel> genders = [
    GenderModel(
      gender: 'Male',
      icon: ImagePath.imgGenderMale,
    ),
    GenderModel(
      gender: 'Female',
      icon: ImagePath.imgGenderFemale,
    ),
    GenderModel(
      gender: 'Don\'t Say',
      icon: ImagePath.imgGenderPreferNotToSay,
    ),
  ].obs;

  List<String> selectedGenderIcons = [
    ImagePath.imgGenderMale,
    ImagePath.imgGenderFemale,
    ImagePath.imgGenderPreferNotToSay,
  ].obs;

  final AuthRepository authRepository = AuthRepository();

  void setGender(String val) {
    gender.value = val;
  }

  void setDateOfBirth(String val) {
    dateOfBirth.value = val;
  }

  void selectTempGender(int index) {
    tempGender!.value = index;
    // log("temp gender updated ${tempGender}");
  }

  void selectGender() {
    selectedGender = tempGender;
    // log("updating gender");
    setGender(genders[selectedGender!.value].gender);
  }

  setIsNameValid() {
    String firstName = firstNameController.value.text;
    String lastName = lastNameController.value.text;

    final bool firstNameValid = RegExp(r'^[a-z A-Z]+$').hasMatch(firstName);
    final bool lastNameValid = RegExp(r'^[a-z A-Z]+$').hasMatch(lastName);

    isfirstNameValid.value = firstNameValid;
    islastNameValid.value = lastNameValid;
    enableContinueButton();
  }

  enableContinueButton() {
    if (firstNameController.value.text.length >= 3 &&
        lastNameController.value.text.length >= 3 &&
        isfirstNameValid.value &&
        islastNameValid.value) {
      isNameValid.value = true;
      log("true");
      //isNameComplete = true;
    } else {
      isNameValid.value = false;
      //isNameComplete = false;
      log("false");
    }
  }

  setIsPhoneValid() {
    if (phoneController.value.text.length == 10) {
      isPhoneValid.value = true;
    } else {
      isPhoneValid.value = false;
    }
    enableRegisterButton();
  }

  setIsPasswordValid() {
    if (passwordController.value.text.length >= 8 &&
        passwordController.value.text == confirmPasswordController.value.text) {
      isPasswordValid.value = true;
    } else {
      isPasswordValid.value = false;
    }
    enableRegisterButton();
  }

  enableRegisterButton() {
    if (isPhoneValid.value && isPasswordValid.value) {
      isPhonePassowrdComplete.value = true;
    } else {
      isPhonePassowrdComplete.value = false;
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

  void setConfirmPasswordIconColor(bool val) {
    confirmPasswordIconColor.value = val;
  }

  void setConfirmPasswordVisible() {
    confirmPasswordVisibility.value = !confirmPasswordVisibility.value;
    //passwordVisibility = !passwordVisibility;
  }

  // otpClear() {
  //   = (otpController: otpController.clear());
  // }

  changeOtpVerified() {
    isOtpVerified.value = true;
  }

  Future<void> verifyOTP({required BuildContext context}) async {
    try {
      var finalAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.value.text,
      );

      authCredential = finalAuthCredential;
      await login(context: context);
    } catch (e) {
      log("exception-->$e", name: "exception");
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    await firbaseAuth.verifyPhoneNumber(
      phoneNumber: '${countryCode.value} ${phoneController.value.text}',
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

      dio.Response response = await registerUser();
      log("${response.statusCode}");
      log("${response.data}");
      if (response.statusCode == 201) {
        final token = response.data['token'];
        await HiveServices.setStringValue(key: HiveKeys.token, value: token);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeScreen, (route) => false);
        emailController.value.dispose();
        passwordController.value.dispose();
        phoneController.value.dispose();
        otpController.value.dispose();
        firstNameController.value.dispose();
        lastNameController.value.dispose();
        confirmPasswordController.value.dispose();
        gender.value = '';
        dateOfBirth.value = '';
      }
    } catch (e) {
      isOtpVerified.value = false;
      log('Signup Error: ${e.toString()}');
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (timerSeconds.value != 0) {
          timerSeconds.value = timerSeconds.value--;
          log(timer.tick.toString());
        }
      },
    );

    // timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   if (timerSeconds != 0) {
    //     timerSeconds--;
    //   }
    // });
  }

  setTimerInSeconds() {
    timerSeconds.value = 30;
  }

  userExist() async {
    dio.Response? response;

    response = await authRepository.userExist(
      phoneNo: phoneController.value.text,
    );

    if (response != null) {
      if (response.statusCode == 200 ||
          response.statusCode == 403 ||
          response.statusCode == 404) {
        log("success-->${response.data['success']}");
        log("active-->${response.data['is_Active']}");

        final userExist = response.data['success'];
        final userActive = response.data['is_Active'];

        HiveServices.setBoolValue(key: HiveKeys.isUserExist, value: userExist);
        HiveServices.setBoolValue(
            key: HiveKeys.isUserActive, value: userActive);

        return true;
      }
      return false;
    }
    return false;
  }

  registerUser() async {
    Response? response;
    response = await authRepository.registerUser(
      firstName: firstNameController.value.text,
      lastName: lastNameController.value.text,
      phoneNo: phoneController.value.text,
      password: passwordController.value.text,
      dob: dateOfBirth.value,
      gender: gender.value,
    );
    return response;
  }
}
