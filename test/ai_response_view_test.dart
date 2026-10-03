import 'package:ai_response_view/ai_response_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

void main() {
  testWidgets('renders markdown, citations, tools and actions', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AiResponseView(
            content: '**Hello** from AI',
            citations: [
              AiCitation(label: 'Docs', uri: Uri.parse('https://example.com')),
            ],
            toolCalls: const [
              AiToolCall(name: 'Search', status: AiToolCallStatus.succeeded),
            ],
            onRetry: () => retried = true,
          ),
        ),
      ),
    );
    expect(
      tester.widget<MarkdownBody>(find.byType(MarkdownBody)).data,
      '**Hello** from AI',
    );
    expect(find.text('Docs'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    await tester.tap(find.byTooltip('Try again'));
    expect(retried, isTrue);
  });

  testWidgets('shows streaming progress and stop action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AiResponseView(content: '', isStreaming: true, onStop: () {}),
        ),
      ),
    );
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byTooltip('Stop generating'), findsOneWidget);
  });
}
