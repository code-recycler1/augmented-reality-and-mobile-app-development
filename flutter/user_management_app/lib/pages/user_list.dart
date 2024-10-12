import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/user_api.dart';
import 'user_detail.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserListPageState();
}

class _UserListPageState extends State {
  List<User> userList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

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
        title: const Text("Users"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToDetail(0);
        },
        tooltip: "Add new User",
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _userListItems(),
      ),
    );
  }

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
              child: Text(userList[position].lastname.substring(0, 1)),
            ),
            title: Text(
                "${userList[position].firstname} ${userList[position].lastname}"),
            subtitle: Text(userList[position].email),
            onTap: () {
              _navigateToDetail(userList[position].id);
            },
          ),
        );
      },
    );
  }

  void _navigateToDetail(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailPage(id: id)),
    );

    _getUsers();
  }
}
