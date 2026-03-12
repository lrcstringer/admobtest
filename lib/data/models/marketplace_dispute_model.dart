import '../../domain/entities/marketplace_dispute.dart';
import '../../domain/enums/dispute_reason.dart';
import '../../domain/enums/dispute_resolution.dart';

class MarketplaceDisputeModel {
  final DisputeReason reason;
  final String details;
  final List<String> photos;
  final String? sellerResponse;
  final List<String> sellerPhotos;
  final String? proposedResolution;
  final DisputeResolution? resolution;
  final int? resolutionAmount;
  final String? resolutionNote;
  final DateTime? openedAt;
  final DateTime? sellerRespondedAt;
  final DateTime? resolvedAt;

  const MarketplaceDisputeModel({
    required this.reason,
    required this.details,
    this.photos = const [],
    this.sellerResponse,
    this.sellerPhotos = const [],
    this.proposedResolution,
    this.resolution,
    this.resolutionAmount,
    this.resolutionNote,
    this.openedAt,
    this.sellerRespondedAt,
    this.resolvedAt,
  });

  factory MarketplaceDisputeModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceDisputeModel(
      reason: _parseDisputeReason(json['reason'] as String?),
      details: json['details'] as String? ?? '',
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sellerResponse: json['sellerResponse'] as String?,
      sellerPhotos: (json['sellerPhotos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      proposedResolution: json['proposedResolution'] as String?,
      resolution: json['resolution'] != null
          ? _parseDisputeResolution(json['resolution'] as String)
          : null,
      resolutionAmount: (json['resolutionAmount'] as num?)?.toInt(),
      resolutionNote: json['resolutionNote'] as String?,
      openedAt: _parseDateTime(json['openedAt']),
      sellerRespondedAt: _parseDateTime(json['sellerRespondedAt']),
      resolvedAt: _parseDateTime(json['resolvedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason.name,
      'details': details,
      'photos': photos,
      if (sellerResponse != null) 'sellerResponse': sellerResponse,
      'sellerPhotos': sellerPhotos,
      if (proposedResolution != null) 'proposedResolution': proposedResolution,
      if (resolution != null) 'resolution': resolution!.name,
      if (resolutionAmount != null) 'resolutionAmount': resolutionAmount,
      if (resolutionNote != null) 'resolutionNote': resolutionNote,
      if (openedAt != null) 'openedAt': openedAt!.toIso8601String(),
      if (sellerRespondedAt != null)
        'sellerRespondedAt': sellerRespondedAt!.toIso8601String(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt!.toIso8601String(),
    };
  }

  MarketplaceDispute toEntity() {
    return MarketplaceDispute(
      reason: reason,
      details: details,
      photos: photos,
      sellerResponse: sellerResponse,
      sellerPhotos: sellerPhotos,
      proposedResolution: proposedResolution,
      resolution: resolution,
      resolutionAmount: resolutionAmount,
      resolutionNote: resolutionNote,
      openedAt: openedAt,
      sellerRespondedAt: sellerRespondedAt,
      resolvedAt: resolvedAt,
    );
  }

  factory MarketplaceDisputeModel.fromEntity(MarketplaceDispute entity) {
    return MarketplaceDisputeModel(
      reason: entity.reason,
      details: entity.details,
      photos: entity.photos,
      sellerResponse: entity.sellerResponse,
      sellerPhotos: entity.sellerPhotos,
      proposedResolution: entity.proposedResolution,
      resolution: entity.resolution,
      resolutionAmount: entity.resolutionAmount,
      resolutionNote: entity.resolutionNote,
      openedAt: entity.openedAt,
      sellerRespondedAt: entity.sellerRespondedAt,
      resolvedAt: entity.resolvedAt,
    );
  }
}

DisputeReason _parseDisputeReason(String? value) {
  switch (value) {
    case 'notReceived':
      return DisputeReason.notReceived;
    case 'notAsDescribed':
      return DisputeReason.notAsDescribed;
    case 'damaged':
      return DisputeReason.damaged;
    case 'sellerUnresponsive':
      return DisputeReason.sellerUnresponsive;
    default:
      return DisputeReason.other;
  }
}

DisputeResolution _parseDisputeResolution(String value) {
  switch (value) {
    case 'refundBuyer':
      return DisputeResolution.refundBuyer;
    case 'releaseToSeller':
      return DisputeResolution.releaseToSeller;
    case 'partialRefund':
      return DisputeResolution.partialRefund;
    case 'requireReturn':
      return DisputeResolution.requireReturn;
    case 'split':
      return DisputeResolution.split;
    default:
      return DisputeResolution.refundBuyer;
  }
}

DateTime? _parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is String) return DateTime.tryParse(value);
  // Firestore Timestamp
  if (value is Map && value['_seconds'] != null) {
    return DateTime.fromMillisecondsSinceEpoch(
      (value['_seconds'] as int) * 1000,
    );
  }
  return null;
}
