import 'git_config.dart';

class Config{
  static const String appName = "SpaceXopedia";
  static const String authUrl = "https://github.com/login/oauth/authorize?client_id=";
  static const String accessTken = "https://github.com/login/oauth/access_token?client_id=${GitConfig.CLIENT_ID}&client_secret=${GitConfig.CLIENT_SECRET}&code=";
  static const String apiBaseUrl = "https://api.github.com/";
  static const String user = "user";
  static const String repos = "user/repos";
  static const String notificationsList = "notifications?all=true";

  static String getEvent(userName) {
    return "users/$userName/events";
  }
  static String getReadme({String name, String owner}) {
    return "https://raw.githubusercontent.com/$owner/$name/master/README.md";
  }
}