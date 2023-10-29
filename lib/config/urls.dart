class UriApi {
  UriApi._();

  static const String BASE_AUTH_SERVER_URL = "";
  static const String BASE_API_URL = "http://101.50.3.72:5000";

//--------------------------------Register------------------------------------//
  static const String registerApi = "/nebengdong-service/v1/users/registration";

//---------------------------------Login--------------------------------------//
  static const String loginApi = "/nebengdong-service/v1/users/login";

//--------------------------------Profile------------------------------------//
  static const String userProfileApi = "/nebengdong-service/v1/users/profile";
  static const String userChangeNumber =
      "/nebengdong-service/v1/users/phone-number";
  static const String userChangePassword =
      "/nebengdong-service/v1/users/password";
}
