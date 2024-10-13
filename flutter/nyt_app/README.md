# New York Times App

New York Times App is a **Flutter 3.9.16** application that fetches and displays news articles from The New York Times API. Users can select articles based on their interests and read the full articles on The New York Times website.

### Prerequisites

- **Flutter 3.9.16**
- Dart

## Features

- Display a list of news articles from various sections
- View article details
- Read the full article in a WebView

## Project Structure

The project structure is organized as follows:

```text
lib/
├── main.dart
|── apis/
│    └── nyt_api.dart
|── models/
│    └── post.dart
├── pages/
│    ├── post_detail.dart
│    └── post_list.dart
└── widgets/
     └── post_tile.dart
```

- `main.dart`: Entry point of the application.
- `apis/nyt_api.dart`: Handles API interactions with The New York Times API.
- `models/post.dart`: Defines the Post model.
- `pages/post_list.dart`: Displays the list of posts.
- `pages/post_detail.dart`: Displays the full article in a WebView.
- `widgets/post_tile.dart`: Widget representing a single post tile.

## API Endpoints
The app interacts with the following API endpoints:

- `GET /svc/topstories/v2/{section}.json`: Fetch posts from a specific section.

## Dependencies
- `http`: For making HTTP requests.
- `webview_flutter`: For displaying articles in a WebView.
- `flutter/material.dart`: For building the UI.

# Code Overview

### main.dart

```dart
import 'package:flutter/material.dart';
import 'pages/post_list.dart';

// Entry point of the application
void main() async {
  runApp(const MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      title: 'NewYorkTimesApp', // App title
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blueGrey), // Theme color
      ),
      home: const PostListPage(), // Main page displaying a list of posts
    );
  }
}
```

### nyt_api.dart

```dart
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
```

### post.dart

```dart
// Model class representing a Post
class Post {
  final String title; // Post title
  final String url; // URL to the full article
  final String imageUrl; // URL to the post's image
  final String abstract; // Post description or summary

  // Constructor for initializing Post attributes
  Post({
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.abstract,
  });

  // Factory constructor to create a Post object from a JSON response
  factory Post.fromJson(Map<String, dynamic> json) {
    String imageUrl;
    List multimedia = json['multimedia'] as List;

    // If there's no multimedia, provide a placeholder image
    if (multimedia.isEmpty) {
      imageUrl = 'https://picsum.photos/300/200'; // Placeholder image
    } else {
      // Find the "Super Jumbo" format image and use its URL
      imageUrl = multimedia
          .firstWhere((media) => media['format'] == "Super Jumbo")['url'];
    }

    // Return a new Post object populated from the JSON data
    return Post(
      title: json['title'],
      url: json['url'],
      imageUrl: imageUrl,
      abstract: json['abstract'],
    );
  }
}
```

### post_detail.dart

```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// A page to display the full post in a WebView
class PostDetailPage extends StatefulWidget {
  final String url; // URL of the article to be displayed

  const PostDetailPage({Key? key, required this.url}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article"), // App bar title
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      // WebView to display the article using the URL
      body: WebView(
        initialUrl: widget.url,
        javascriptMode:
            JavascriptMode.unrestricted, // Allow unrestricted JavaScript
      ),
    );
  }
}
```

### post_list.dart

```dart
import 'package:flutter/material.dart';
import '../apis/nyt_api.dart';
import '../models/post.dart';
import '../widgets/post_tile.dart';
import 'post_detail.dart';

// List of available sections from the New York Times
List<String> sections = [
  "home",
  "arts",
  "automobiles",
  "books",
  "business",
  "fashion",
  "food",
  "health",
  "insider",
  "magazine",
  "movies",
  "national",
  "nyregion",
  "obituaries",
  "opinion",
  "politics",
  "realestate",
  "science",
  "sports",
  "sundayreview",
  "technology",
  "theater",
  "tmagazine",
  "travel",
  "upshot",
  "world"
];

// The page displaying the list of posts
class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<Post> postList = []; // List of posts
  String section = 'home'; // Default section
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch posts on page load
  }

  // Fetch posts from the API
  Future<void> _fetchPosts() async {
    try {
      List<Post> posts = await NytApi.fetchPosts(section);
      setState(() {
        postList = posts; // Update the list of posts
        isLoading = false; // Stop loading once posts are fetched
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      // Handle error
      print('Failed to load posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The New York Times"), // App bar title
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            _sectionsDropDown(), // Dropdown to select section
            Expanded(
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loader while posts are loading
                  : _postListItems(), // Show the list of posts
            ),
          ],
        ),
      ),
    );
  }

  // Build list of post items
  ListView _postListItems() {
    return ListView.builder(
      itemCount: postList.length, // Number of posts
      itemBuilder: (context, position) {
        return PostTile(
          title: postList[position].title,
          imageUrl: postList[position].imageUrl,
          abstract: postList[position].abstract,
          onTapped: () {
            // Navigate to post details page when a post is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PostDetailPage(url: postList[position].url),
              ),
            );
          },
        );
      },
    );
  }

  // Dropdown to select a section of posts
  DropdownButton _sectionsDropDown() {
    return DropdownButton<String>(
      isExpanded: true,
      items: sections.map((String section) {
        return DropdownMenuItem<String>(
          value: section,
          child: Text(
            section, // Section name
            style: const TextStyle(color: Colors.black87, fontSize: 20),
          ),
        );
      }).toList(),
      value: section, // Currently selected section
      onChanged: (value) {
        setState(() {
          section = value!; // Update section
          isLoading = true; // Set loading state
          _fetchPosts(); // Fetch posts for the new section
        });
      },
    );
  }
}
```

### post_tile.dart

```dart
import 'package:flutter/material.dart';

// Type definition for the callback function when a post is tapped
typedef MyCallback = void Function();

// Widget representing a single post tile
class PostTile extends StatelessWidget {
  final String title, imageUrl, abstract; // Post details
  final MyCallback onTapped; // Callback function for tap events

  const PostTile({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.abstract,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped(); // Execute the callback when the tile is tapped
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Rounded corners for the image
            child: Image.network(
              imageUrl, // Display the post image
              height: 200,
              width: MediaQuery.of(context).size.width, // Use full width
              fit: BoxFit.cover, // Cover the available space
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title, // Display post title
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            abstract, // Display post abstract
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
```