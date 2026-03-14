import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vas_category.dart';

part 'vas_category_model.freezed.dart';

@freezed
abstract class VasCategoryModel with _$VasCategoryModel {
  const factory VasCategoryModel({
    required String id,
    required String name,
    required String iconName,
    required int sortOrder,
    required bool isActive,
    required String purchaseCategoryMapping,
  }) = _VasCategoryModel;

  const VasCategoryModel._();

  factory VasCategoryModel.fromJson(Map<String, dynamic> json) {
    return VasCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iconName: json['iconName'] as String? ?? '',
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? false,
      purchaseCategoryMapping:
          json['purchaseCategoryMapping'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'name': name,
      'iconName': iconName,
      'sortOrder': sortOrder,
      'isActive': isActive,
      'purchaseCategoryMapping': purchaseCategoryMapping,
    };
  }

  VasCategory toEntity() {
    return VasCategory(
      id: id,
      name: name,
      iconName: iconName,
      sortOrder: sortOrder,
      isActive: isActive,
      purchaseCategoryMapping: purchaseCategoryMapping,
    );
  }

  factory VasCategoryModel.fromEntity(VasCategory entity) {
    return VasCategoryModel(
      id: entity.id,
      name: entity.name,
      iconName: entity.iconName,
      sortOrder: entity.sortOrder,
      isActive: entity.isActive,
      purchaseCategoryMapping: entity.purchaseCategoryMapping,
    );
  }
}
