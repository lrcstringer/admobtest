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

/// Deeply converts a map from Cloud Functions responses (which contain
/// `Map<Object?, Object?>` nested maps) to `Map<String, dynamic>`.
/// Also converts serialized Timestamp maps `{_seconds, _nanoseconds}` and
/// Firestore [Timestamp] objects to ISO 8601 strings.
Map<String, dynamic> deepConvertMap(Map<dynamic, dynamic> map) {
  return map.map((key, value) {
    return MapEntry(key.toString(), _deepConvertValue(value));
  });
}

dynamic _deepConvertValue(dynamic value) {
  if (value is Timestamp) {
    return value.toDate().toIso8601String();
  }
  if (value is Map) {
    // Check for serialized Timestamp from Cloud Functions
    if (value.containsKey('_seconds') && value.containsKey('_nanoseconds')) {
      final seconds = value['_seconds'] as int;
      final nanoseconds = value['_nanoseconds'] as int;
      return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + nanoseconds ~/ 1000000,
      ).toIso8601String();
    }
    return deepConvertMap(value);
  }
  if (value is List) {
    return value.map(_deepConvertValue).toList();
  }
  return value;
}

/// Converts all [Timestamp] values in a Firestore document map to ISO 8601
/// strings so that freezed/json_serializable generated `fromJson` code
/// (which expects `DateTime.parse(json['field'] as String)`) works correctly.
///
/// Also recursively converts any untyped [Map] (e.g. `_Map<Object?, Object?>`
/// returned by Cloud Functions) into `Map<String, dynamic>`.
Map<String, dynamic> sanitizeFirestoreData(Map data) {
  return Map<String, dynamic>.from(data).map((key, value) {
    if (value is Timestamp) {
      return MapEntry(key, value.toDate().toIso8601String());
    }
    if (value is Map) {
      return MapEntry(key, sanitizeFirestoreData(value));
    }
    if (value is List) {
      return MapEntry(
        key,
        value.map((e) {
          if (e is Timestamp) return e.toDate().toIso8601String();
          if (e is Map) return sanitizeFirestoreData(e);
          return e;
        }).toList(),
      );
    }
    return MapEntry(key, value);
  });
}
