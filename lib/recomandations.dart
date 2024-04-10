import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Recommendations extends StatefulWidget {
  final apiKey;

  const Recommendations({required this.apiKey, Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  String? generatedText; // Make generatedText nullable

  @override
  void initState() {
    super.initState();
    _generateContent();
  }

  Future<void> _generateContent() async {
    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: widget.apiKey);
      final content = [Content.text('Write a story about a magic backpack.')];
      final response = await model.generateContent(content);
      setState(() {
        generatedText = response.text; // Store generated text in state
      });
      print(response.text); // Print generated text to console
    } catch (e) {
      // Handle error during content generation
      print('Error generating content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Recommendations'),
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: generatedText != null
                ? Text(
              generatedText!,
              style: TextStyle(color: Colors.white),
            )
                : CircularProgressIndicator(), // Show loading indicator while generating
          ),
        ),
      ),
    );
  }
}
