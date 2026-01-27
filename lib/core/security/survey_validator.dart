import 'dart:math';

/// Validates survey responses for quality and fraud prevention
class SurveyValidator {
  /// Minimum time expected per question (seconds)
  static const int _minTimePerQuestion = 3;

  /// Maximum time for entire survey (seconds)
  static const int _maxSurveyTime = 1800; // 30 minutes

  /// Minimum entropy score for text responses
  static const double _minEntropyScore = 0.3;

  /// Validate a complete survey submission
  SurveyValidationResult validateSurvey({
    required List<SurveyResponse> responses,
    required int questionCount,
    required Duration completionTime,
    required List<int> responseTimesMs,
  }) {
    final issues = <ValidationIssue>[];

    // 1. Check completion time
    final minExpectedTime =
        Duration(seconds: questionCount * _minTimePerQuestion);
    if (completionTime < minExpectedTime) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooFast,
        severity: IssueSeverity.high,
        message: 'Survey completed too quickly',
        details: {
          'actual': completionTime.inSeconds,
          'expected': minExpectedTime.inSeconds,
        },
      ));
    }

    if (completionTime.inSeconds > _maxSurveyTime) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooSlow,
        severity: IssueSeverity.low,
        message: 'Survey took unusually long',
      ));
    }

    // 2. Check response time patterns
    if (responseTimesMs.length >= 3) {
      final variance = _calculateVariance(responseTimesMs);
      if (variance < 100) {
        // Nearly identical response times = bot behavior
        issues.add(ValidationIssue(
          type: ValidationIssueType.suspiciousTiming,
          severity: IssueSeverity.high,
          message: 'Response times too uniform',
        ));
      }
    }

    // 3. Check for straightlining (same answer for all questions)
    final multipleChoiceResponses = responses
        .where((r) => r.type == ResponseType.multipleChoice)
        .toList();

    if (multipleChoiceResponses.length >= 5) {
      final uniqueAnswers =
          multipleChoiceResponses.map((r) => r.value).toSet().length;

      if (uniqueAnswers == 1) {
        issues.add(ValidationIssue(
          type: ValidationIssueType.straightlining,
          severity: IssueSeverity.medium,
          message: 'All multiple choice answers are the same',
        ));
      }
    }

    // 4. Validate text responses
    for (final response
        in responses.where((r) => r.type == ResponseType.text)) {
      final textIssues = _validateTextResponse(response.value as String);
      issues.addAll(textIssues);
    }

    // 5. Check for duplicate content
    final textResponses = responses
        .where((r) => r.type == ResponseType.text)
        .map((r) => (r.value as String).toLowerCase().trim())
        .toList();

    if (textResponses.length >= 2) {
      final uniqueTexts = textResponses.toSet().length;
      if (uniqueTexts < textResponses.length * 0.5) {
        issues.add(ValidationIssue(
          type: ValidationIssueType.duplicateContent,
          severity: IssueSeverity.medium,
          message: 'Too many duplicate text responses',
        ));
      }
    }

    // Calculate overall quality score
    final qualityScore = _calculateQualityScore(issues);

    return SurveyValidationResult(
      isValid: qualityScore >= 0.6,
      qualityScore: qualityScore,
      issues: issues,
    );
  }

  /// Validate a single text response
  List<ValidationIssue> _validateTextResponse(String text) {
    final issues = <ValidationIssue>[];

    // Check minimum length
    if (text.length < 10) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.tooShort,
        severity: IssueSeverity.low,
        message: 'Text response too short',
      ));
    }

    // Check for gibberish using entropy
    final entropy = _calculateEntropy(text);
    if (entropy < _minEntropyScore && text.length > 20) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.gibberish,
        severity: IssueSeverity.high,
        message: 'Text appears to be gibberish',
      ));
    }

    // Check for keyboard mashing patterns
    if (_isKeyboardMashing(text)) {
      issues.add(ValidationIssue(
        type: ValidationIssueType.gibberish,
        severity: IssueSeverity.high,
        message: 'Text appears to be keyboard mashing',
      ));
    }

    return issues;
  }

  /// Calculate Shannon entropy for a string (normalized 0-1)
  double _calculateEntropy(String text) {
    if (text.isEmpty) return 0;

    final charCounts = <String, int>{};
    for (final char in text.split('')) {
      charCounts[char] = (charCounts[char] ?? 0) + 1;
    }

    double entropy = 0;
    for (final count in charCounts.values) {
      final probability = count / text.length;
      entropy -= probability * (log(probability) / log(2));
    }

    // Normalize to 0-1 range
    final maxEntropy = log(text.length) / log(2);
    if (maxEntropy <= 0) return 0;
    return (entropy / maxEntropy).clamp(0.0, 1.0);
  }

  /// Check for keyboard mashing patterns
  bool _isKeyboardMashing(String text) {
    // Check for common keyboard mashing patterns
    final patterns = [
      RegExp(r'(.)\1{4,}'), // Same character repeated 5+ times
      RegExp(r'asdf', caseSensitive: false),
      RegExp(r'qwer', caseSensitive: false),
      RegExp(r'zxcv', caseSensitive: false),
      RegExp(r'jkl;', caseSensitive: false),
      RegExp(r'hjkl', caseSensitive: false),
      RegExp(r'1234', caseSensitive: false),
      RegExp(r'abcd', caseSensitive: false),
    ];

    return patterns.any((p) => p.hasMatch(text));
  }

  /// Calculate variance of a list of integers
  double _calculateVariance(List<int> values) {
    if (values.isEmpty) return 0;
    final mean = values.reduce((a, b) => a + b) / values.length;
    final squaredDiffs = values.map((v) => pow(v - mean, 2));
    return squaredDiffs.reduce((a, b) => a + b) / values.length;
  }

  /// Calculate overall quality score based on issues
  double _calculateQualityScore(List<ValidationIssue> issues) {
    double score = 1.0;

    for (final issue in issues) {
      switch (issue.severity) {
        case IssueSeverity.high:
          score -= 0.3;
          break;
        case IssueSeverity.medium:
          score -= 0.15;
          break;
        case IssueSeverity.low:
          score -= 0.05;
          break;
      }
    }

    return score.clamp(0.0, 1.0);
  }

  /// Quick check if a single response looks valid
  bool isResponseValid(SurveyResponse response) {
    switch (response.type) {
      case ResponseType.text:
        final text = response.value as String;
        if (text.length < 3) return false;
        if (_isKeyboardMashing(text)) return false;
        return true;
      case ResponseType.multipleChoice:
        return response.value != null;
      case ResponseType.rating:
        final rating = response.value as int?;
        return rating != null && rating >= 1 && rating <= 5;
      case ResponseType.scale:
        final scale = response.value as int?;
        return scale != null && scale >= 0 && scale <= 10;
    }
  }
}

