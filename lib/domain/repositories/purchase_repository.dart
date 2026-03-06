import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/purchase.dart';
import '../entities/service_provider.dart';

/// Purchase repository interface (Buy Services)
abstract class PurchaseRepository {
  /// Get all service providers
  Future<Either<Failure, List<ServiceProvider>>> getServiceProviders();

  /// Get providers by category
  Future<Either<Failure, List<ServiceProvider>>> getProvidersByCategory(
    PurchaseCategory category,
  );

  /// Get provider by ID
  Future<Either<Failure, ServiceProvider>> getProviderById(String providerId);

  /// Get products for provider
  Future<Either<Failure, List<ServiceProduct>>> getProducts(String providerId);

  /// Get product by ID
  Future<Either<Failure, ServiceProduct>> getProductById(String productId);

  /// Make a purchase
  Future<Either<Failure, Purchase>> makePurchase({
    required String productId,
    required String recipientNumber,
    String? subAccountId,
  });

  /// Get purchase history
  Future<Either<Failure, List<Purchase>>> getPurchaseHistory({
    PurchaseCategory? category,
    int? limit,
    DateTime? startAfter,
  });

  /// Get purchase by ID
  Future<Either<Failure, Purchase>> getPurchaseById(String purchaseId);

  /// Get recent recipients (for quick repurchase)
  Future<Either<Failure, List<String>>> getRecentRecipients({
    PurchaseCategory? category,
    int? limit,
  });

  /// Validate recipient number
  Future<Either<Failure, bool>> validateRecipientNumber({
    required String number,
    required PurchaseCategory category,
  });
}
