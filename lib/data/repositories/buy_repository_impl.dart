import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/brand_storefront.dart';
import '../../domain/entities/buy_category.dart';
import '../../domain/entities/buy_regular.dart';
import '../../domain/entities/featured_item.dart';
import '../../domain/repositories/buy_repository.dart';
import '../datasources/local/app_database.dart';
import '../datasources/remote/buy_remote_datasource.dart';

@LazySingleton(as: BuyRepository)
class BuyRepositoryImpl implements BuyRepository {
  final BuyRemoteDataSource _remoteDataSource;
  final AppDatabase _database;

  BuyRepositoryImpl(this._remoteDataSource, this._database);

  // ============ CATEGORIES ============

  @override
  Future<Either<Failure, List<BuyCategory>>> getBuyCategories() async {
    try {
      final models = await _remoteDataSource.getBuyCategories();
      final entities = models.map((m) => m.toEntity()).toList();

      // Cache to local DB
      final now = DateTime.now();
      final companions = models
          .map((m) => LocalBuyCategoriesCompanion(
                id: Value(m.id),
                name: Value(m.name),
                iconEmoji: Value(m.iconEmoji),
                sortOrder: Value(m.sortOrder),
                isActive: Value(m.isActive),
                isComingSoon: Value(m.isComingSoon),
                purchaseCategoryMapping: Value(m.purchaseCategoryMapping),
                featureFlagKey: Value(m.featureFlagKey),
                logoUrl: Value(m.logoUrl),
                backgroundColor: Value(m.backgroundColor),
                syncedAt: Value(now),
              ))
          .toList();
      await _database.upsertBuyCategories(companions);

      return Right(entities);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BuyCategory>>> getCachedCategories() async {
    try {
      final localRows = await _database.getAllBuyCategories();
      final entities = localRows
          .map((row) => BuyCategory(
                id: row.id,
                name: row.name,
                iconEmoji: row.iconEmoji,
                sortOrder: row.sortOrder,
                isActive: row.isActive,
                isComingSoon: row.isComingSoon,
                purchaseCategoryMapping: row.purchaseCategoryMapping,
                featureFlagKey: row.featureFlagKey,
                logoUrl: row.logoUrl,
                backgroundColor: row.backgroundColor,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  // ============ REGULARS ============

  @override
  Future<Either<Failure, List<BuyRegular>>> getBuyRegulars() async {
    try {
      final models = await _remoteDataSource.getBuyRegulars();
      final entities = models.map((m) => m.toEntity()).toList();

      // Cache to local DB
      final now = DateTime.now();
      final companions = models
          .map((m) => LocalBuyRegularsCompanion(
                id: Value(m.id),
                providerId: Value(m.providerId),
                productId: Value(m.productId),
                providerName: Value(m.providerName),
                productName: Value(m.productName),
                recipientNumber: Value(m.recipientNumber),
                recipientLabel: Value(m.recipientLabel),
                isPinned: Value(m.isPinned),
                usageCount: Value(m.usageCount),
                lastUsedAt: Value(m.lastUsedAt),
                categoryEmoji: Value(m.categoryEmoji),
                purchaseCategoryMapping: Value(m.purchaseCategoryMapping),
                syncedAt: Value(now),
              ))
          .toList();
      await _database.upsertBuyRegulars(companions);

      return Right(entities);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BuyRegular>>> getCachedRegulars() async {
    try {
      final localRows = await _database.getBuyRegulars();
      final entities = localRows
          .map((row) => BuyRegular(
                id: row.id,
                providerId: row.providerId,
                productId: row.productId,
                providerName: row.providerName,
                productName: row.productName,
                recipientNumber: row.recipientNumber,
                recipientLabel: row.recipientLabel,
                isPinned: row.isPinned,
                usageCount: row.usageCount,
                lastUsedAt: row.lastUsedAt,
                categoryEmoji: row.categoryEmoji,
                purchaseCategoryMapping: row.purchaseCategoryMapping,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  // ============ FEATURED ITEMS ============

  @override
  Future<Either<Failure, List<FeaturedItem>>> getFeaturedItems() async {
    try {
      final models = await _remoteDataSource.getFeaturedItems();
      final entities = models.map((m) => m.toEntity()).toList();

      // Cache to local DB
      final now = DateTime.now();
      final companions = models
          .map((m) => LocalFeaturedItemsCompanion(
                id: Value(m.id),
                title: Value(m.title),
                subtitle: Value(m.subtitle),
                imageUrl: Value(m.imageUrl),
                type: Value(m.type),
                deepLinkRoute: Value(m.deepLinkRoute),
                isActive: Value(m.isActive),
                sortOrder: Value(m.sortOrder),
                bgGradientType: Value(m.bgGradientType),
                syncedAt: Value(now),
              ))
          .toList();
      await _database.upsertFeaturedItems(companions);

      return Right(entities);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeaturedItem>>> getCachedFeaturedItems() async {
    try {
      final localRows = await _database.getFeaturedItems();
      final entities = localRows
          .map((row) => FeaturedItem(
                id: row.id,
                title: row.title,
                subtitle: row.subtitle,
                imageUrl: row.imageUrl,
                type: row.type,
                deepLinkRoute: row.deepLinkRoute,
                isActive: row.isActive,
                sortOrder: row.sortOrder,
                bgGradientType: row.bgGradientType,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.cacheError(message: e.toString()));
    }
  }

  // ============ BRAND STOREFRONTS ============

  @override
  Future<Either<Failure, List<BrandStorefront>>> getBrandStorefronts() async {
    try {
      final models = await _remoteDataSource.getBrandStorefronts();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BrandStorefront>> getBrandStorefront(
      String id) async {
    try {
      final model = await _remoteDataSource.getBrandStorefront(id);
      if (model == null) {
        return const Left(
            Failure.serverError(message: 'Brand storefront not found'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(Failure.serverError(message: e.toString()));
    }
  }
}
