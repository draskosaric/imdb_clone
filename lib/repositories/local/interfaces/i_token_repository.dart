abstract class ITokenRepository {
  Future<String> getAccessToken();
  Future<void> saveAccessToken(String accessToken);
  Future<String> getRefreshToken();
}
