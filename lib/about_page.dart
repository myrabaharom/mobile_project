// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mobile_myra/username.dart';

class PostPageDetail extends StatefulWidget {
  final String title;

  const PostPageDetail({Key? key, this.title = 'Main Post Page'})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PostPageDetail> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('ABOUT PAGE'),
          // floatingActionButton:Theme
        ),
        body: Center(
          child: Card(
            elevation: 50,
            shadowColor: Colors.pink,
            color: Colors.lightBlueAccent[100],
            child: SizedBox(
              width: 300,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/post12.jpg"),
                      radius: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'About this app',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'This app is a post card app when user can view the post, add to favourite, sort the post and create new post using this application.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                ),
            ),
          )
          ),
        );
  }
}


