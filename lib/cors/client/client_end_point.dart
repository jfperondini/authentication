class ClientEndPoint {
  static String baseUrl = "http://192.168.100.21:3000/";

  static String authorization = "Authorization";
  static String bearer = "Bearer";

  static String contetType = "Content-Type";
  static String applicationJson = "application/json";

  //Auth
  static String singUp = "auth/singUp";
  static String login = "auth/login";
  static String updateAccount = "auth/user";
  static String deleteAccount = "auth";

  //Validation
  static String validation = "validation";

  //Verification
  static String verification = "verification";

  //User
  //static String registerUser = "user/register";
  static String sharedUser = "user/shared";
  static String updateUser = "user/update";
}