/// Represents a single survey response
class SurveyResponse {
  final String questionId;
  final ResponseType type;
  final dynamic value;
  final int responseTimeMs;

  SurveyResponse({
    required this.questionId,
    required this.type,
    required this.value,
    required this.responseTimeMs,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'type': type.name,
        'value': value,
        'responseTimeMs': responseTimeMs,
      };
}

/// Types of survey responses
enum ResponseType {
  multipleChoice,
  text,
  rating,
  scale,
}

/// Result of survey validation
class SurveyValidationResult {
  final bool isValid;
  final double qualityScore;
  final List<ValidationIssue> issues;

  SurveyValidationResult({
    required this.isValid,
    required this.qualityScore,
    required this.issues,
  });

  Map<String, dynamic> toJson() => {
        'isValid': isValid,
        'qualityScore': qualityScore,
        'issues': issues.map((i) => i.toJson()).toList(),
      };
}

/// Represents a validation issue found
class ValidationIssue {
  final ValidationIssueType type;
  final IssueSeverity severity;
  final String message;
  final Map<String, dynamic>? details;

  ValidationIssue({
    required this.type,
    required this.severity,
    required this.message,
    this.details,
  });

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'severity': severity.name,
        'message': message,
        'details': details,
      };
}

/// Types of validation issues
enum ValidationIssueType {
  tooFast,
  tooSlow,
  suspiciousTiming,
  straightlining,
  duplicateContent,
  gibberish,
  tooShort,
}

/// Severity levels for issues
enum IssueSeverity {
  low,
  medium,
  high,
}
