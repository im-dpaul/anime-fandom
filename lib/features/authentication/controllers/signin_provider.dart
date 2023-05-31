// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:anime_fandom/constants/hive_keys.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_fandom/features/authentication/repository/auth_repository.dart';

class SigninProvider {
  bool passwordVisibility = false;
  bool passwordIconColor = false;
  bool emailIconColor = false;
  bool isPhoneValid = false;
  bool isPhoneComplete = false;
  bool isEmailPasswordComplete = false;
  bool isValidEmail = false;
  bool isValidPassword = false;
  String countryCode = '+91';
  bool forgetPassword = false;

  FirebaseAuth firbaseAuth = FirebaseAuth.instance;
  AuthCredential? authCredential;
  bool isOtpVerified = true;
  String verificationId = '';
  int? resendToken;

  int timerSeconds = 30;
  Timer? timer;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  SigninProvider({
    required this.passwordVisibility,
    required this.passwordIconColor,
    required this.emailIconColor,
    required this.isPhoneValid,
    required this.isPhoneComplete,
    required this.isEmailPasswordComplete,
    required this.isValidPassword,
    required this.isValidEmail,
    required this.countryCode,
    required this.forgetPassword,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.otpController,
    required this.isOtpVerified,
    required this.timerSeconds,
    required this.timer,
    required this.firbaseAuth,
    required this.authCredential,
    required this.resendToken,
    required this.verificationId,
  });

  SigninProvider copyWith({
    bool? passwordVisibility,
    bool? passwordIconColor,
    bool? emailIconColor,
    bool? isPhoneValid,
    bool? isPhoneComplete,
    bool? isEmailPasswordComplete,
    bool? isValidPassword,
    bool? isValidEmail,
    String? countryCode,
    bool? isOtpVerified,
    bool? forgetPassword,
    int? timerSeconds,
    Timer? timer,
    FirebaseAuth? firebaseAuth,
    AuthCredential? authCredential,
    String? verificationId,
    int? resendToken,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? phoneController,
    TextEditingController? otpController,
  }) {
    return SigninProvider(
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
      passwordIconColor: passwordIconColor ?? this.passwordIconColor,
      emailIconColor: emailIconColor ?? this.emailIconColor,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPhoneComplete: isPhoneComplete ?? this.isPhoneComplete,
      isEmailPasswordComplete:
          isEmailPasswordComplete ?? this.isEmailPasswordComplete,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      countryCode: countryCode ?? this.countryCode,
      forgetPassword: forgetPassword ?? this.forgetPassword,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      phoneController: phoneController ?? this.phoneController,
      otpController: otpController ?? this.otpController,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      timer: timer ?? this.timer,
      firbaseAuth: firbaseAuth,
      authCredential: authCredential ?? this.authCredential,
      resendToken: resendToken ?? this.resendToken,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'passwordVisibility': passwordVisibility,
  //     'passwordIconColor': passwordIconColor,
  //     'emailIconColor': emailIconColor,
  //     'isPhoneComplete': isPhoneComplete,
  //     'isEmailComplete': isEmailComplete,
  //     'countryCode': countryCode,
  //   };
  // }

  // factory SigninProvider.fromMap(Map<String, dynamic> map) {
  //   return SigninProvider(
  //     passwordVisibility: map['passwordVisibility'] as bool,
  //     passwordIconColor: map['passwordIconColor'] as bool,
  //     emailIconColor: map['emailIconColor'] as bool,
  //     isPhoneComplete: map['isPhoneComplete'] as bool,
  //     isEmailComplete: map['isEmailComplete'] as bool,
  //     countryCode: map['countryCode'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory SigninProvider.fromJson(String source) =>
  //     SigninProvider.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SigninProvider(passwordVisibility: $passwordVisibility, passwordIconColor: $passwordIconColor, emailIconColor: $emailIconColor, isPhoneComplete: $isPhoneValid, isEmailComplete: $isEmailPasswordComplete, countryCode: $countryCode)';
  }

  @override
  bool operator ==(covariant SigninProvider other) {
    if (identical(this, other)) return true;

    return other.passwordVisibility == passwordVisibility &&
        other.passwordIconColor == passwordIconColor &&
        other.emailIconColor == emailIconColor &&
        other.isPhoneValid == isPhoneValid &&
        other.isPhoneComplete == isPhoneComplete &&
        other.isEmailPasswordComplete == isEmailPasswordComplete &&
        other.isValidPassword == isValidPassword &&
        other.isValidEmail == isValidEmail &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return passwordVisibility.hashCode ^
        passwordIconColor.hashCode ^
        emailIconColor.hashCode ^
        isPhoneValid.hashCode ^
        isPhoneComplete.hashCode ^
        isEmailPasswordComplete.hashCode ^
        isValidPassword.hashCode ^
        isValidEmail.hashCode ^
        countryCode.hashCode;
  }
}

class SigninNotifier extends StateNotifier<SigninProvider> {
  SigninNotifier()
      : super(
          SigninProvider(
            countryCode: '+91',
            emailIconColor: false,
            isEmailPasswordComplete: false,
            isPhoneComplete: false,
            isPhoneValid: false,
            isValidPassword: false,
            isValidEmail: false,
            passwordIconColor: false,
            passwordVisibility: false,
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            phoneController: TextEditingController(),
            otpController: TextEditingController(),
            isOtpVerified: true,
            forgetPassword: false,
            timerSeconds: 30,
            timer: Timer.periodic(const Duration(seconds: 1), (timer) => {}),
            firbaseAuth: FirebaseAuth.instance,
            authCredential: AuthCredential(providerId: "", signInMethod: ''),
            resendToken: 0,
            verificationId: '',
          ),
        );

