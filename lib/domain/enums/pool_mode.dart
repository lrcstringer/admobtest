/// Mode of the token pool / collection room
enum PoolMode {
  /// Group gift for an external recipient (Group Sasaza)
  sasaza,

  /// Group savings for participants (Group Save)
  save,
}

extension PoolModeX on PoolMode {
  String get displayName => switch (this) {
        PoolMode.sasaza => 'Group Sasaza',
        PoolMode.save => 'Group Save',
      };

  bool get isSasaza => this == PoolMode.sasaza;
  bool get isSave => this == PoolMode.save;
}
