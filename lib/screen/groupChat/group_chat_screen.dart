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
  late Stream<QuerySnapshot> _messagesStream;
  bool _isStreamInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMessagesStream();
  }

  Future<void> _initializeMessagesStream() async {
    _messagesStream = _messagesCollection.orderBy('timestamp').snapshots();
    setState(() {
      _isStreamInitialized = true;
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
                      if (snapshot.hasData) {
                        final messages = snapshot.data!.docs.reversed.toList();

                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];

                            final content = message['message'];
                            final currentUser =
                                FirebaseAuth.instance.currentUser;

                            final isSentByMe = currentUser != null;
                            print('$content');

                            return FutureBuilder<DocumentSnapshot>(
                              builder: (context, userSnapshot) {
                                print('hasData: ${userSnapshot.hasData}');
                                print('data: ${userSnapshot.data}');
                                if (userSnapshot.hasData &&
                                    userSnapshot.data != null) {
                                  final user = userSnapshot.data!;

                                  final displayName = user['senderName'];
                                  final photoURL = user['senderPhotoURL'];
                                  print('displayName');
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (!isSentByMe)
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(photoURL),
                                          ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: isSentByMe
                                                  ? Colors.grey[300]
                                                  : Colors.blue[300],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (!isSentByMe)
                                                  Text(
                                                    '$displayName',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '$content',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (isSentByMe)
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(photoURL),
                                          ),
                                      ],
                                    ),
                                  );
                                } else {
                                  print('not data');
                                }
                                return const SizedBox(
                                  child: Text('data11'),
                                );
                              },
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const SizedBox(
                          child: Text('data'),
                        );
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
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

        await _messagesCollection.add({
          'message': message,
          'timestamp': timestamp,
          'senderName': displayName,
          'senderPhotoURL': photoURL,
        });
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
