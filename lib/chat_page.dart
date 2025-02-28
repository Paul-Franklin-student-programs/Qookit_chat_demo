import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '1'); // User (Right Side)
  final _bot = const types.User(id: '2'); // Bot (Left Side)

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    // Generate a random number response after a short delay
    Future.delayed(const Duration(seconds: 2), () {
      _sendBotReply();
    });
  }

  void _sendBotReply() {
    final randomNumber = Random().nextInt(100); // Generate a random number
    final botMessage = types.TextMessage(
      author: _bot,
      id: const Uuid().v4(),
      text: "To make a classic Caesar salad, start by preparing the dressing. "
          "In a bowl, whisk together one minced garlic clove, a teaspoon of Dijon "
          "mustard, two teaspoons of Worcestershire sauce, the juice of one lemon, "
          "and one egg yolk. Slowly drizzle in half a cup of olive oil while whisking "
          "continuously to emulsify. Stir in half a cup of grated Parmesan cheese and "
          "season with salt and pepper to taste.\n\nNext, prepare the croutons by cutting "
          "a few slices of bread into cubes, tossing them with olive oil and a pinch of "
          "salt, then baking them at 375°F (190°C) for about 10 minutes until golden brown. "
          "For the salad, chop a head of fresh romaine lettuce and place it in a large "
          "bowl. Add the homemade croutons and drizzle with the dressing, tossing everything "
          "gently to coat.\n\nFinish by sprinkling more grated Parmesan on top and, if desired, "
          "adding anchovy fillets for an authentic touch. Serve immediately for the best "
          "texture and flavor.",
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Qookit Chat",
              style: TextStyle(
                fontSize: 27,
              )),
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          inputBackgroundColor: Color(0xFFf3f3f3), // Input field background
          inputTextColor: Colors.black, // Input text color
          primaryColor: Color(0xFFf3f3f3), // Send button color
          secondaryColor: Colors.white,

          sentMessageBodyTextStyle: TextStyle(
          color: Colors.black, // Ensures user message text is black
          fontSize: 16,
          )
        ),
        //customMessageBuilder: _customMessageBuilder, // Custom bubble UI
      ),
    );
  }

  /*/// Customizes user and bot messages to match ChatGPT's style
  Widget _customMessageBuilder(types.Message message,
      {required int messageWidth}) {
    final isUserMessage = message.author.id == _user.id;

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: messageWidth * 0.8),
        padding: const EdgeInsets.all(12),
        decoration: isUserMessage
            ? BoxDecoration(
                color: Colors.red, // Light gray bubble for user
                borderRadius: BorderRadius.circular(20),
              )
            : null, // No background for bot messages
        child: Text(
          (message as types.TextMessage).text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }*/
}
