/// 21 regional clusters across 9 South African provinces.
///
/// Used for physical group buy matching — users opt into clusters
/// in their profile settings, and physical deals are shown only
/// to users in matching clusters.
class ClusterConstants {
  ClusterConstants._();

  static const Map<String, List<String>> clustersByProvince = {
    'Gauteng': [
      'Johannesburg CBD & Inner City',
      'Soweto & South West',
      'East Rand (Ekurhuleni)',
      'Pretoria & Tshwane',
    ],
    'Western Cape': [
      'Cape Town Metro',
      'Cape Winelands & Overberg',
    ],
    'KwaZulu-Natal': [
      'Durban & eThekwini',
      'Pietermaritzburg & Midlands',
    ],
    'Eastern Cape': [
      'Nelson Mandela Bay (PE)',
      'Buffalo City (East London)',
    ],
    'Limpopo': [
      'Polokwane & Capricorn',
    ],
    'Mpumalanga': [
      'Mbombela & Ehlanzeni',
    ],
    'Free State': [
      'Mangaung (Bloemfontein)',
    ],
    'North West': [
      'Rustenburg & Bojanala',
      'Mahikeng & Ngaka Modiri Molema',
    ],
    'Northern Cape': [
      'Sol Plaatje (Kimberley)',
    ],
  };

  /// Flat list of all cluster names.
  static List<String> get allClusters =>
      clustersByProvince.values.expand((c) => c).toList();
}
