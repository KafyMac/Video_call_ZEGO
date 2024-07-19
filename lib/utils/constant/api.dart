class URL {
  static const String prodBaseUrl = "https://zego-app-node-js-exp.vercel.app/";

  static const String baseBathUrl = prodBaseUrl;
}

class UrlPath {
  static const String apiLogin = "admin/login";
  static const String apiSignUp = "add/user";
  static const String apiFollowingList = "admin/get/following";
  static const String apiFollowersList = "admin/get/followers";
  static const String apiPeopleList = "admin/get/notFollowing";
  static const String apiFollowUser = "admin/follow";
  static const String apiUnFollowUser = "admin/unfollow";
  static const String apiGetAllStreams = "admin/getAllStreams";
  static const String apiMyProfile = "admin/get/profile";
}
