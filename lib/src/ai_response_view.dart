import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'theme.dart';

class AiResponseView extends StatelessWidget {
  const AiResponseView({
    required this.content,
    this.isStreaming = false,
    this.citations = const [],
    this.toolCalls = const [],
    this.onRetry,
    this.onStop,
    this.onCitationTap,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final String content;
  final bool isStreaming;
  final List<AiCitation> citations;
  final List<AiToolCall> toolCalls;
  final VoidCallback? onRetry;
  final VoidCallback? onStop;
  final ValueChanged<AiCitation>? onCitationTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styling =
        Theme.of(context).extension<AiResponseTheme>() ??
        AiResponseTheme.from(colors);
    return Semantics(
      liveRegion: isStreaming,
      label: 'AI response',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: styling.surfaceColor,
          borderRadius: styling.borderRadius,
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              MarkdownBody(
                data: content.isEmpty && isStreaming ? 'Thinking…' : content,
                selectable: true,
                onTapLink: (_, href, _) {
                  final uri = href == null ? null : Uri.tryParse(href);
                  if (uri != null) launchUrl(uri);
                },
                styleSheet: MarkdownStyleSheet(
                  codeblockDecoration: BoxDecoration(
                    color: styling.codeBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (isStreaming) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(color: styling.accentColor),
              ],
              if (toolCalls.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...toolCalls.map((tool) => _ToolCallTile(tool: tool)),
              ],
              if (citations.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final citation in citations)
                      ActionChip(
                        avatar: const Icon(Icons.link, size: 16),
                        label: Text(citation.label),
                        tooltip:
                            citation.description ?? citation.uri.toString(),
                        onPressed: () => onCitationTap != null
                            ? onCitationTap!(citation)
                            : launchUrl(citation.uri),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: 'Copy response',
                    onPressed: content.isEmpty
                        ? null
                        : () => Clipboard.setData(ClipboardData(text: content)),
                    icon: const Icon(Icons.copy_outlined),
                  ),
                  if (isStreaming && onStop != null)
                    IconButton(
                      tooltip: 'Stop generating',
                      onPressed: onStop,
                      icon: const Icon(Icons.stop_circle_outlined),
                    ),
                  if (!isStreaming && onRetry != null)
                    IconButton(
                      tooltip: 'Try again',
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolCallTile extends StatelessWidget {
  const _ToolCallTile({required this.tool});
  final AiToolCall tool;

  @override
  Widget build(BuildContext context) => ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    leading: switch (tool.status) {
      AiToolCallStatus.waiting => const Icon(Icons.schedule),
      AiToolCallStatus.running => const SizedBox.square(
        dimension: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      AiToolCallStatus.succeeded => const Icon(Icons.check_circle_outline),
      AiToolCallStatus.failed => const Icon(Icons.error_outline),
    },
    title: Text(tool.name),
    subtitle: tool.description == null ? null : Text(tool.description!),
  );
}
