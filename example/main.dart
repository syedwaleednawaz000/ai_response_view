import 'package:ai_response_view/ai_response_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(colorSchemeSeed: Colors.indigo),
    home: Scaffold(
      appBar: AppBar(title: const Text('AI Response View')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AiResponseView(
          content: '## A streamed answer\n\nUse `AiResponseView` with any AI backend.',
          citations: [
            AiCitation(label: 'Flutter', uri: Uri.parse('https://flutter.dev')),
          ],
          toolCalls: const [
            AiToolCall(name: 'Search docs', status: AiToolCallStatus.succeeded),
          ],
          onRetry: _noop,
        ),
      ),
    ),
  );
}

void _noop() {}
