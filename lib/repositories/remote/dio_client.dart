// Singleton instance
import 'package:dio/dio.dart';
import 'package:imdb_clone/repositories/local/interfaces/i_token_repository.dart';

class DioClient {
  late Dio dio;
  late ITokenRepository _tokenRepository;

  static final DioClient _client = DioClient._internal();
  factory DioClient() => _client;
  DioClient._internal();

  void init(String baseDomain, String refreshTokenUrl, ITokenRepository tokenRepository) {
    final BaseOptions baseOptions = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      receiveDataWhenStatusError: true,
      headers: {"content-Type": "application/json"},
      baseUrl: baseDomain,
    );
    _tokenRepository = tokenRepository;
    dio = Dio();
    dio.options = baseOptions;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      // exception for not sending Authorization header, mock fetching token and refresh token situations
      if (options.uri.toString().contains("login")) {
        return handler.next(options);
      }
      String token = await _tokenRepository.getAccessToken();
      if (!isTokenValid(token)) {
        try {
          token = await refreshToken();
        } catch (e) {
          handler.reject(DioError(
            requestOptions: options,
            error: e.toString(),
          ));
        }
      }
      options.headers["Authorization"] = "Bearer $token";
      return handler.next(options);
    }));
  }

  // function that determines if token exists or is expired
  bool isTokenValid(String token) => true;

  // call refresh token api call
  Future<String> refreshToken() async => _tokenRepository.getAccessToken();
}
