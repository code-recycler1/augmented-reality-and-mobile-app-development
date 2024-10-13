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
