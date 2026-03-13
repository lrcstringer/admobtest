import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/purchase.dart';
import '../../domain/entities/service_provider.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../datasources/remote/purchase_remote_datasource.dart';

@LazySingleton(as: PurchaseRepository)
class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseRemoteDataSource _remoteDataSource;

  PurchaseRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ServiceProvider>>> getServiceProviders() async {
    try {
      final models = await _remoteDataSource.getServiceProviders();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceProvider>>> getProvidersByCategory(
    PurchaseCategory category,
  ) async {
    try {
      final models =
          await _remoteDataSource.getProvidersByCategory(category.name);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceProvider>> getProviderById(
      String providerId) async {
    try {
      final model = await _remoteDataSource.getProviderById(providerId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceProduct>>> getProducts(
      String providerId) async {
    try {
      final models = await _remoteDataSource.getProducts(providerId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceProduct>> getProductById(
      String productId) async {
    try {
      final model = await _remoteDataSource.getProductById(productId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Purchase>> makePurchase({
    required String productId,
    required String recipientNumber,
    String? subAccountId,
  }) async {
    try {
      final model = await _remoteDataSource.makePurchase(
        productId: productId,
        recipientNumber: recipientNumber,
        subAccountId: subAccountId,
      );
      return Right(model.toEntity());
    } catch (e) {
      if (e.toString().toLowerCase().contains('insufficient')) {
        return const Left(Failure.insufficientBalance());
      }
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Purchase>>> getPurchaseHistory({
    PurchaseCategory? category,
    int? limit,
    DateTime? startAfter,
  }) async {
    try {
      final models = await _remoteDataSource.getPurchaseHistory(
        category: category?.name,
        limit: limit,
        startAfter: startAfter,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Purchase>> getPurchaseById(String purchaseId) async {
    try {
      final model = await _remoteDataSource.getPurchaseById(purchaseId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentRecipients({
    PurchaseCategory? category,
    int? limit,
  }) async {
    try {
      final recipients = await _remoteDataSource.getRecentRecipients(
        category: category?.name,
        limit: limit,
      );
      return Right(recipients);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> validateRecipientNumber({
    required String number,
    required PurchaseCategory category,
  }) async {
    try {
      final isValid = await _remoteDataSource.validateRecipientNumber(
        number: number,
        category: category.name,
      );
      return Right(isValid);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
