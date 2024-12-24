import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/auth/auth_service.dart';
import 'package:frontend/firebase_service.dart';
import 'package:frontend/model/message.dart';
import 'package:frontend/model/person.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.role});

  final role;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Person>> persons;

  @override
  void initState() {
    super.initState();
    persons = ChatService().getUniqueSenders();
  }

  void navToUserChat(BuildContext context, String user, String name) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CurrentChatPage(
                userName: user,
                Name: name,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.role == 'admin'
        ? Scaffold(
            backgroundColor: Colors.amber[200],
            appBar: AppBar(
              title: const Text('Чаты'),
              backgroundColor: Colors.white70,
            ),
            body: Center(
              child: FutureBuilder<List<Person>>(
                future: persons,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Ошибка загрузки сообщений');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final allUsers = snapshot.data!;

                  return ListView.builder(
                      itemCount: allUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 10.0, right: 10.0),
                          child: GestureDetector(
                            onTap: () => navToUserChat(context,
                                allUsers[index].mail, allUsers[index].name),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 246, 218),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.10,
                                      decoration: BoxDecoration(
                                          color: Colors.amber[100],
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                allUsers[index].image),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Text(
                                              allUsers[index].name,
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ))
        : const CurrentChatPage();
  }
}

class CurrentChatPage extends StatefulWidget {
  const CurrentChatPage({super.key, this.userName, this.Name});
  final userName;
  final Name;

  @override
  State<CurrentChatPage> createState() => _CurrentChatPageState();
}

class _CurrentChatPageState extends State<CurrentChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  late Future<List<Message>> messages;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.userName != null ? widget.userName! : 'email@bk.ru',
          _messageController.text);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[200],
        appBar: AppBar(
          title: widget.Name != null
              ? Text(widget.Name!)
              : const Text('Чат с продавцом'),
          backgroundColor: Colors.white70,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('messages').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Ошибка загрузки сообщений');
            }

            return Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                        stream: _chatService.getMessages(
                            AuthService().getCurrentUserEmail()!,
                            widget.userName != null
                                ? widget.userName!
                                : 'email@bk.ru'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Scaffold(
                                backgroundColor: Colors.amber[200],
                                appBar: AppBar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 246, 218),
                                ),
                                body: Center(
                                    child: Text('Error: ${snapshot.error}')));
                          } else if (!snapshot.hasData) {
                            return Scaffold(
                                backgroundColor: Colors.amber[200],
                                appBar: AppBar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 246, 218),
                                ),
                                body: const Center(child: Text('Нет сообщений')));
                          }

                          final List<DocumentSnapshot> document =
                              snapshot.data!.docs;

                          return ListView.builder(
                              itemCount: document.length,
                              itemBuilder: (BuildContext context, int index) {
                                var alignment = (document[index]['senderId'] ==
                                        AuthService().getCurrentUserEmail())
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft;
                                var crossAxisAlignment = (document[index]
                                            ['senderId'] ==
                                        AuthService().getCurrentUserEmail())
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start;
                                var left = (document[index]['senderId'] ==
                                        AuthService().getCurrentUserEmail())
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : 15.0;
                                var right = (document[index]['senderId'] ==
                                        AuthService().getCurrentUserEmail())
                                    ? 15.0
                                    : MediaQuery.of(context).size.width * 0.2;
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: left,
                                        right: right,
                                        top: 5,
                                        bottom: 3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.white,
                                      ),
                                      alignment: alignment,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8.0,
                                            left: 16.0,
                                            right: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              crossAxisAlignment,
                                          children: [
                                            Text(document[index]['senderId']),
                                            Text(document[index]['message'])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        })),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          controller: _messageController,
                          obscureText: false,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  right: 10, left: 10, bottom: 0, top: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 160, 0, 1),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 160, 0, 1),
                                    width: 2),
                              )),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          cursorHeight: 20.0,
                        ),
                      ),
                    )),
                    IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                        ))
                  ],
                )
              ],
            );
          },
        ));
  }
}