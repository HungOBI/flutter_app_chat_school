import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final TextEditingController _messageController = TextEditingController();

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
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesCollection.orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final senderUid = message['uid'];
                      final content = message['message'];
                      final currentUser = FirebaseAuth.instance.currentUser;

                      return FutureBuilder<DocumentSnapshot>(
                        future: _usersCollection.doc(senderUid).get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.hasData) {
                            final user = userSnapshot.data!.data()
                                as Map<String, dynamic>;
                            final displayName = user['displayName'];
                            final photoURL = user['photoURL'];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (currentUser != null &&
                                      currentUser.uid != senderUid)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(photoURL),
                                    ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: currentUser != null &&
                                                currentUser.uid == senderUid
                                            ? Colors.grey[300]
                                            : Colors.blue[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (currentUser != null &&
                                              currentUser.uid != senderUid)
                                            Text(
                                              displayName ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          const SizedBox(height: 4),
                                          Text(
                                            content ?? '',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (currentUser != null &&
                                      currentUser.uid == senderUid)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(photoURL),
                                    ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Container(
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
                  onTap: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                      _messageController.clear();
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final timestamp = DateTime.now();

      await _messagesCollection.add({
        'uid': uid,
        'message': message,
        'timestamp': timestamp,
      });
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String email) async {
    final querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();
    final user = querySnapshot.docs.first.data() as Map<String, dynamic>;
    return user;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
