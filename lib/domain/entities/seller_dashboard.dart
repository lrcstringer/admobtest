import 'package:freezed_annotation/freezed_annotation.dart';

part 'seller_dashboard.freezed.dart';

/// Typed value object for seller dashboard analytics.
@freezed
abstract class SellerDashboard with _$SellerDashboard {
  const factory SellerDashboard({
    @Default(0) int totalListings,
    @Default(0) int activeListings,
    @Default(0) int totalOrders,
    @Default(0) int pendingOrders,
    @Default(0) int completedOrders,
    @Default(0.0) double totalRevenue,
    @Default(0.0) double averageRating,
    @Default(0) int totalVouches,
    @Default(0) int totalViews,
  }) = _SellerDashboard;

  factory SellerDashboard.fromMap(Map<String, dynamic> map) {
    return SellerDashboard(
      totalListings: (map['totalListings'] as num?)?.toInt() ?? 0,
      activeListings: (map['activeListings'] as num?)?.toInt() ?? 0,
      totalOrders: (map['totalOrders'] as num?)?.toInt() ?? 0,
      pendingOrders: (map['pendingOrders'] as num?)?.toInt() ?? 0,
      completedOrders: (map['completedOrders'] as num?)?.toInt() ?? 0,
      totalRevenue: (map['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      averageRating: (map['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalVouches: (map['totalVouches'] as num?)?.toInt() ?? 0,
      totalViews: (map['totalViews'] as num?)?.toInt() ?? 0,
    );
  }
}