  final AuthRepository authRepository = AuthRepository();

  setForgetPassword({required bool val}) {
    state = state.copyWith(forgetPassword: val);
  }

  isPhoneValid() {
    if (state.phoneController.text.length == 10) {
      state = state.copyWith(isPhoneValid: true);
    } else {
      state = state.copyWith(isPhoneValid: false);
    }
    enableContinueButton();
  }

  enableContinueButton() {
    if (state.isPhoneValid) {
      state = state.copyWith(isPhoneComplete: true);
    } else {
      state = state.copyWith(isPhoneComplete: false);
    }
  }

  validEmailCheck() {
    String email = state.emailController.text;

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (emailValid) {
      state = state.copyWith(isValidEmail: true);
    } else {
      state = state.copyWith(isValidEmail: false);
    }
    enableVerifyButton();
  }

  validPasswordCheck() {
    if (state.passwordController.text.length >= 8) {
      state = state.copyWith(isValidPassword: true);
    } else {
      state = state.copyWith(isValidPassword: false);
    }
    enableVerifyButton();
  }

  enableVerifyButton() {
    String emailPh = state.emailController.text;

    final bool emailPhValid = RegExp(r'^[0-9]{10}$').hasMatch(emailPh);

    if ((state.isValidEmail || emailPhValid) && state.isValidPassword) {
      state = state.copyWith(isEmailPasswordComplete: true);
    } else {
      state = state.copyWith(isEmailPasswordComplete: false);
    }
  }

  void selectCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  void setEmailIconColor(bool val) {
    state = state.copyWith(emailIconColor: val);
  }

  void setPasswordIconColor(bool val) {
    state = state.copyWith(passwordIconColor: val);
  }

  void setPasswordVisible() {
    state = state.copyWith(passwordVisibility: !state.passwordVisibility);
  }

  changeOtpVerified() {
    state = state.copyWith(isOtpVerified: true);
    // isOtpVerified = true;
  }

  Future<void> verifyOTP({required BuildContext context}) async {
    try {
      var authCredential = PhoneAuthProvider.credential(
        verificationId: state.verificationId,
        smsCode: state.otpController.text,
      );

      state = state.copyWith(authCredential: authCredential);
      await login(context: context);
    } catch (e) {
      log("exception-->$e", name: "exception");
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    await state.firbaseAuth.verifyPhoneNumber(
      phoneNumber: '${state.countryCode} ${state.phoneController.text}',
      verificationCompleted: ((phoneAuthCredential) {
        verificationCompleted(context, phoneAuthCredential);
      }),
      verificationFailed: verficationFailed,
      codeSent: (verificationId, forceResendingToken) {
        codeSent(
          verificationId: verificationId,
          forceResendingToken: forceResendingToken,
          isResend: true,
          context: context,
        );
      },
      forceResendingToken: state.resendToken,
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  verificationCompleted(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    state = state.copyWith(authCredential: phoneAuthCredential);
    state = state.copyWith(isOtpVerified: true);
    login(context: context);
  }

  verficationFailed(FirebaseAuthException e) {
    state = state.copyWith(isOtpVerified: false);
    log('${e.message} Login Verification Failed');
  }

  codeSent(
      {required String verificationId,
      required int? forceResendingToken,
      required bool isResend,
      required BuildContext context}) {
    state = state.copyWith(resendToken: forceResendingToken);
    state = state.copyWith(verificationId: verificationId);
    // if (!isResend) {
    //   Navigator.pushNamed(context, RouteName.otpScreen);
    // }
  }

  codeAutoRetrievalTimeout(String verificationId) {}

  login({required BuildContext context}) async {
    try {
      final UserCredential authResult =
          await state.firbaseAuth.signInWithCredential(state.authCredential!);

      state = state.copyWith(isOtpVerified: true);

      Response response = await signInWithOtp();

      if (response.statusCode == 200) {
        // final phoneNo = authResult.user!.phoneNumber;
        // await HiveServices.setStringValue(
        //     key: HiveKeys.phoneNumber, value: phoneNo!);
        final token = response.data['token'];
        await HiveServices.setStringValue(key: HiveKeys.token, value: token);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeScreen, (route) => false);
        state.emailController.dispose();
        state.passwordController.dispose();
        state.phoneController.clear();
        state.otpController.clear();
      }
    } catch (e) {
      state = state.copyWith(isOtpVerified: false);
      log('SignIn Error: ${e.toString()}');
    }
  }

  userExist(bool isPhone) async {
    Response? response;
    if (isPhone) {
      response = await authRepository.userExist(
        phoneNo: state.phoneController.text,
      );
    } else {
      log(state.emailController.text);
      if (state.isValidEmail) {
        response = await authRepository.userExist(
          email: state.emailController.text,
        );
      } else {
        response = await authRepository.userExist(
          phoneNo: state.emailController.text,
        );
      }
    }

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

  signInWithPassword() async {
    Response response;

    if (state.isValidEmail) {
      response = await authRepository.signInWithPassword(
        email: state.emailController.text,
        password: state.passwordController.text,
      );
    } else {
      response = await authRepository.signInWithPassword(
        phoneNo: state.emailController.text,
        password: state.passwordController.text,
      );
    }

    if (response.statusCode == 200) {
      final token = response.data['token'];
      HiveServices.setStringValue(key: HiveKeys.token, value: token);
      state.emailController.dispose();
      state.passwordController.dispose();
      state.phoneController.clear();
      state.otpController.clear();
    }
    return response.statusCode;
  }

  signInWithOtp() async {
    Response response =
        await authRepository.signInWithOtp(phoneNo: state.phoneController.text);
    return response;
  }
}
