class UriApi {
  UriApi._();

  static const String BASE_AUTH_SERVER_URL = "";
  static const String BASE_API_URL =
      "https://d390-2001-448a-3045-5ae0-d0e6-b10b-cb00-1c76.ngrok-free.app";

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

//----------------------Passanger-------------------------------------------//
  static const String findDriverApi =
      "/nebengdong-service/v1/share-ride/find-driver";
  static const String passangerShareRideApi =
      "/nebengdong-service/v1/share-ride/passenger";

//----------------------Driver-------------------------------------------//
  static const String findPassengerApi =
      "/nebengdong-service/v1/share-ride/find-passenger";
  static const String driverActiveShareRideApi =
      "/nebengdong-service/v1/share-ride/driver";
  static const String updateShareRideAPi =
      "/nebengdong-service/v1/share-ride/driver";
}
