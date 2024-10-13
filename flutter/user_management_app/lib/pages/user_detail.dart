import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/user_api.dart';

const List<String> choices = <String>[
  'Save User & Back',
  'Delete User',
  'Back to List'
];

class UserDetailPage extends StatefulWidget {
  final int id;

  const UserDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  User? user;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id == 0) {
      user = User(id: 0, firstname: "", lastname: "", email: "");
    } else {
      _getUser(widget.id);
    }
  }

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
            onSelected: _menuSelected,
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
        child: _userDetails(),
      ),
    );
  }

  _userDetails() {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

      firstnameController.text = user!.firstname;
      lastnameController.text = user!.lastname;
      emailController.text = user!.email;

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
            Container(
              height: 15,
            ),
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
            Container(
              height: 15,
            ),
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

  void _deleteUser() {
    UserApi.deleteUser(widget.id).then((result) {
      Navigator.pop(context, true);
    });
  }
}
