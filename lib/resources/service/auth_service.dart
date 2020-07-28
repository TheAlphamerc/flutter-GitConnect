abstract class AuthService {
  Future<String> getAcessToken(String code);
  Future<String> getUserName(String code);
}