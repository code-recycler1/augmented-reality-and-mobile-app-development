# User Management App

This is a **Flutter 3.9.16** application for managing users. The app allows you to create, read, update, and delete user information. It interacts with a backend server to fetch and store user data.

### Prerequisites

- **Flutter 3.9.16**
- Dart
- JSON server
- Localtunnel

Before running the app: 
- Install `npm install -g json-server localtunnel`
- Execute `start_api_tunnel.bat` and change the server variable in `user_api.dart` to your own localtunnel.

## Features

- Display a list of users
- View user details
- Add a new user
- Edit an existing user
- Delete a user

## Project Structure

The project structure is organized as follows:

```text
lib/
├── main.dart
|── apis/
│    └── user_api.dart
|── models/
│    └── user.dart
├── pages/
│    ├── user_detail.dart
│    └── user_list.dart
└── widgets/

json-server-local/
└── db.json
```

- `main.dart`: Entry point of the application.
- `pages/user_list.dart`: Displays the list of users.
- `pages/user_detail.dart`: Displays and edits user details.
- `apis/user_api.dart`: Handles API interactions with the - backend server.
- `models/user.dart`: Defines the User model. 

## API Endpoints
The app interacts with the following API endpoints:

- `GET /users`: Fetch all users.
- `GET /users/{id}`: Fetch a single user by ID.
- `POST /users`: Create a new user.
- `PUT /users/{id}`: Update an existing user by ID.
- `DELETE /users/{id}`: Delete a user by ID.

## Code Overview

### main.dart

```dart
import 'package:flutter/material.dart';
import 'pages/user_list.dart';

// Entry point for the Flutter app
void main() {
  runApp(const UserManagementApp());
}

// Root widget of the app
class UserManagementApp extends StatelessWidget {
  const UserManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'User Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red), // App theme with a seed color
      ),
      home: const UserListPage(), // Main page displaying the list of users
    );
  }
}
```

### user_api.dart

```dart
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
```

### user.dart

```dart
// User model representing the user data structure
class User {
  int id;
  String email;
  String firstname;
  String lastname;

  User(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname});

  // Factory constructor to create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int
          ? json['id']
          : int.parse(json['id']), // Convert id to int
      email: json['email'],
      firstname: json['first_name'],
      lastname: json['last_name'],
    );
  }

  // Convert the User object to JSON format
  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstname,
        'last_name': lastname,
      };
}
```

### user_detail.dart

```dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/user_api.dart';

const List<String> choices = <String>[
  'Save User & Back', // Option to save user and return to list
  'Delete User', // Option to delete the user
  'Back to List' // Option to go back without changes
];

class UserDetailPage extends StatefulWidget {
  final int id; // User ID, 0 for creating a new user

  const UserDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  User? user; // User object, initially null

  // Controllers to handle text input for user details
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id == 0) {
      user = User(id: 0, firstname: "", lastname: "", email: ""); // New user
    } else {
      _getUser(widget.id); // Fetch user details if editing
    }
  }

  // Fetch user details by ID
  void _getUser(int id) {
    UserApi.fetchUser(id).then((result) {
      setState(() {
        user = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User details"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuSelected, // Handle menu selection
            itemBuilder: (BuildContext context) {
              return choices.asMap().entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key.toString(),
                  child: Text(entry.value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _userDetails(), // Display the user details form
      ),
    );
  }

  // Display user detail form or loading indicator
  _userDetails() {
    if (user == null) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    } else {
      TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

      firstnameController.text = user!.firstname;
      lastnameController.text = user!.lastname;
      emailController.text = user!.email;

      // Form fields for user data
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: firstnameController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(height: 15),
            TextField(
              controller: lastnameController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(height: 15),
            TextField(
              controller: emailController,
              style: textStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  // Handle menu item selection
  void _menuSelected(String index) async {
    switch (index) {
      case "0": // Save User & Back
        _saveUser();
        break;
      case "1": // Delete User
        _deleteUser();
        break;
      case "2": // Back to List
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  // Save user data
  void _saveUser() {
    user!.firstname = firstnameController.text;
    user!.lastname = lastnameController.text;
    user!.email = emailController.text;

    if (user!.id == 0) {
      UserApi.createUser(user!).then((result) {
        Navigator.pop(context, true);
      });
    } else {
      UserApi.updateUser(widget.id, user!).then((result) {
        Navigator.pop(context, true);
      });
    }
  }

  // Delete user by ID
  void _deleteUser() {
    UserApi.deleteUser(widget.id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
```

### user_list.dart

```dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/user_api.dart';
import 'user_detail.dart';

// Page showing the list of users
class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> userList = []; // List of users
  int count = 0; // Number of users

  @override
  void initState() {
    super.initState();
    _getUsers(); // Fetch the list of users
  }

  // Fetch users from the API
  void _getUsers() {
    UserApi.fetchUsers().then((result) {
      setState(() {
        userList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"), // Title of the page
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToDetail(0); // Navigate to add new user
        },
        tooltip: "Add new User",
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _userListItems(), // List of user cards
      ),
    );
  }

  // Display user list items as cards
  ListView _userListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(userList[position]
                  .lastname
                  .substring(0, 1)), // Initial of last name
            ),
            title: Text(
                "${userList[position].firstname} ${userList[position].lastname}"), // Display first and last name
            subtitle: Text(userList[position].email), // Display email
            onTap: () {
              _navigateToDetail(
                  userList[position].id); // Navigate to user details
            },
          ),
        );
      },
    );
  }

  // Navigate to user detail page, 0 for new user
  void _navigateToDetail(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailPage(id: id)),
    );

    _getUsers(); // Refresh the user list after returning
  }
}
```
