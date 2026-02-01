import 'package:cloud_firestore/cloud_firestore.dart';

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
