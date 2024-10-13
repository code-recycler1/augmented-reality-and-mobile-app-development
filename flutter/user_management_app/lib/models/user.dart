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
