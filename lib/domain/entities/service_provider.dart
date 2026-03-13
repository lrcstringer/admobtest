import 'package:freezed_annotation/freezed_annotation.dart';
import 'purchase.dart';

part 'service_provider.freezed.dart';

/// Service provider entity for Buy Services
@freezed
class ServiceProvider with _$ServiceProvider {
  const factory ServiceProvider({
    required String id,
    required String name,
    required String code,
    required PurchaseCategory category,
    String? logoUrl,
    String? description,
    required bool isActive,
    @Default(false) bool isDeleted,
    required List<ServiceProduct> products,
    int? sortOrder,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ServiceProvider;

  const ServiceProvider._();


  /// Get active products only
  List<ServiceProduct> get activeProducts =>
      products.where((p) => p.isActive).toList();

  /// Get initials for avatar
  String get initials {
    if (name.isEmpty) return '??';
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }
}

/// Service product (airtime bundle, data package, etc.)
@freezed
class ServiceProduct with _$ServiceProduct {
  const factory ServiceProduct({
    required String id,
    required String providerId,
    required String name,
    required String code,
    required int priceTokens,
    required double priceZar,
    String? description,
    String? validity,
    required bool isActive,
    @Default(false) bool isDeleted,
    int? sortOrder,
    Map<String, dynamic>? metadata,
  }) = _ServiceProduct;

  const ServiceProduct._();


  /// Get formatted ZAR price
  String get formattedPrice => 'R${priceZar.toStringAsFixed(2)}';

  /// Get formatted token price
  String get formattedTokenPrice => '$priceTokens tokens';
}
