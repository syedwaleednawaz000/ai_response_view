import 'package:flutter/foundation.dart';

@immutable
final class AiCitation {
  const AiCitation({required this.label, required this.uri, this.description});
  final String label;
  final Uri uri;
  final String? description;
}

enum AiToolCallStatus { waiting, running, succeeded, failed }

@immutable
final class AiToolCall {
  const AiToolCall({
    required this.name,
    required this.status,
    this.description,
  });
  final String name;
  final AiToolCallStatus status;
  final String? description;
}
