// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:anime_fandom/constants/hive_keys.dart';
import 'package:anime_fandom/core/hive_services.dart';
import 'package:anime_fandom/features/authentication/repository/auth_repository.dart';
import 'package:anime_fandom/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_fandom/constants/image_path.dart';
import 'package:anime_fandom/features/authentication/models/gender_model.dart';

class SignupProvider {
  String gender = "Gender";
  String dateOfBirth = "Date of Birth";
  int? selectedGender = 0;
  int? tempGender = 0;
  bool isNameValid = false;
  bool isPhonePassowrdComplete = false;
  bool emailIconColor = false;
  String countryCode = '+91';
  bool passwordVisibility = false;
  bool passwordIconColor = false;
  bool confirmPasswordVisibility = false;
  bool confirmPasswordIconColor = false;
  bool isPasswordValid = false;
  bool isPhoneValid = false;
  bool isfirstNameValid = false;
  bool islastNameValid = false;

  FirebaseAuth firbaseAuth = FirebaseAuth.instance;
  AuthCredential? authCredential;
  bool isOtpVerified = true;
  String verificationId = '';
  int? resendToken;

  int timerSeconds = 30;
  Timer? timer;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

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
      gender: 'Prefer Not to Say',
      icon: ImagePath.imgGenderPreferNotToSay,
    ),
  ];

  List<String> selectedGenderIcons = [
    ImagePath.imgGenderMale,
    ImagePath.imgGenderFemale,
    ImagePath.imgGenderPreferNotToSay,
  ];

  SignupProvider({
    required this.gender,
    required this.dateOfBirth,
    required this.selectedGender,
    required this.tempGender,
    required this.isNameValid,
    required this.isPhonePassowrdComplete,
    required this.countryCode,
    required this.isOtpVerified,
    required this.emailIconColor,
    required this.genders,
    required this.selectedGenderIcons,
    required this.timerSeconds,
    required this.timer,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.otpController,
    required this.passwordIconColor,
    required this.passwordVisibility,
    required this.confirmPasswordIconColor,
    required this.confirmPasswordVisibility,
    required this.isPasswordValid,
    required this.isPhoneValid,
    required this.isfirstNameValid,
    required this.islastNameValid,
    required this.firbaseAuth,
    required this.authCredential,
    required this.resendToken,
    required this.verificationId,
  });

  SignupProvider copyWith({
    String? gender,
    String? dateOfBirth,
    int? selectedGender,
    int? tempGender,
    bool? isNameValid,
    bool? isPhonePassowrdComplete,
    String? countryCode,
    bool? isOtpVerified,
    bool? emailIconColor,
    int? timerSeconds,
    Timer? timer,
    List<GenderModel>? genders,
    List<String>? selectedGenderIcons,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? phoneController,
    TextEditingController? otpController,
    bool? passwordIconColor,
    bool? passwordVisibility,
    bool? confirmPasswordIconColor,
    bool? confirmPasswordVisibility,
    bool? isPasswordValid,
    bool? isPhoneValid,
    bool? isfirstNameValid,
    bool? islastNameValid,
    FirebaseAuth? firebaseAuth,
    AuthCredential? authCredential,
    String? verificationId,
    int? resendToken,
  }) {
    return SignupProvider(
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      selectedGender: selectedGender ?? this.selectedGender,
      tempGender: tempGender ?? this.tempGender,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhonePassowrdComplete:
          isPhonePassowrdComplete ?? this.isPhonePassowrdComplete,
      countryCode: countryCode ?? this.countryCode,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      emailIconColor: emailIconColor ?? this.emailIconColor,
      genders: genders ?? this.genders,
      selectedGenderIcons: selectedGenderIcons ?? this.selectedGenderIcons,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      timer: timer ?? this.timer,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      phoneController: phoneController ?? this.phoneController,
      otpController: otpController ?? this.otpController,
      passwordIconColor: passwordIconColor ?? this.passwordIconColor,
      passwordVisibility: passwordVisibility ?? this.passwordVisibility,
      confirmPasswordIconColor:
          confirmPasswordIconColor ?? this.confirmPasswordIconColor,
      confirmPasswordVisibility:
          confirmPasswordVisibility ?? this.confirmPasswordVisibility,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isfirstNameValid: isfirstNameValid ?? this.isfirstNameValid,
      islastNameValid: islastNameValid ?? this.islastNameValid,
      firbaseAuth: firbaseAuth,
      authCredential: authCredential ?? this.authCredential,
      resendToken: resendToken ?? this.resendToken,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'gender': gender,
  //     'selectedGender': selectedGender,
  //     'tempGender': tempGender,
  //     'isNameComplete': isNameComplete,
  //     'genders': genders.map((x) => x.toMap()).toList(),
  //     'selectedGenderIcons': selectedGenderIcons,
  //   };
  // }

  // factory AuthenticationProvider.fromMap(Map<String, dynamic> map) {
  //   return AuthenticationProvider(
  //     gender: map['gender'] as String,
  //     selectedGender: map['selectedGender'] != null ? map['selectedGender'] as int : null,
  //     tempGender: map['tempGender'] != null ? map['tempGender'] as int : null,
  //     isNameComplete: map['isNameComplete'] as bool,
  //     genders: List<GenderModel>.from((map['genders'] as List<int>).map<GenderModel>((x) => GenderModel.fromMap(x as Map<String,dynamic>),),),
  //     selectedGenderIcons: List<String>.from((map['selectedGenderIcons'] as List<String>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory AuthenticationProvider.fromJson(String source) => AuthenticationProvider.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'AuthenticationProvider(gender: $gender, selectedGender: $selectedGender, tempGender: $tempGender, isNameComplete: $isNameValid, genders: $genders, selectedGenderIcons: $selectedGenderIcons)';
  // }

  // @override
  // bool operator ==(covariant SignupProvider other) {
  //   if (identical(this, other)) return true;

  //   return other.gender == gender &&
  //       other.dateOfBirth == dateOfBirth &&
  //       other.selectedGender == selectedGender &&
  //       other.tempGender == tempGender &&
  //       other.isNameValid == isNameValid &&
  //       other.isPhonePassowrdComplete == isPhonePassowrdComplete &&
  //       other.countryCode == countryCode &&
  //       other.isOtpVerified == isOtpVerified &&
  //       other.emailIconColor == emailIconColor &&
  //       other.timerSeconds == timerSeconds &&
  //       other.timer == timer &&
  //       other.passwordIconColor == passwordIconColor &&
  //       other.passwordVisibility == passwordVisibility &&
  //       other.confirmPasswordIconColor == confirmPasswordIconColor &&
  //       other.confirmPasswordVisibility == confirmPasswordVisibility &&
  //       other.isPhoneValid == isPhoneValid &&
  //       other.isPasswordValid == isPasswordValid &&
  //       other.isfirstNameValid == isfirstNameValid &&
  //       other.islastNameValid == islastNameValid &&
  //       listEquals(other.genders, genders) &&
  //       listEquals(other.selectedGenderIcons, selectedGenderIcons);
  // }

  // @override
  // int get hashCode {
  //   return gender.hashCode ^
  //       dateOfBirth.hashCode ^
  //       selectedGender.hashCode ^
  //       tempGender.hashCode ^
  //       isNameValid.hashCode ^
  //       isPhonePassowrdComplete.hashCode ^
  //       countryCode.hashCode ^
  //       emailIconColor.hashCode ^
  //       genders.hashCode ^
  //       isOtpVerified.hashCode ^
  //       timerSeconds.hashCode ^
  //       timer.hashCode ^
  //       selectedGenderIcons.hashCode ^
  //       passwordVisibility.hashCode ^
  //       passwordIconColor.hashCode ^
  //       confirmPasswordVisibility.hashCode ^
  //       isPhoneValid.hashCode ^
  //       isPasswordValid.hashCode ^
  //       isfirstNameValid.hashCode ^
  //       islastNameValid.hashCode ^
  //       confirmPasswordIconColor.hashCode;
  // }
}

class SignupNotifier extends StateNotifier<SignupProvider> {
  SignupNotifier()
      : super(
          SignupProvider(
            gender: "Gender",
            dateOfBirth: "Date of Birth",
            genders: [
              GenderModel(
                gender: 'Male',
                icon: ImagePath.imgGenderMale,
              ),
              GenderModel(
                gender: 'Female',
                icon: ImagePath.imgGenderFemale,
              ),
              GenderModel(
                gender: 'Prefer Not to Say',
                icon: ImagePath.imgGenderPreferNotToSay,
              ),
            ],
            isNameValid: false,
            isPhonePassowrdComplete: false,
            countryCode: '+91',
            isOtpVerified: true,
            emailIconColor: false,
            timerSeconds: 30,
            timer: Timer.periodic(const Duration(seconds: 1), (timer) => {}),
            selectedGenderIcons: [
              ImagePath.imgGenderMale,
              ImagePath.imgGenderFemale,
              ImagePath.imgGenderPreferNotToSay,
            ],
            selectedGender: 0,
            tempGender: 0,
            firstNameController: TextEditingController(),
            lastNameController: TextEditingController(),
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            confirmPasswordController: TextEditingController(),
            phoneController: TextEditingController(),
            otpController: TextEditingController(),
            passwordIconColor: false,
            passwordVisibility: false,
            confirmPasswordIconColor: false,
            confirmPasswordVisibility: false,
            isPasswordValid: false,
            isPhoneValid: false,
            isfirstNameValid: false,
            islastNameValid: false,
            firbaseAuth: FirebaseAuth.instance,
            authCredential: AuthCredential(providerId: "", signInMethod: ''),
            resendToken: 0,
            verificationId: '',
          ),
        );

  final AuthRepository authRepository = AuthRepository();

  void setGender(String val) {
    state = state.copyWith(gender: val);
  }

  void setDateOfBirth(String val) {
    state = state.copyWith(dateOfBirth: val);
  }

  void selectTempGender(int index) {
    // log("temp gender updating ${state.tempGender}");
    state = state.copyWith(tempGender: index);
    // log("temp gender updated ${state.tempGender}");
  }

  void selectGender() {
    state = state.copyWith(selectedGender: state.tempGender);
    // log("updating gender");
    setGender(state.genders[state.selectedGender!].gender);
  }

  isNameValid() {
    String firstName = state.firstNameController.text;
    String lastName = state.lastNameController.text;

    final bool firstNameValid = RegExp(r'^[a-z A-Z]+$').hasMatch(firstName);
    final bool lastNameValid = RegExp(r'^[a-z A-Z]+$').hasMatch(lastName);

    state = state.copyWith(isfirstNameValid: firstNameValid);
    state = state.copyWith(islastNameValid: lastNameValid);
    enableContinueButton();
  }

  enableContinueButton() {
    if (state.firstNameController.text.length >= 3 &&
        state.lastNameController.text.length >= 3 &&
        state.isfirstNameValid &&
        state.islastNameValid) {
      state = state.copyWith(isNameValid: true);
      log("true");
      //state.isNameComplete = true;
    } else {
      state = state.copyWith(isNameValid: false);
      //state.isNameComplete = false;
      log("false");
    }
  }

  isPhoneValid() {
    if (state.phoneController.text.length == 10) {
      state = state.copyWith(isPhoneValid: true);
    } else {
      state = state.copyWith(isPhoneValid: false);
    }
    enableRegisterButton();
  }

  isPasswordValid() {
    if (state.passwordController.text.length >= 8 &&
        state.passwordController.text == state.confirmPasswordController.text) {
      state = state.copyWith(isPasswordValid: true);
    } else {
      state = state.copyWith(isPasswordValid: false);
    }
    enableRegisterButton();
  }

  enableRegisterButton() {
    if (state.isPhoneValid && state.isPasswordValid) {
      state = state.copyWith(isPhonePassowrdComplete: true);
    } else {
      state = state.copyWith(isPhonePassowrdComplete: false);
    }
  }

  void selectCountryCode(String code) {
    state = state.copyWith(countryCode: code);
    //countryCode = code;
  }

  void setEmailIconColor(bool val) {
    state = state.copyWith(emailIconColor: val);
    //emailIconColor = val;
  }

  void setPasswordIconColor(bool val) {
    state = state.copyWith(passwordIconColor: val);
    // passwordIconColor = val;
  }

  void setPasswordVisible() {
    state = state.copyWith(passwordVisibility: !state.passwordVisibility);
    //passwordVisibility = !passwordVisibility;
  }

  void setConfirmPasswordIconColor(bool val) {
    state = state.copyWith(confirmPasswordIconColor: val);
    // passwordIconColor = val;
  }

  void setConfirmPasswordVisible() {
    state = state.copyWith(
        confirmPasswordVisibility: !state.confirmPasswordVisibility);
    //passwordVisibility = !passwordVisibility;
  }

  // otpClear() {
  //   state = state.copyWith(otpController: state.otpController.clear());
  // }

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

      Response response = await registerUser();
      log("${response.statusCode}");
      log("${response.data}");
      if (response.statusCode == 201) {
        final token = response.data['token'];
        await HiveServices.setStringValue(key: HiveKeys.token, value: token);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeScreen, (route) => false);
        state.emailController.dispose();
        state.passwordController.dispose();
        state.phoneController.clear();
        state.otpController.clear();
        state.firstNameController.clear();
        state.lastNameController.clear();
        state.confirmPasswordController.clear();
        state = state.copyWith(gender: '', dateOfBirth: '');
      }
    } catch (e) {
      state = state.copyWith(isOtpVerified: false);
      log('Signup Error: ${e.toString()}');
    }
  }

  void startTimer() {
    state = state.copyWith(
      timer: Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          if (state.timerSeconds != 0) {
            state = state.copyWith(timerSeconds: state.timerSeconds--);
            log(state.timer!.tick.toString());
          }
        },
      ),
    );
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   if (timerSeconds != 0) {
    //     timerSeconds--;
    //   }
    // });
  }

  setTimerInSeconds() {
    state = state.copyWith(timerSeconds: 30);
  }

  userExist() async {
    Response? response;

    response = await authRepository.userExist(
      phoneNo: state.phoneController.text,
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
      firstName: state.firstNameController.text,
      lastName: state.lastNameController.text,
      phoneNo: state.phoneController.text,
      password: state.passwordController.text,
      dob: state.dateOfBirth,
      gender: state.gender,
    );
    return response;
  }
}
