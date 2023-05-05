class ApiRoutes {
  static const baseURL = 'https://b43d-182-69-177-54.ngrok-free.app';

  // authentication URLs
  static const userExistURL = '$baseURL/api/v1/user/check';
  static const registerUserURL = '$baseURL/api/v1/register';
  static const signInWithOtpURL = '$baseURL/api/v1/login/phone';
  static const signInWithPasswordURL = '$baseURL/api/v1/login';
  static const forgetPasswordURL = '';

  // content URLs
  static const getContentURL = '';
  static const postContentURL = '';
  static const updateContentURL = '';

  // user URLs
  static const myProfileURL = '';
  static const editProfileURL = '';
  static const updatePasswordURL = '';
}
