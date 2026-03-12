/// Status of a Gooi-Gooi debt record.
enum GooiDebtStatus { outstanding, recovered, writtenOff }

extension GooiDebtStatusX on GooiDebtStatus {
  String get displayName {
    switch (this) {
      case GooiDebtStatus.outstanding:
        return 'Outstanding';
      case GooiDebtStatus.recovered:
        return 'Recovered';
      case GooiDebtStatus.writtenOff:
        return 'Written Off';
    }
  }

  static GooiDebtStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'OUTSTANDING':
        return GooiDebtStatus.outstanding;
      case 'RECOVERED':
        return GooiDebtStatus.recovered;
      case 'WRITTEN_OFF':
        return GooiDebtStatus.writtenOff;
      default:
        return GooiDebtStatus.outstanding;
    }
  }
}
