import 'package:dio/dio.dart';
import '../models/post.dart';

class ApiClient {
  final Dio _dio = Dio();

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('$baseUrl/posts');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}