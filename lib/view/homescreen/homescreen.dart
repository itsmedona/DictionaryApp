import 'package:flutter/material.dart';
import '../../controller/api_controller/api_controller.dart';
import '../../model/dictionary_model/dictionary_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> chatMessages = [];
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false; // Flag to indicate loading state
  String? _errorMessage; // To store error message

  // Function to handle word submission
  void onSubmitWord(String word) async {
    if (word.isEmpty) return; // Don't proceed if the input is empty

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      chatMessages
          .add({'type': 'user', 'message': word}); // Add user input to chat
    });

    try {
      // Fetch meaning from API
      DictionaryModel dictionary = await ApiController.fetchMeaning(word);
      String meaning = dictionary.meanings.isNotEmpty
          ? dictionary.meanings[0].definitions[0].definition
          : "No definition found.";

      // Add the response to the chat
      setState(() {
        _isLoading = false;
        chatMessages.add({'type': 'response', 'message': meaning});
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Failed to load meaning: $error";
      });
    }

    // Clear the input field after submitting the word
    _controller.clear();
  }

  // Build the search widget (input field + submit button)
  Widget buildSearchWidget() {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search word here",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                onSubmitWord(
                    _controller.text); // Trigger search on button press
              },
            ),
          ),
          onSubmitted: (value) =>
              onSubmitWord(value), // Trigger search on "Enter"
        ),
        if (_isLoading)
          CircularProgressIndicator(), // Show loading indicator while fetching
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dicto Chat"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: chatMessages[index]['message']!,
                      isUser: chatMessages[index]['type'] == 'user',
                    );
                  },
                ),
              ),
              buildSearchWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to display chat bubbles
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
