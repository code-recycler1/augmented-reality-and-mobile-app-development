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
