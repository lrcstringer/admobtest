import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// JSON converter for Firestore Timestamp to DateTime
class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.parse(json);
    }
    if (json is DateTime) {
      return json;
    }
    throw ArgumentError('Cannot convert $json to DateTime');
  }

  @override
  dynamic toJson(DateTime date) => date.toIso8601String();
}

/// JSON converter for nullable Firestore Timestamp to DateTime
class NullableTimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.parse(json);
    }
    if (json is DateTime) {
      return json;
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date?.toIso8601String();
}

/// Converts all [Timestamp] values in a Firestore document map to ISO 8601
/// strings so that freezed/json_serializable generated `fromJson` code
/// (which expects `DateTime.parse(json['field'] as String)`) works correctly.
Map<String, dynamic> sanitizeFirestoreData(Map<String, dynamic> data) {
  return data.map((key, value) {
    if (value is Timestamp) {
      return MapEntry(key, value.toDate().toIso8601String());
    }
    if (value is Map<String, dynamic>) {
      return MapEntry(key, sanitizeFirestoreData(value));
    }
    if (value is List) {
      return MapEntry(
        key,
        value.map((e) {
          if (e is Timestamp) return e.toDate().toIso8601String();
          if (e is Map<String, dynamic>) return sanitizeFirestoreData(e);
          return e;
        }).toList(),
      );
    }
    return MapEntry(key, value);
  });
}
