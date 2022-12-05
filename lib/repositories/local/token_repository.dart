import 'package:imdb_clone/repositories/local/interfaces/i_token_repository.dart';

class TokenRepository implements ITokenRepository {
  String _accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4";

  @override
  Future<String> getAccessToken() async => _accessToken;

  @override
  Future<void> saveAccessToken(String accessToken) async => _accessToken = accessToken;

  @override
  Future<String> getRefreshToken() async => "";
}
