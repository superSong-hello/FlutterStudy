import 'package:dio/dio.dart';

class GithubApi {
  static const String baseUrl = 'https://api.github.com';

  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'X-GitHub-Api-Version': '2022-11-28',
      },
    );

  Future<Map<String, dynamic>> getRepository(String fullName) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/repos/$fullName',
    );
    return response.data!;
  }

  Future<Map<String, dynamic>> searchRepository(
    String keyword,
    int page,
    int perPage,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/search/repositories?q=$keyword',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    return response.data!;
  }

  Future<Map<String, dynamic>> getRepositoryReadme(String fullName) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/repos/$fullName/readme',
    );
    return response.data!;
  }

  Future<List<dynamic>> getRepositoryIssues(
    String fullName,
    int page,
    int perPage,
  ) async {
    final response = await dio.get<List<dynamic>>(
      '/repos/$fullName/issues',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    return response.data!;
  }
}
