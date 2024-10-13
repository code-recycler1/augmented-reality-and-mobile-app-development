import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

// API class for interacting with the New York Times API
class NytApi {
  static const String _apiKey = 'API_KEY'; // API Key for authentication
  static const String _baseUrl =
      'https://api.nytimes.com/svc/topstories/v2'; // Base API URL

  // Fetch posts from the API based on a section (e.g., "home", "arts", etc.)
  static Future<List<Post>> fetchPosts(String section) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/$section.json?api-key=$_apiKey'));

    // If the response is successful, parse the JSON and return the list of posts
    if (response.statusCode == 200) {
      List jsonResponse =
          json.decode(utf8.decode(response.bodyBytes))['results'];
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception(
          'Failed to load posts'); // Throw an error if the API call fails
    }
  }
}
