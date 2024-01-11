import 'package:dio/dio.dart';
import 'package:flutter_study/task5/model/repository_issue.dart';
import 'package:flutter_study/task5/model/repository_readme.dart';
import 'package:flutter_study/task5/model/search_result.dart';

class GitHubApi {
  /// 声明接口地址
  static const String baseUrl = 'https://api.github.com';

  //final声明变量 不会被重新赋值  Dart的级联调用
  final dio = Dio()..options = BaseOptions(
      baseUrl: baseUrl,
      //接口请求的请求头
      headers: {'X-GitHub-Api-Version': '2022-11-28'});

  Future<SearchResult> searchRepository(
    String keyword,
    int page,
    int perPage,
  ) async {
    // print(keyword);
    // print(page);
    // print(perPage);
    final response = await dio.get<Map<String, dynamic>>(
      '/search/repositories?q=$keyword',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );
    // print(response.data);
    return SearchResult.fromJson(response.data!);
  }

  Future<RepositoryReadme> getRepositoryReadme(String fullName) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/repos/$fullName/readme',
    );
    return RepositoryReadme.fromJson(response.data!);
  }

  Future<List<RepositoryIssue>> getRepositoryIssue(
    String fullName,
    int page,
    int perPage,
  ) async {
    final response = await dio.get<List<dynamic>>(
        '/repos/$fullName/issues',
        queryParameters: {'page': page, 'per_page': perPage});

    return response.data!
        .map((e) => RepositoryIssue.fromJson(e as Map<String, dynamic>))
        .toList();
   // return RepositoryIssue.fromJson(response.data!);
  }
}
