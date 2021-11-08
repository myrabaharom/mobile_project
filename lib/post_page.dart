// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, unused_import, unused_element
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_myra/create_post.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PostPage extends StatefulWidget {
  final String title, description, imageUrl;

  const PostPage(
      {Key? key, required this.channel,
      required this.title,
      required this.description,
      required this.imageUrl})
      : super(key: key);
      final WebSocketChannel channel;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PostPage> {
  //fetch API
  final fetchAPI =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late List post;
  late List savedPost;

  late String title, description, imageUrl;
  var child;
  var onPressed;

  void _getPostResponse() {
    fetchAPI.stream.listen((message) {
      final decodeMessage = jsonDecode(message);
      if (decodeMessage['type'] == 'all_posts') {
        post = decodeMessage['data']['posts'];
      }

      setState(() {});
      print(decodeMessage);
    });
    _getPostResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(widget.title),
        // floatingActionButton:Theme
      ),
      body: Card(
        elevation: 4.0,
        child: Column(
          children: [
            SizedBox(
              height: 300.0,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  TextButton(
                    child: const Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  TextButton(child: const Icon(Icons.delete), onPressed: () {}),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.description,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            FloatingActionButton(
              heroTag: FloatingActionButtonLocation.endFloat,
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreatePost()));
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

//   Container(
//     padding: const EdgeInsets.all(10.0),
//     alignment: Alignment.center,
//     child: Text(widget.title),
//   ),
//   Container(
//     padding: const EdgeInsets.all(10.0),
//     alignment: Alignment.center,
//     child: Text(widget.description),
//   ),
//  Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: <Widget>[
//   FavoriteButton(
//       iconSize: 50,
//       isFavorite: false,
//       valueChanged: (_isFavourite) {
//         print('Is Favourite: $_isFavourite');
//       }),
//   IconButton(
//     icon: const Icon(Icons.delete),
//     iconSize: 35,
//     color: Colors.grey,
//     onPressed: () {},
//   ),
