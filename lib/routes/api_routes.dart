class ApiRoutes {
  static const baseURL = 'https://anime-fandom-backend-staging.vercel.app';

  // authentication URLs
  static const userExistURL = '$baseURL/api/v1/user/check';
  static const registerUserURL = '$baseURL/api/v1/register';
  static const signInWithOtpURL = '$baseURL/api/v1/login/phone';
  static const signInWithPasswordURL = '$baseURL/api/v1/login';
  static const forgetPasswordURL = '';

  // user URLs
  static const myProfileURL = '';
  static const editProfileURL = '';
  static const updatePasswordURL = '';

  // Post URLs
  static const getSinglePostURL = '';
  static const getAllPostsURL = '$baseURL/api/v1/posts';
  static const postPostURL = '';
  static const updatePostURL = '';
  static const likePostURL = '$baseURL/api/v1/posts/likes';

  // Favourite URLs
  static const getAllFavouriteURL = '$baseURL/api/v1/posts/all/favorites';
  static const setFavouriteURL = '$baseURL/api/v1/posts/favorites';
}
