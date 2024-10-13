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
