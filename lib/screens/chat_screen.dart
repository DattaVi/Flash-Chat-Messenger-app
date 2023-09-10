import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var mtc = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  var message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ));
                  }
                  final messages = snapshot.data?.docs ?? [].reversed;
                  List<messagebubble> messagebubbles = [];
                  for (var message in messages) {
                    final messageData =
                        message.data() as Map<String, dynamic>; // Cast to a map
                    final mtext = messageData['text'] as String?;
                    final ms = messageData['sender'] as String?;
                    final mw =
                        messagebubble(mtext, ms, loggedInUser.email == ms);
                    messagebubbles.add(mw);
                  }
                  return Expanded(
                      child: ListView(
                    reverse: true,
                    children: messagebubbles,
                  ));
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      controller: mtc,
                      onChanged: (value) {
                        //Do something with the user input.

                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      mtc.clear();
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagebubble extends StatelessWidget {
  messagebubble(this.text, this.sender, this.isme);

  var sender;
  var text;
  var isme;
  var color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0)),
            elevation: 5.0,
            color: isme ? Colors.lightBlueAccent : Colors.white70,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Text(
                text,
                style: TextStyle(
                    color: isme ? Colors.white : Colors.black54,
                    fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
