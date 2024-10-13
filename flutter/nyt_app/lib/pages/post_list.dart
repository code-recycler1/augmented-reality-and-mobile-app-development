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
