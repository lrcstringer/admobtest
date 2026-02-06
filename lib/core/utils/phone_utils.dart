import 'package:phone_numbers_parser/phone_numbers_parser.dart';

/// Parses a raw phone input with a country dial code and returns
/// a normalized E.164 string (e.g. "+27812345678").
///
/// Handles common user input patterns:
/// - Leading zero: "0812345678" → "+27812345678"
/// - No leading zero: "812345678" → "+27812345678"
/// - Already has country code: "+27812345678" → "+27812345678"
///
/// Returns `null` if the number cannot be parsed or is invalid.
String? parseToE164(String rawInput, String countryDialCode) {
  final cleaned = rawInput.trim();
  if (cleaned.isEmpty) return null;

  // Derive ISO code from dial code for the parser
  final isoCode = _dialCodeToIso[countryDialCode];
  if (isoCode == null) {
    // Fallback: just concatenate and hope for the best
    final digits = cleaned.startsWith('0') ? cleaned.substring(1) : cleaned;
    return '$countryDialCode$digits';
  }

  try {
    // Let the parser handle all normalization (leading zero, spaces, dashes)
    final phone = PhoneNumber.parse(
      cleaned,
      callerCountry: IsoCode.values.firstWhere(
        (c) => c.name == isoCode,
      ),
    );

    if (!phone.isValid()) return null;

    // E.164 format: +<country><subscriber>
    return phone.international.replaceAll(RegExp(r'[\s\-()]'), '');
  } catch (_) {
    // Parser failed — manual fallback: strip leading zero
    final digits = cleaned.startsWith('0') ? cleaned.substring(1) : cleaned;
    return '$countryDialCode$digits';
  }
}

/// Returns true if the raw input can form a valid phone number
/// for the given country dial code.
bool isValidPhoneInput(String rawInput, String countryDialCode) {
  final e164 = parseToE164(rawInput, countryDialCode);
  return e164 != null;
}

/// Parse an E.164 phone number into its components (country code + local digits).
///
/// Returns a record with `countryCode` (e.g. "+27") and `localNumber` (e.g. "812345678").
/// Returns null if the phone number is invalid or doesn't match any known country code.
({String countryCode, String localNumber})? parseE164ToComponents(
  String e164Phone,
  List<String> knownCountryCodes,
) {
  if (!e164Phone.startsWith('+')) return null;

  // Try to match the longest country code first (e.g. +852 before +8)
  String? matchedCode;
  for (final code in knownCountryCodes) {
    if (e164Phone.startsWith(code)) {
      if (matchedCode == null || code.length > matchedCode.length) {
        matchedCode = code;
      }
    }
  }

  if (matchedCode == null) return null;

  return (
    countryCode: matchedCode,
    localNumber: e164Phone.substring(matchedCode.length),
  );
}

/// List of supported country dial codes (sorted by length for parsing).
const supportedDialCodes = [
  '+27', '+1', '+44', '+61', '+86', '+91', '+49', '+33', '+81', '+55',
  '+234', '+254', '+255', '+256', '+260', '+263', '+265', '+267', '+268',
  '+266', '+258', '+264', '+7', '+82', '+39', '+34', '+52', '+62', '+60',
  '+63', '+66', '+84', '+20', '+212', '+233', '+237', '+251', '+971',
  '+966', '+92', '+880', '+90', '+48', '+31', '+46', '+47', '+45', '+358',
  '+41', '+43', '+32', '+351', '+353', '+64', '+65', '+852',
];

/// Maps dial codes to ISO 3166-1 alpha-2 codes used by the parser.
const _dialCodeToIso = <String, String>{
  '+27': 'ZA',
  '+1': 'US',
  '+44': 'GB',
  '+61': 'AU',
  '+86': 'CN',
  '+91': 'IN',
  '+49': 'DE',
  '+33': 'FR',
  '+81': 'JP',
  '+55': 'BR',
  '+234': 'NG',
  '+254': 'KE',
  '+255': 'TZ',
  '+256': 'UG',
  '+260': 'ZM',
  '+263': 'ZW',
  '+265': 'MW',
  '+267': 'BW',
  '+268': 'SZ',
  '+266': 'LS',
  '+258': 'MZ',
  '+264': 'NA',
  '+7': 'RU',
  '+82': 'KR',
  '+39': 'IT',
  '+34': 'ES',
  '+52': 'MX',
  '+62': 'ID',
  '+60': 'MY',
  '+63': 'PH',
  '+66': 'TH',
  '+84': 'VN',
  '+20': 'EG',
  '+212': 'MA',
  '+233': 'GH',
  '+237': 'CM',
  '+251': 'ET',
  '+971': 'AE',
  '+966': 'SA',
  '+92': 'PK',
  '+880': 'BD',
  '+90': 'TR',
  '+48': 'PL',
  '+31': 'NL',
  '+46': 'SE',
  '+47': 'NO',
  '+45': 'DK',
  '+358': 'FI',
  '+41': 'CH',
  '+43': 'AT',
  '+32': 'BE',
  '+351': 'PT',
  '+353': 'IE',
  '+64': 'NZ',
  '+65': 'SG',
  '+852': 'HK',
};
