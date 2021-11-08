// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_new, unused_local_variable

import 'dart:convert';
// import 'package:mobile_myra/post_page.dart';
import 'package:mobile_myra/post_page.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {

 

  const CreatePost({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CreatePost> {
  late WebSocketChannel channel;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController imageUrlController;
  List<String> userList = [];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
    
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    imageUrlController = TextEditingController();

    // channel.stream.listen((data) => setState(() => userList.add(data)));
  }

  void sendData() {
    channel.sink.add(
        '{"type": "create_post","data": {"title": "$titleController", "description": "$descriptionController", "imageUrl" = "$imageUrlController"}}');
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      final signinResponse = decodedMessage['data']['response'];
      // if (signinResponse == "OK") {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const PostPage()),
      //   );
      // } else {
      //   const Text("Try again");
      // }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Create Your Post',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w400,
                          fontSize: 36),
                    )),

                //input title
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Input title here.....',
                    ),
                  ),
                ),

                //input the description
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    maxLines: 3,
                    maxLength: 10000,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Input description here....',
                    ),
                  ),
                ),

                //input the image url
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: imageUrlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Input image url here....',
                    ),
                  ),
                ),

                //button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pink,
                          child: const Text('Create Post'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PostPage(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      imageUrl: imageUrlController.text,
                                    )));
                          },
                        )),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pink,
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context, false),
                        )),
                  ],
                )
              ],
            )));
  }
}
