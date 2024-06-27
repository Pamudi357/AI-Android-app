import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key, required this.messages}) : super(key: key);

  final List<String> messages;

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter instance;
  final textController = TextEditingController();
  Future<void> getInstance() async {
    instance = await DialogFlowtter.fromFile(
        path: "assets/plannerbot_dialogflow.json",
        sessionId: "any_random_string_will_do");
  }

  @override
  void initState() {
    super.initState();
    getInstance();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  List<Map> messages = [];

  Future<void> getResponse(String message) async {
    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(text: TextInput(text: textController.text)),
    );
    String? textResponse = response.text;

    log(textResponse!);
    setState(() {
      messages.insert(0, {"data": 0, "message": textResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("ChatBot"),
      ),
      backgroundColor: const Color.fromARGB(255, 67, 88, 252),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return buildMessage(
                  message['message'],
                  message['data'],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 98, 197, 255),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String message = textController.text;
                    getResponse(message);
                    setState(() {
                      messages.insert(
                          0, {"data": 1, "message": textController.text});
                    });
                    textController.clear();
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildMessage(String message, int data) {
  // Determine if the message is from the user or the bot based on the data parameter

  final bool isUserMessage = data == 1;

  return Row(
    mainAxisAlignment:
        isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      if (!isUserMessage)
        const CircleAvatar(
          backgroundImage: AssetImage('images/robot.jpg'),
        ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            color: isUserMessage ? Colors.grey[200] : Colors.blue[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      if (isUserMessage)
        const CircleAvatar(
          backgroundImage: AssetImage('images/person.png'),
        ),
    ],
  );
}
