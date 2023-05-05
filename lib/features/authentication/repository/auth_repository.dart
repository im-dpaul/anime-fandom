import 'dart:convert';
import 'dart:developer';

import 'package:anime_fandom/core/dio_utils.dart';
import 'package:anime_fandom/routes/api_routes.dart';

class AuthRepository {
  final _dioInstance = DioUtil().getInstance();

  // user active & user exist check
  userExist({String? phoneNo, String? email}) async {
    try {
      final response = await _dioInstance?.post(
        ApiRoutes.userExistURL,
        data: jsonEncode({
          if (phoneNo != null) "phoneNo": phoneNo,
          if (email != null) "email": email,
        }),
      );
      return response;
    } catch (e) {
      log("userExist() Exception -> $e");
    }
  }

  // user signIn with phoneNo & otp
  signInWithOtp({required String? phoneNo}) async {
    try {
      final response = await _dioInstance?.post(
        ApiRoutes.signInWithOtpURL,
        data: {
          "phoneNo": phoneNo,
        },
      );
      return response;
    } catch (e) {
      log("signInWithOtp() Exception -> $e");
    }
  }

  // user signIn with email/phoneNo & password
  signInWithPassword(
      {String? phoneNo, String? email, required String password}) async {
    try {
      final response = await _dioInstance?.post(
        ApiRoutes.signInWithPasswordURL,
        data: {
          if (phoneNo != null) "phoneNo": phoneNo,
          if (email != null) "email": email,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      log("signInWithPassword() Exception -> $e");
    }
  }

  // user signUp
  registerUser({
    required String firstName,
    required String lastName,
    String? dob,
    String? gender,
    required String phoneNo,
    required String password,
    String? email,
  }) async {
    try {
      final response = await _dioInstance?.post(
        ApiRoutes.registerUserURL,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          if (gender != "Gender") "gender": gender,
          if (dob != "Date of Birth") "dob": dob,
          "phoneNo": phoneNo,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      log("registerUser() Exception -> $e");
    }
  }

  // user forget password
  forgetPassword({required String phoneNo, required String password}) async {
    try {
      final response = await _dioInstance?.post(
        ApiRoutes.forgetPasswordURL,
        data: {
          "phoneNo": phoneNo,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      log("forgetPassword() Exception -> $e");
    }
  }
}
