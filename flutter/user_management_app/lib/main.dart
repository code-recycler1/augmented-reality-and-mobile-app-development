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
