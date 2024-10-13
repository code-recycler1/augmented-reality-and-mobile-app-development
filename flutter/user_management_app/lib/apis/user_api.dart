import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

// API helper class for interacting with the server
class UserApi {
  static String server = 'good-schools-decide.loca.lt'; // Base server URL

  // Fetch all users from the server
  static Future<List<User>> fetchUsers() async {
    var url = Uri.https(server, '/users');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((user) => User.fromJson(user))
          .toList(); // Parse JSON into User objects
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Fetch a single user by ID from the server
  static Future<User> fetchUser(int id) async {
    var url = Uri.https(server, '/users/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return User.fromJson(
          jsonDecode(response.body)); // Parse the user data from JSON
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Create a new user on the server
  static Future<User> createUser(User user) async {
    var url = Uri.https(server, '/users');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user), // Convert user object to JSON
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // Update an existing user by ID
  static Future<User> updateUser(int id, User user) async {
    var url = Uri.https(server, '/users/$id');

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user), // Convert updated user data to JSON
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete a user by ID
  static Future deleteUser(int id) async {
    var url = Uri.https(server, '/users/$id');

    final http.Response response = await http.delete(url);
    if (response.statusCode == 200) {
      return; // Successfully deleted
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
