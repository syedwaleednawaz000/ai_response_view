# ai_response_view

An accessible, backend-neutral Flutter widget for presenting modern AI responses. Render streaming Markdown, citations, tool activity, and common response actions with one composable widget.

## Features

- Selectable Markdown with styled code blocks
- Streaming progress and accessible live-region announcements
- Citation chips with customizable navigation
- Waiting, running, success, and failure states for tool calls
- Copy, stop, and retry actions
- Material 3 styling with a `ThemeExtension`

## Installation

```yaml
dependencies:
  ai_response_view: ^0.1.0
```

## Quick start

```dart
AiResponseView(
  content: 'Flutter uses a **reactive widget tree**.',
  citations: [
    AiCitation(
      label: 'Flutter docs',
      uri: Uri.parse('https://docs.flutter.dev'),
    ),
  ],
  toolCalls: const [
    AiToolCall(
      name: 'Search documentation',
      status: AiToolCallStatus.succeeded,
    ),
  ],
  onRetry: regenerate,
)
```

During generation, update `content` as chunks arrive, set `isStreaming: true`, and provide `onStop`.

## Theming

Add `AiResponseTheme` to `ThemeData.extensions`, or let the widget derive Material 3 defaults from the active `ColorScheme`.

## Accessibility and links

Streaming content is exposed as a semantic live region. Links and citations use `url_launcher` by default; provide `onCitationTap` to handle navigation yourself.

## License

MIT © 2026 [Syed Waleed Nawaz](https://syedwaleednawaz.com)
