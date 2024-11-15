import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/api_controller/api_controller.dart';
import '../../model/dictionary_model/dictionary_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> chatMessages = [];
  TextEditingController controller = TextEditingController();
  bool isLoading = false; // Flag to indicate loading state
  String? errorMessage; // To store error message

  // Function to handle word submission
  void onSubmitWord(String word) async {
    if (word.isEmpty) return;
    // Don't proceed if the input is empty
    setState(() {
      isLoading = true;
      errorMessage = null;
      chatMessages.add({'type': 'user', 'message': word});
      // Add user input to chat
    });

    try {
      // Fetch meaning from API
      DictionaryModel dictionary = await ApiController.fetchMeaning(word);
      String meaning = dictionary.meanings.isNotEmpty
          ? dictionary.meanings[0].definitions[0].definition
          : "No definition found.";

      // Add the response to the chat
      setState(() {
        isLoading = false;
        chatMessages.add({'type': 'response', 'message': meaning});
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load meaning: $error";
      });
    }

    // Clear the input field after submitting the word
    controller.clear();
  }

  // Build the search widget (input field + submit button)
  Widget buildSearchWidget() {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Search word here",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              //icon:Icon(Icons.message),
              icon: Icon(Icons.send),
              onPressed: () {
                onSubmitWord(controller.text); // Trigger search on button press
              },
            ),
          ),
          onSubmitted: (value) =>
              onSubmitWord(value), // Trigger search on "Enter"
        ),
        if (isLoading)
          CircularProgressIndicator(), // Show loading indicator while fetching
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ChatBubble(
              message: errorMessage!,
              isUser: false, // Error messages will be displayed like a response
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
          backgroundColor: Colors.green,
          title: Text(
            "Dicto Chat",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
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
          color: isUser
              ? const Color.fromARGB(255, 25, 134, 29) // Green for user
              : Colors.red, // Red for error or response
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.white, // White text color
          ),
        ),
      ),
    );
  }
}
