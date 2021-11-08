
// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_new

import 'dart:convert';
import 'package:mobile_myra/about_page.dart';
import 'package:mobile_myra/post_page.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  late WebSocketChannel channel;


  late TextEditingController nameController;
  List<String> userList = [];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
    nameController = TextEditingController();
    // channel.stream.listen((data) => setState(() => userList.add(data)));
  }

  void sendData() {
    channel.sink.add('{"type": "sign_in","data": {"name": "$nameController"}}');
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      final signinResponse = decodedMessage['data']['response'];
      if (signinResponse == "OK") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PostPage(title: '', imageUrl: '', description: '',)),
        );
      } else {
        const Text("Try again");
      }
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
          title: const Text('Login Page'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'POST-IT APP',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w500,
                          fontSize: 40),
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: new Image.asset('assets/postcard.png'),
                    alignment: Alignment.center,
                    ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    textAlign: TextAlign.justify,
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Input your username',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: const Text('Login'),
                      onPressed: () {
                        nameController.clear();
                        sendData();
                        print(nameController.text);
                      },
                    ),
                    ),

                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton(
                      child: const Text('About Page'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostPageDetail()));
                      },
                    ),
                    ),

              ],
            )
            )
            );
  }
}

