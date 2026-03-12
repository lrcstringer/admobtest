import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

/// Analytics service for Buy tab events (Spec §12.7).
///
/// All methods are fire-and-forget (void, not Future<void>) so analytics
/// failures never block UX. All events prefixed `buy_`, snake_case params.
@lazySingleton
class BuyAnalyticsService {
  final FirebaseAnalytics _analytics;

  BuyAnalyticsService(this._analytics);

  // ─── Hub & Navigation ──────────────────────────────

  void trackBuyTabOpened() {
    _log('buy_tab_opened');
  }

  void trackCategoryTapped({
    required String categoryId,
    required String categoryName,
  }) {
    _log('buy_category_tapped', {
      'category_id': categoryId,
      'category_name': categoryName,
    });
  }

  void trackBrandPartnerTapped({
    required String brandId,
    required String brandName,
  }) {
    _log('buy_brand_partner_tapped', {
      'brand_id': brandId,
      'brand_name': brandName,
    });
  }

  void trackFeaturedItemTapped({
    required String itemId,
    required String itemType,
  }) {
    _log('buy_featured_item_tapped', {
      'item_id': itemId,
      'item_type': itemType,
    });
  }

  void trackMarketplaceOpened() {
    _log('buy_marketplace_opened');
  }

  void trackGroupBuysOpened() {
    _log('buy_group_buys_opened');
  }

  void trackPurchaseHistoryOpened() {
    _log('buy_purchase_history_opened');
  }

  // ─── Purchase Funnel ────────────────────────────────

  void trackPurchaseStarted({
    required String categoryId,
    required String providerId,
    required int amountTokens,
  }) {
    _log('buy_purchase_started', {
      'category_id': categoryId,
      'provider_id': providerId,
      'amount_tokens': amountTokens,
    });
  }

  void trackWalletSelected({required String walletType}) {
    _log('buy_wallet_selected', {'wallet_type': walletType});
  }

  void trackPurchaseConfirmed({
    required String categoryId,
    required String providerId,
    required int amountTokens,
  }) {
    _log('buy_purchase_confirmed', {
      'category_id': categoryId,
      'provider_id': providerId,
      'amount_tokens': amountTokens,
    });
  }

  void trackPurchaseSucceeded({
    required String purchaseId,
    required int amountTokens,
    required String categoryId,
  }) {
    _log('buy_purchase_succeeded', {
      'purchase_id': purchaseId,
      'amount_tokens': amountTokens,
      'category_id': categoryId,
    });
  }

  void trackPurchaseFailed({
    required String categoryId,
    required String error,
  }) {
    _log('buy_purchase_failed', {
      'category_id': categoryId,
      'error': error,
    });
  }

  // ─── Marketplace ────────────────────────────────────

  void trackListingViewed({
    required String listingId,
    required String category,
  }) {
    _log('buy_listing_viewed', {
      'listing_id': listingId,
      'category': category,
    });
  }

  void trackListingCreated({
    required String category,
    required int priceTokens,
  }) {
    _log('buy_listing_created', {
      'category': category,
      'price_tokens': priceTokens,
    });
  }

  void trackMarketplaceSearched({
    required String query,
    required int resultCount,
  }) {
    _log('buy_marketplace_searched', {
      'query': query,
      'result_count': resultCount,
    });
  }

  void trackOrderCreated({
    required String orderId,
    required int amountTokens,
  }) {
    _log('buy_order_created', {
      'order_id': orderId,
      'amount_tokens': amountTokens,
    });
  }

  void trackProviderRegistered() {
    _log('buy_provider_registered');
  }

  // ─── Brand Storefront ──────────────────────────────

  void trackStorefrontViewed({
    required String brandId,
    required String brandName,
  }) {
    _log('buy_storefront_viewed', {
      'brand_id': brandId,
      'brand_name': brandName,
    });
  }

  void trackStorefrontSectionTapped({
    required String brandId,
    required String sectionType,
  }) {
    _log('buy_storefront_section_tapped', {
      'brand_id': brandId,
      'section_type': sectionType,
    });
  }

  void trackBrandFollowed({required String brandId}) {
    _log('buy_brand_followed', {'brand_id': brandId});
  }

  void trackBrandUnfollowed({required String brandId}) {
    _log('buy_brand_unfollowed', {'brand_id': brandId});
  }

  void trackCouponClaimed({
    required String brandId,
    required String couponId,
  }) {
    _log('buy_coupon_claimed', {
      'brand_id': brandId,
      'coupon_id': couponId,
    });
  }

  void trackProductTapped({
    required String brandId,
    required String productId,
  }) {
    _log('buy_product_tapped', {
      'brand_id': brandId,
      'product_id': productId,
    });
  }

  // ─── Group Buys ─────────────────────────────────────

  void trackGroupBuyViewed({required String groupBuyId}) {
    _log('buy_group_buy_viewed', {'group_buy_id': groupBuyId});
  }

  void trackGroupBuyJoined({
    required String groupBuyId,
    required int amountTokens,
  }) {
    _log('buy_group_buy_joined', {
      'group_buy_id': groupBuyId,
      'amount_tokens': amountTokens,
    });
  }

  void trackGroupBuyLeft({required String groupBuyId}) {
    _log('buy_group_buy_left', {'group_buy_id': groupBuyId});
  }

  void trackGroupBuyRequestSubmitted() {
    _log('buy_group_buy_request_submitted');
  }

  // ─── QR Scanner ─────────────────────────────────────

  void trackQrScannerOpened() {
    _log('buy_qr_scanner_opened');
  }

  void trackQrScanSuccess({required String format}) {
    _log('buy_qr_scan_success', {'format': format});
  }

  // ─── Internal ───────────────────────────────────────

  void _log(String name, [Map<String, Object>? params]) {
    // Fire-and-forget: don't await, don't let failures propagate
    _analytics.logEvent(name: name, parameters: params).catchError((_) {});
  }
}
