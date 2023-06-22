// ignore_for_file: unused_field

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'message_tile.dart';

final CollectionReference _messagesCollection =
    FirebaseFirestore.instance.collection('group_chat_messages');
final CollectionReference _usersCollection =
    FirebaseFirestore.instance.collection('users');

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  late String _nameSender = '';
  bool _isStreamInitialized = false;
  final TextEditingController _messageController = TextEditingController();
  late Stream<QuerySnapshot> _messagesStream;
  DocumentSnapshot? _userSnapshot;
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    final token = await fcm.getToken();
    print('tokeeeeee  ');
    print(token);
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
    _initializeMessagesStream();
  }

  Future<DocumentSnapshot?> getUserData() async {
    String? user = FirebaseAuth.instance.currentUser!.email;
    if (user != null) {
      QuerySnapshot userQuerySnapshot = await _messagesCollection
          .where('senderEmail', isEqualTo: user)
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDocumentSnapshot = userQuerySnapshot.docs.first;
        return userDocumentSnapshot;
      }
    }
    return null;
  }

  Future<void> _initializeMessagesStream() async {
    _messagesStream = _messagesCollection.orderBy('timestamp').snapshots();
    DocumentSnapshot? userSnapshot = await getUserData();
    if (userSnapshot != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email == userSnapshot['senderEmail']) {
        setState(() {
          _nameSender = userSnapshot['senderName'];
        });
      }
    }
    setState(() {
      _isStreamInitialized = true;
      _userSnapshot = userSnapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 62, 85, 134),
        title: const Text(
          'Group Class',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _isStreamInitialized
                ? StreamBuilder<QuerySnapshot>(
                    stream: _messagesStream,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                final message = snapshot.data?.docs[index];
                                final senderName = message?['senderName'];
                                final isSentByMe = _nameSender == senderName;

                                return GestureDetector(
                                  onTap: () {
                                    _handleMessageTap(senderName);
                                  },
                                  child: MessageTile(
                                    message: message?['message'],
                                    sender: senderName,
                                    sentByMe: isSentByMe,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  )
                : Container(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 62, 85, 134),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _messageController.clear();
                      await sendMessage(message);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(40, 85, 174, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(String message) async {
    String? user = FirebaseAuth.instance.currentUser!.email;
    if (user != null) {
      final timestamp = DateTime.now();

      QuerySnapshot userQuerySnapshot =
          await _usersCollection.where('email', isEqualTo: user).get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        final userDocumentSnapshot = userQuerySnapshot.docs.first;

        String displayName = userDocumentSnapshot.get('name');
        String photoURL = userDocumentSnapshot.get('image');
        setState(() {
          _nameSender = displayName;
        });

        await _messagesCollection.add({
          'senderEmail': user,
          'message': message,
          'timestamp': timestamp,
          'senderName': displayName,
          'senderPhotoURL': photoURL,
        });
      }
    }
  }

  void _handleMessageTap(String? senderName) {}

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
