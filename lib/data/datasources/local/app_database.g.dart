// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalWalletsTable extends LocalWallets
    with TableInfo<$LocalWalletsTable, LocalWallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tokenBalanceMeta = const VerificationMeta(
    'tokenBalance',
  );
  @override
  late final GeneratedColumn<int> tokenBalance = GeneratedColumn<int>(
    'token_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pendingBalanceMeta = const VerificationMeta(
    'pendingBalance',
  );
  @override
  late final GeneratedColumn<int> pendingBalance = GeneratedColumn<int>(
    'pending_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifetimeEarnedMeta = const VerificationMeta(
    'lifetimeEarned',
  );
  @override
  late final GeneratedColumn<int> lifetimeEarned = GeneratedColumn<int>(
    'lifetime_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifetimeWithdrawnMeta = const VerificationMeta(
    'lifetimeWithdrawn',
  );
  @override
  late final GeneratedColumn<int> lifetimeWithdrawn = GeneratedColumn<int>(
    'lifetime_withdrawn',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _todayEarnedMeta = const VerificationMeta(
    'todayEarned',
  );
  @override
  late final GeneratedColumn<int> todayEarned = GeneratedColumn<int>(
    'today_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pendingWithdrawalMeta = const VerificationMeta(
    'pendingWithdrawal',
  );
  @override
  late final GeneratedColumn<int> pendingWithdrawal = GeneratedColumn<int>(
    'pending_withdrawal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastEarnedAtMeta = const VerificationMeta(
    'lastEarnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastEarnedAt = GeneratedColumn<DateTime>(
    'last_earned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    tokenBalance,
    pendingBalance,
    lifetimeEarned,
    lifetimeWithdrawn,
    todayEarned,
    pendingWithdrawal,
    lastEarnedAt,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_wallets';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalWallet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('token_balance')) {
      context.handle(
        _tokenBalanceMeta,
        tokenBalance.isAcceptableOrUnknown(
          data['token_balance']!,
          _tokenBalanceMeta,
        ),
      );
    }
    if (data.containsKey('pending_balance')) {
      context.handle(
        _pendingBalanceMeta,
        pendingBalance.isAcceptableOrUnknown(
          data['pending_balance']!,
          _pendingBalanceMeta,
        ),
      );
    }
    if (data.containsKey('lifetime_earned')) {
      context.handle(
        _lifetimeEarnedMeta,
        lifetimeEarned.isAcceptableOrUnknown(
          data['lifetime_earned']!,
          _lifetimeEarnedMeta,
        ),
      );
    }
    if (data.containsKey('lifetime_withdrawn')) {
      context.handle(
        _lifetimeWithdrawnMeta,
        lifetimeWithdrawn.isAcceptableOrUnknown(
          data['lifetime_withdrawn']!,
          _lifetimeWithdrawnMeta,
        ),
      );
    }
    if (data.containsKey('today_earned')) {
      context.handle(
        _todayEarnedMeta,
        todayEarned.isAcceptableOrUnknown(
          data['today_earned']!,
          _todayEarnedMeta,
        ),
      );
    }
    if (data.containsKey('pending_withdrawal')) {
      context.handle(
        _pendingWithdrawalMeta,
        pendingWithdrawal.isAcceptableOrUnknown(
          data['pending_withdrawal']!,
          _pendingWithdrawalMeta,
        ),
      );
    }
    if (data.containsKey('last_earned_at')) {
      context.handle(
        _lastEarnedAtMeta,
        lastEarnedAt.isAcceptableOrUnknown(
          data['last_earned_at']!,
          _lastEarnedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalWallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWallet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      tokenBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_balance'],
      )!,
      pendingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pending_balance'],
      )!,
      lifetimeEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_earned'],
      )!,
      lifetimeWithdrawn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_withdrawn'],
      )!,
      todayEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}today_earned'],
      )!,
      pendingWithdrawal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pending_withdrawal'],
      )!,
      lastEarnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_earned_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalWalletsTable createAlias(String alias) {
    return $LocalWalletsTable(attachedDatabase, alias);
  }
}

class LocalWallet extends DataClass implements Insertable<LocalWallet> {
  final String id;
  final String userId;
  final int tokenBalance;
  final int pendingBalance;
  final int lifetimeEarned;
  final int lifetimeWithdrawn;
  final int todayEarned;
  final int pendingWithdrawal;
  final DateTime? lastEarnedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalWallet({
    required this.id,
    required this.userId,
    required this.tokenBalance,
    required this.pendingBalance,
    required this.lifetimeEarned,
    required this.lifetimeWithdrawn,
    required this.todayEarned,
    required this.pendingWithdrawal,
    this.lastEarnedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['token_balance'] = Variable<int>(tokenBalance);
    map['pending_balance'] = Variable<int>(pendingBalance);
    map['lifetime_earned'] = Variable<int>(lifetimeEarned);
    map['lifetime_withdrawn'] = Variable<int>(lifetimeWithdrawn);
    map['today_earned'] = Variable<int>(todayEarned);
    map['pending_withdrawal'] = Variable<int>(pendingWithdrawal);
    if (!nullToAbsent || lastEarnedAt != null) {
      map['last_earned_at'] = Variable<DateTime>(lastEarnedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalWalletsCompanion toCompanion(bool nullToAbsent) {
    return LocalWalletsCompanion(
      id: Value(id),
      userId: Value(userId),
      tokenBalance: Value(tokenBalance),
      pendingBalance: Value(pendingBalance),
      lifetimeEarned: Value(lifetimeEarned),
      lifetimeWithdrawn: Value(lifetimeWithdrawn),
      todayEarned: Value(todayEarned),
      pendingWithdrawal: Value(pendingWithdrawal),
      lastEarnedAt: lastEarnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastEarnedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalWallet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWallet(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      tokenBalance: serializer.fromJson<int>(json['tokenBalance']),
      pendingBalance: serializer.fromJson<int>(json['pendingBalance']),
      lifetimeEarned: serializer.fromJson<int>(json['lifetimeEarned']),
      lifetimeWithdrawn: serializer.fromJson<int>(json['lifetimeWithdrawn']),
      todayEarned: serializer.fromJson<int>(json['todayEarned']),
      pendingWithdrawal: serializer.fromJson<int>(json['pendingWithdrawal']),
      lastEarnedAt: serializer.fromJson<DateTime?>(json['lastEarnedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'tokenBalance': serializer.toJson<int>(tokenBalance),
      'pendingBalance': serializer.toJson<int>(pendingBalance),
      'lifetimeEarned': serializer.toJson<int>(lifetimeEarned),
      'lifetimeWithdrawn': serializer.toJson<int>(lifetimeWithdrawn),
      'todayEarned': serializer.toJson<int>(todayEarned),
      'pendingWithdrawal': serializer.toJson<int>(pendingWithdrawal),
      'lastEarnedAt': serializer.toJson<DateTime?>(lastEarnedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalWallet copyWith({
    String? id,
    String? userId,
    int? tokenBalance,
    int? pendingBalance,
    int? lifetimeEarned,
    int? lifetimeWithdrawn,
    int? todayEarned,
    int? pendingWithdrawal,
    Value<DateTime?> lastEarnedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalWallet(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    tokenBalance: tokenBalance ?? this.tokenBalance,
    pendingBalance: pendingBalance ?? this.pendingBalance,
    lifetimeEarned: lifetimeEarned ?? this.lifetimeEarned,
    lifetimeWithdrawn: lifetimeWithdrawn ?? this.lifetimeWithdrawn,
    todayEarned: todayEarned ?? this.todayEarned,
    pendingWithdrawal: pendingWithdrawal ?? this.pendingWithdrawal,
    lastEarnedAt: lastEarnedAt.present ? lastEarnedAt.value : this.lastEarnedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalWallet copyWithCompanion(LocalWalletsCompanion data) {
    return LocalWallet(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      tokenBalance: data.tokenBalance.present
          ? data.tokenBalance.value
          : this.tokenBalance,
      pendingBalance: data.pendingBalance.present
          ? data.pendingBalance.value
          : this.pendingBalance,
      lifetimeEarned: data.lifetimeEarned.present
          ? data.lifetimeEarned.value
          : this.lifetimeEarned,
      lifetimeWithdrawn: data.lifetimeWithdrawn.present
          ? data.lifetimeWithdrawn.value
          : this.lifetimeWithdrawn,
      todayEarned: data.todayEarned.present
          ? data.todayEarned.value
          : this.todayEarned,
      pendingWithdrawal: data.pendingWithdrawal.present
          ? data.pendingWithdrawal.value
          : this.pendingWithdrawal,
      lastEarnedAt: data.lastEarnedAt.present
          ? data.lastEarnedAt.value
          : this.lastEarnedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWallet(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('tokenBalance: $tokenBalance, ')
          ..write('pendingBalance: $pendingBalance, ')
          ..write('lifetimeEarned: $lifetimeEarned, ')
          ..write('lifetimeWithdrawn: $lifetimeWithdrawn, ')
          ..write('todayEarned: $todayEarned, ')
          ..write('pendingWithdrawal: $pendingWithdrawal, ')
          ..write('lastEarnedAt: $lastEarnedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    tokenBalance,
    pendingBalance,
    lifetimeEarned,
    lifetimeWithdrawn,
    todayEarned,
    pendingWithdrawal,
    lastEarnedAt,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWallet &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.tokenBalance == this.tokenBalance &&
          other.pendingBalance == this.pendingBalance &&
          other.lifetimeEarned == this.lifetimeEarned &&
          other.lifetimeWithdrawn == this.lifetimeWithdrawn &&
          other.todayEarned == this.todayEarned &&
          other.pendingWithdrawal == this.pendingWithdrawal &&
          other.lastEarnedAt == this.lastEarnedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalWalletsCompanion extends UpdateCompanion<LocalWallet> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> tokenBalance;
  final Value<int> pendingBalance;
  final Value<int> lifetimeEarned;
  final Value<int> lifetimeWithdrawn;
  final Value<int> todayEarned;
  final Value<int> pendingWithdrawal;
  final Value<DateTime?> lastEarnedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalWalletsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.tokenBalance = const Value.absent(),
    this.pendingBalance = const Value.absent(),
    this.lifetimeEarned = const Value.absent(),
    this.lifetimeWithdrawn = const Value.absent(),
    this.todayEarned = const Value.absent(),
    this.pendingWithdrawal = const Value.absent(),
    this.lastEarnedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalWalletsCompanion.insert({
    required String id,
    required String userId,
    this.tokenBalance = const Value.absent(),
    this.pendingBalance = const Value.absent(),
    this.lifetimeEarned = const Value.absent(),
    this.lifetimeWithdrawn = const Value.absent(),
    this.todayEarned = const Value.absent(),
    this.pendingWithdrawal = const Value.absent(),
    this.lastEarnedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalWallet> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? tokenBalance,
    Expression<int>? pendingBalance,
    Expression<int>? lifetimeEarned,
    Expression<int>? lifetimeWithdrawn,
    Expression<int>? todayEarned,
    Expression<int>? pendingWithdrawal,
    Expression<DateTime>? lastEarnedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (tokenBalance != null) 'token_balance': tokenBalance,
      if (pendingBalance != null) 'pending_balance': pendingBalance,
      if (lifetimeEarned != null) 'lifetime_earned': lifetimeEarned,
      if (lifetimeWithdrawn != null) 'lifetime_withdrawn': lifetimeWithdrawn,
      if (todayEarned != null) 'today_earned': todayEarned,
      if (pendingWithdrawal != null) 'pending_withdrawal': pendingWithdrawal,
      if (lastEarnedAt != null) 'last_earned_at': lastEarnedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalWalletsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<int>? tokenBalance,
    Value<int>? pendingBalance,
    Value<int>? lifetimeEarned,
    Value<int>? lifetimeWithdrawn,
    Value<int>? todayEarned,
    Value<int>? pendingWithdrawal,
    Value<DateTime?>? lastEarnedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalWalletsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      pendingBalance: pendingBalance ?? this.pendingBalance,
      lifetimeEarned: lifetimeEarned ?? this.lifetimeEarned,
      lifetimeWithdrawn: lifetimeWithdrawn ?? this.lifetimeWithdrawn,
      todayEarned: todayEarned ?? this.todayEarned,
      pendingWithdrawal: pendingWithdrawal ?? this.pendingWithdrawal,
      lastEarnedAt: lastEarnedAt ?? this.lastEarnedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (tokenBalance.present) {
      map['token_balance'] = Variable<int>(tokenBalance.value);
    }
    if (pendingBalance.present) {
      map['pending_balance'] = Variable<int>(pendingBalance.value);
    }
    if (lifetimeEarned.present) {
      map['lifetime_earned'] = Variable<int>(lifetimeEarned.value);
    }
    if (lifetimeWithdrawn.present) {
      map['lifetime_withdrawn'] = Variable<int>(lifetimeWithdrawn.value);
    }
    if (todayEarned.present) {
      map['today_earned'] = Variable<int>(todayEarned.value);
    }
    if (pendingWithdrawal.present) {
      map['pending_withdrawal'] = Variable<int>(pendingWithdrawal.value);
    }
    if (lastEarnedAt.present) {
      map['last_earned_at'] = Variable<DateTime>(lastEarnedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWalletsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('tokenBalance: $tokenBalance, ')
          ..write('pendingBalance: $pendingBalance, ')
          ..write('lifetimeEarned: $lifetimeEarned, ')
          ..write('lifetimeWithdrawn: $lifetimeWithdrawn, ')
          ..write('todayEarned: $todayEarned, ')
          ..write('pendingWithdrawal: $pendingWithdrawal, ')
          ..write('lastEarnedAt: $lastEarnedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalTransactionsTable extends LocalTransactions
    with TableInfo<$LocalTransactionsTable, LocalTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTypeMeta = const VerificationMeta(
    'subType',
  );
  @override
  late final GeneratedColumn<String> subType = GeneratedColumn<String>(
    'sub_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tokenAmountMeta = const VerificationMeta(
    'tokenAmount',
  );
  @override
  late final GeneratedColumn<int> tokenAmount = GeneratedColumn<int>(
    'token_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zarAmountMeta = const VerificationMeta(
    'zarAmount',
  );
  @override
  late final GeneratedColumn<double> zarAmount = GeneratedColumn<double>(
    'zar_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletId,
    userId,
    type,
    subType,
    tokenAmount,
    zarAmount,
    description,
    status,
    referenceId,
    referenceType,
    metadata,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('sub_type')) {
      context.handle(
        _subTypeMeta,
        subType.isAcceptableOrUnknown(data['sub_type']!, _subTypeMeta),
      );
    }
    if (data.containsKey('token_amount')) {
      context.handle(
        _tokenAmountMeta,
        tokenAmount.isAcceptableOrUnknown(
          data['token_amount']!,
          _tokenAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tokenAmountMeta);
    }
    if (data.containsKey('zar_amount')) {
      context.handle(
        _zarAmountMeta,
        zarAmount.isAcceptableOrUnknown(data['zar_amount']!, _zarAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_zarAmountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      subType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_type'],
      ),
      tokenAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_amount'],
      )!,
      zarAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}zar_amount'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalTransactionsTable createAlias(String alias) {
    return $LocalTransactionsTable(attachedDatabase, alias);
  }
}

class LocalTransaction extends DataClass
    implements Insertable<LocalTransaction> {
  final String id;
  final String walletId;
  final String userId;
  final String type;
  final String? subType;
  final int tokenAmount;
  final double zarAmount;
  final String description;
  final String status;
  final String? referenceId;
  final String? referenceType;
  final String? metadata;
  final DateTime createdAt;
  final bool isSynced;
  const LocalTransaction({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.type,
    this.subType,
    required this.tokenAmount,
    required this.zarAmount,
    required this.description,
    required this.status,
    this.referenceId,
    this.referenceType,
    this.metadata,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wallet_id'] = Variable<String>(walletId);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || subType != null) {
      map['sub_type'] = Variable<String>(subType);
    }
    map['token_amount'] = Variable<int>(tokenAmount);
    map['zar_amount'] = Variable<double>(zarAmount);
    map['description'] = Variable<String>(description);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalTransactionsCompanion toCompanion(bool nullToAbsent) {
    return LocalTransactionsCompanion(
      id: Value(id),
      walletId: Value(walletId),
      userId: Value(userId),
      type: Value(type),
      subType: subType == null && nullToAbsent
          ? const Value.absent()
          : Value(subType),
      tokenAmount: Value(tokenAmount),
      zarAmount: Value(zarAmount),
      description: Value(description),
      status: Value(status),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTransaction(
      id: serializer.fromJson<String>(json['id']),
      walletId: serializer.fromJson<String>(json['walletId']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      subType: serializer.fromJson<String?>(json['subType']),
      tokenAmount: serializer.fromJson<int>(json['tokenAmount']),
      zarAmount: serializer.fromJson<double>(json['zarAmount']),
      description: serializer.fromJson<String>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'walletId': serializer.toJson<String>(walletId),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'subType': serializer.toJson<String?>(subType),
      'tokenAmount': serializer.toJson<int>(tokenAmount),
      'zarAmount': serializer.toJson<double>(zarAmount),
      'description': serializer.toJson<String>(description),
      'status': serializer.toJson<String>(status),
      'referenceId': serializer.toJson<String?>(referenceId),
      'referenceType': serializer.toJson<String?>(referenceType),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalTransaction copyWith({
    String? id,
    String? walletId,
    String? userId,
    String? type,
    Value<String?> subType = const Value.absent(),
    int? tokenAmount,
    double? zarAmount,
    String? description,
    String? status,
    Value<String?> referenceId = const Value.absent(),
    Value<String?> referenceType = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
  }) => LocalTransaction(
    id: id ?? this.id,
    walletId: walletId ?? this.walletId,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    subType: subType.present ? subType.value : this.subType,
    tokenAmount: tokenAmount ?? this.tokenAmount,
    zarAmount: zarAmount ?? this.zarAmount,
    description: description ?? this.description,
    status: status ?? this.status,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    metadata: metadata.present ? metadata.value : this.metadata,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalTransaction copyWithCompanion(LocalTransactionsCompanion data) {
    return LocalTransaction(
      id: data.id.present ? data.id.value : this.id,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      subType: data.subType.present ? data.subType.value : this.subType,
      tokenAmount: data.tokenAmount.present
          ? data.tokenAmount.value
          : this.tokenAmount,
      zarAmount: data.zarAmount.present ? data.zarAmount.value : this.zarAmount,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransaction(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('tokenAmount: $tokenAmount, ')
          ..write('zarAmount: $zarAmount, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walletId,
    userId,
    type,
    subType,
    tokenAmount,
    zarAmount,
    description,
    status,
    referenceId,
    referenceType,
    metadata,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTransaction &&
          other.id == this.id &&
          other.walletId == this.walletId &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.subType == this.subType &&
          other.tokenAmount == this.tokenAmount &&
          other.zarAmount == this.zarAmount &&
          other.description == this.description &&
          other.status == this.status &&
          other.referenceId == this.referenceId &&
          other.referenceType == this.referenceType &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class LocalTransactionsCompanion extends UpdateCompanion<LocalTransaction> {
  final Value<String> id;
  final Value<String> walletId;
  final Value<String> userId;
  final Value<String> type;
  final Value<String?> subType;
  final Value<int> tokenAmount;
  final Value<double> zarAmount;
  final Value<String> description;
  final Value<String> status;
  final Value<String?> referenceId;
  final Value<String?> referenceType;
  final Value<String?> metadata;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalTransactionsCompanion({
    this.id = const Value.absent(),
    this.walletId = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.subType = const Value.absent(),
    this.tokenAmount = const Value.absent(),
    this.zarAmount = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalTransactionsCompanion.insert({
    required String id,
    required String walletId,
    required String userId,
    required String type,
    this.subType = const Value.absent(),
    required int tokenAmount,
    required double zarAmount,
    required String description,
    required String status,
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.metadata = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       walletId = Value(walletId),
       userId = Value(userId),
       type = Value(type),
       tokenAmount = Value(tokenAmount),
       zarAmount = Value(zarAmount),
       description = Value(description),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalTransaction> custom({
    Expression<String>? id,
    Expression<String>? walletId,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? subType,
    Expression<int>? tokenAmount,
    Expression<double>? zarAmount,
    Expression<String>? description,
    Expression<String>? status,
    Expression<String>? referenceId,
    Expression<String>? referenceType,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletId != null) 'wallet_id': walletId,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (subType != null) 'sub_type': subType,
      if (tokenAmount != null) 'token_amount': tokenAmount,
      if (zarAmount != null) 'zar_amount': zarAmount,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (referenceId != null) 'reference_id': referenceId,
      if (referenceType != null) 'reference_type': referenceType,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? walletId,
    Value<String>? userId,
    Value<String>? type,
    Value<String?>? subType,
    Value<int>? tokenAmount,
    Value<double>? zarAmount,
    Value<String>? description,
    Value<String>? status,
    Value<String?>? referenceId,
    Value<String?>? referenceType,
    Value<String?>? metadata,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalTransactionsCompanion(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      tokenAmount: tokenAmount ?? this.tokenAmount,
      zarAmount: zarAmount ?? this.zarAmount,
      description: description ?? this.description,
      status: status ?? this.status,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (subType.present) {
      map['sub_type'] = Variable<String>(subType.value);
    }
    if (tokenAmount.present) {
      map['token_amount'] = Variable<int>(tokenAmount.value);
    }
    if (zarAmount.present) {
      map['zar_amount'] = Variable<double>(zarAmount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('subType: $subType, ')
          ..write('tokenAmount: $tokenAmount, ')
          ..write('zarAmount: $zarAmount, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalEarnThreadsTable extends LocalEarnThreads
    with TableInfo<$LocalEarnThreadsTable, LocalEarnThread> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalEarnThreadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campaignIdMeta = const VerificationMeta(
    'campaignId',
  );
  @override
  late final GeneratedColumn<String> campaignId = GeneratedColumn<String>(
    'campaign_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campaignNameMeta = const VerificationMeta(
    'campaignName',
  );
  @override
  late final GeneratedColumn<String> campaignName = GeneratedColumn<String>(
    'campaign_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardAmountMeta = const VerificationMeta(
    'rewardAmount',
  );
  @override
  late final GeneratedColumn<int> rewardAmount = GeneratedColumn<int>(
    'reward_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailUrlMeta = const VerificationMeta(
    'thumbnailUrl',
  );
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
    'thumbnail_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    campaignId,
    campaignName,
    type,
    status,
    rewardAmount,
    thumbnailUrl,
    progress,
    startedAt,
    completedAt,
    expiresAt,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_earn_threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalEarnThread> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
        _campaignIdMeta,
        campaignId.isAcceptableOrUnknown(data['campaign_id']!, _campaignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('campaign_name')) {
      context.handle(
        _campaignNameMeta,
        campaignName.isAcceptableOrUnknown(
          data['campaign_name']!,
          _campaignNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_campaignNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reward_amount')) {
      context.handle(
        _rewardAmountMeta,
        rewardAmount.isAcceptableOrUnknown(
          data['reward_amount']!,
          _rewardAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardAmountMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
        _thumbnailUrlMeta,
        thumbnailUrl.isAcceptableOrUnknown(
          data['thumbnail_url']!,
          _thumbnailUrlMeta,
        ),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalEarnThread map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalEarnThread(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      campaignId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campaign_id'],
      )!,
      campaignName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campaign_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      rewardAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_amount'],
      )!,
      thumbnailUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_url'],
      ),
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalEarnThreadsTable createAlias(String alias) {
    return $LocalEarnThreadsTable(attachedDatabase, alias);
  }
}

class LocalEarnThread extends DataClass implements Insertable<LocalEarnThread> {
  final String id;
  final String userId;
  final String campaignId;
  final String campaignName;
  final String type;
  final String status;
  final int rewardAmount;
  final String? thumbnailUrl;
  final int progress;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalEarnThread({
    required this.id,
    required this.userId,
    required this.campaignId,
    required this.campaignName,
    required this.type,
    required this.status,
    required this.rewardAmount,
    this.thumbnailUrl,
    required this.progress,
    this.startedAt,
    this.completedAt,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['campaign_id'] = Variable<String>(campaignId);
    map['campaign_name'] = Variable<String>(campaignName);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['reward_amount'] = Variable<int>(rewardAmount);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['progress'] = Variable<int>(progress);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalEarnThreadsCompanion toCompanion(bool nullToAbsent) {
    return LocalEarnThreadsCompanion(
      id: Value(id),
      userId: Value(userId),
      campaignId: Value(campaignId),
      campaignName: Value(campaignName),
      type: Value(type),
      status: Value(status),
      rewardAmount: Value(rewardAmount),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      progress: Value(progress),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalEarnThread.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalEarnThread(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      campaignId: serializer.fromJson<String>(json['campaignId']),
      campaignName: serializer.fromJson<String>(json['campaignName']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      rewardAmount: serializer.fromJson<int>(json['rewardAmount']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      progress: serializer.fromJson<int>(json['progress']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'campaignId': serializer.toJson<String>(campaignId),
      'campaignName': serializer.toJson<String>(campaignName),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'rewardAmount': serializer.toJson<int>(rewardAmount),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'progress': serializer.toJson<int>(progress),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalEarnThread copyWith({
    String? id,
    String? userId,
    String? campaignId,
    String? campaignName,
    String? type,
    String? status,
    int? rewardAmount,
    Value<String?> thumbnailUrl = const Value.absent(),
    int? progress,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<DateTime?> expiresAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalEarnThread(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    campaignId: campaignId ?? this.campaignId,
    campaignName: campaignName ?? this.campaignName,
    type: type ?? this.type,
    status: status ?? this.status,
    rewardAmount: rewardAmount ?? this.rewardAmount,
    thumbnailUrl: thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
    progress: progress ?? this.progress,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalEarnThread copyWithCompanion(LocalEarnThreadsCompanion data) {
    return LocalEarnThread(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      campaignId: data.campaignId.present
          ? data.campaignId.value
          : this.campaignId,
      campaignName: data.campaignName.present
          ? data.campaignName.value
          : this.campaignName,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      rewardAmount: data.rewardAmount.present
          ? data.rewardAmount.value
          : this.rewardAmount,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      progress: data.progress.present ? data.progress.value : this.progress,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalEarnThread(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('campaignId: $campaignId, ')
          ..write('campaignName: $campaignName, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('rewardAmount: $rewardAmount, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('progress: $progress, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    campaignId,
    campaignName,
    type,
    status,
    rewardAmount,
    thumbnailUrl,
    progress,
    startedAt,
    completedAt,
    expiresAt,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalEarnThread &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.campaignId == this.campaignId &&
          other.campaignName == this.campaignName &&
          other.type == this.type &&
          other.status == this.status &&
          other.rewardAmount == this.rewardAmount &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.progress == this.progress &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalEarnThreadsCompanion extends UpdateCompanion<LocalEarnThread> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> campaignId;
  final Value<String> campaignName;
  final Value<String> type;
  final Value<String> status;
  final Value<int> rewardAmount;
  final Value<String?> thumbnailUrl;
  final Value<int> progress;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> expiresAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalEarnThreadsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.campaignName = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.rewardAmount = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.progress = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalEarnThreadsCompanion.insert({
    required String id,
    required String userId,
    required String campaignId,
    required String campaignName,
    required String type,
    required String status,
    required int rewardAmount,
    this.thumbnailUrl = const Value.absent(),
    this.progress = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       campaignId = Value(campaignId),
       campaignName = Value(campaignName),
       type = Value(type),
       status = Value(status),
       rewardAmount = Value(rewardAmount),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalEarnThread> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? campaignId,
    Expression<String>? campaignName,
    Expression<String>? type,
    Expression<String>? status,
    Expression<int>? rewardAmount,
    Expression<String>? thumbnailUrl,
    Expression<int>? progress,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (campaignId != null) 'campaign_id': campaignId,
      if (campaignName != null) 'campaign_name': campaignName,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (rewardAmount != null) 'reward_amount': rewardAmount,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (progress != null) 'progress': progress,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalEarnThreadsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? campaignId,
    Value<String>? campaignName,
    Value<String>? type,
    Value<String>? status,
    Value<int>? rewardAmount,
    Value<String?>? thumbnailUrl,
    Value<int>? progress,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime?>? expiresAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalEarnThreadsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      campaignId: campaignId ?? this.campaignId,
      campaignName: campaignName ?? this.campaignName,
      type: type ?? this.type,
      status: status ?? this.status,
      rewardAmount: rewardAmount ?? this.rewardAmount,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      progress: progress ?? this.progress,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<String>(campaignId.value);
    }
    if (campaignName.present) {
      map['campaign_name'] = Variable<String>(campaignName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rewardAmount.present) {
      map['reward_amount'] = Variable<int>(rewardAmount.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalEarnThreadsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('campaignId: $campaignId, ')
          ..write('campaignName: $campaignName, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('rewardAmount: $rewardAmount, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('progress: $progress, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalChatThreadsTable extends LocalChatThreads
    with TableInfo<$LocalChatThreadsTable, LocalChatThread> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalChatThreadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherUserIdMeta = const VerificationMeta(
    'otherUserId',
  );
  @override
  late final GeneratedColumn<String> otherUserId = GeneratedColumn<String>(
    'other_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherUserNameMeta = const VerificationMeta(
    'otherUserName',
  );
  @override
  late final GeneratedColumn<String> otherUserName = GeneratedColumn<String>(
    'other_user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherUserAvatarMeta = const VerificationMeta(
    'otherUserAvatar',
  );
  @override
  late final GeneratedColumn<String> otherUserAvatar = GeneratedColumn<String>(
    'other_user_avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageMeta = const VerificationMeta(
    'lastMessage',
  );
  @override
  late final GeneratedColumn<String> lastMessage = GeneratedColumn<String>(
    'last_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    otherUserId,
    otherUserName,
    otherUserAvatar,
    lastMessage,
    lastMessageAt,
    unreadCount,
    isArchived,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_chat_threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalChatThread> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('other_user_id')) {
      context.handle(
        _otherUserIdMeta,
        otherUserId.isAcceptableOrUnknown(
          data['other_user_id']!,
          _otherUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_otherUserIdMeta);
    }
    if (data.containsKey('other_user_name')) {
      context.handle(
        _otherUserNameMeta,
        otherUserName.isAcceptableOrUnknown(
          data['other_user_name']!,
          _otherUserNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_otherUserNameMeta);
    }
    if (data.containsKey('other_user_avatar')) {
      context.handle(
        _otherUserAvatarMeta,
        otherUserAvatar.isAcceptableOrUnknown(
          data['other_user_avatar']!,
          _otherUserAvatarMeta,
        ),
      );
    }
    if (data.containsKey('last_message')) {
      context.handle(
        _lastMessageMeta,
        lastMessage.isAcceptableOrUnknown(
          data['last_message']!,
          _lastMessageMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalChatThread map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalChatThread(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      otherUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_user_id'],
      )!,
      otherUserName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_user_name'],
      )!,
      otherUserAvatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_user_avatar'],
      ),
      lastMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalChatThreadsTable createAlias(String alias) {
    return $LocalChatThreadsTable(attachedDatabase, alias);
  }
}

class LocalChatThread extends DataClass implements Insertable<LocalChatThread> {
  final String id;
  final String userId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserAvatar;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const LocalChatThread({
    required this.id,
    required this.userId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserAvatar,
    this.lastMessage,
    this.lastMessageAt,
    required this.unreadCount,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['other_user_id'] = Variable<String>(otherUserId);
    map['other_user_name'] = Variable<String>(otherUserName);
    if (!nullToAbsent || otherUserAvatar != null) {
      map['other_user_avatar'] = Variable<String>(otherUserAvatar);
    }
    if (!nullToAbsent || lastMessage != null) {
      map['last_message'] = Variable<String>(lastMessage);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalChatThreadsCompanion toCompanion(bool nullToAbsent) {
    return LocalChatThreadsCompanion(
      id: Value(id),
      userId: Value(userId),
      otherUserId: Value(otherUserId),
      otherUserName: Value(otherUserName),
      otherUserAvatar: otherUserAvatar == null && nullToAbsent
          ? const Value.absent()
          : Value(otherUserAvatar),
      lastMessage: lastMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessage),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCount: Value(unreadCount),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalChatThread.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalChatThread(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      otherUserId: serializer.fromJson<String>(json['otherUserId']),
      otherUserName: serializer.fromJson<String>(json['otherUserName']),
      otherUserAvatar: serializer.fromJson<String?>(json['otherUserAvatar']),
      lastMessage: serializer.fromJson<String?>(json['lastMessage']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'otherUserId': serializer.toJson<String>(otherUserId),
      'otherUserName': serializer.toJson<String>(otherUserName),
      'otherUserAvatar': serializer.toJson<String?>(otherUserAvatar),
      'lastMessage': serializer.toJson<String?>(lastMessage),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalChatThread copyWith({
    String? id,
    String? userId,
    String? otherUserId,
    String? otherUserName,
    Value<String?> otherUserAvatar = const Value.absent(),
    Value<String?> lastMessage = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    int? unreadCount,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => LocalChatThread(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    otherUserId: otherUserId ?? this.otherUserId,
    otherUserName: otherUserName ?? this.otherUserName,
    otherUserAvatar: otherUserAvatar.present
        ? otherUserAvatar.value
        : this.otherUserAvatar,
    lastMessage: lastMessage.present ? lastMessage.value : this.lastMessage,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalChatThread copyWithCompanion(LocalChatThreadsCompanion data) {
    return LocalChatThread(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      otherUserId: data.otherUserId.present
          ? data.otherUserId.value
          : this.otherUserId,
      otherUserName: data.otherUserName.present
          ? data.otherUserName.value
          : this.otherUserName,
      otherUserAvatar: data.otherUserAvatar.present
          ? data.otherUserAvatar.value
          : this.otherUserAvatar,
      lastMessage: data.lastMessage.present
          ? data.lastMessage.value
          : this.lastMessage,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalChatThread(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('otherUserId: $otherUserId, ')
          ..write('otherUserName: $otherUserName, ')
          ..write('otherUserAvatar: $otherUserAvatar, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    otherUserId,
    otherUserName,
    otherUserAvatar,
    lastMessage,
    lastMessageAt,
    unreadCount,
    isArchived,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalChatThread &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.otherUserId == this.otherUserId &&
          other.otherUserName == this.otherUserName &&
          other.otherUserAvatar == this.otherUserAvatar &&
          other.lastMessage == this.lastMessage &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCount == this.unreadCount &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class LocalChatThreadsCompanion extends UpdateCompanion<LocalChatThread> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> otherUserId;
  final Value<String> otherUserName;
  final Value<String?> otherUserAvatar;
  final Value<String?> lastMessage;
  final Value<DateTime?> lastMessageAt;
  final Value<int> unreadCount;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalChatThreadsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.otherUserId = const Value.absent(),
    this.otherUserName = const Value.absent(),
    this.otherUserAvatar = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalChatThreadsCompanion.insert({
    required String id,
    required String userId,
    required String otherUserId,
    required String otherUserName,
    this.otherUserAvatar = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       otherUserId = Value(otherUserId),
       otherUserName = Value(otherUserName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalChatThread> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? otherUserId,
    Expression<String>? otherUserName,
    Expression<String>? otherUserAvatar,
    Expression<String>? lastMessage,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? unreadCount,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (otherUserId != null) 'other_user_id': otherUserId,
      if (otherUserName != null) 'other_user_name': otherUserName,
      if (otherUserAvatar != null) 'other_user_avatar': otherUserAvatar,
      if (lastMessage != null) 'last_message': lastMessage,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalChatThreadsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? otherUserId,
    Value<String>? otherUserName,
    Value<String?>? otherUserAvatar,
    Value<String?>? lastMessage,
    Value<DateTime?>? lastMessageAt,
    Value<int>? unreadCount,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalChatThreadsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      otherUserId: otherUserId ?? this.otherUserId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserAvatar: otherUserAvatar ?? this.otherUserAvatar,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (otherUserId.present) {
      map['other_user_id'] = Variable<String>(otherUserId.value);
    }
    if (otherUserName.present) {
      map['other_user_name'] = Variable<String>(otherUserName.value);
    }
    if (otherUserAvatar.present) {
      map['other_user_avatar'] = Variable<String>(otherUserAvatar.value);
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<String>(lastMessage.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalChatThreadsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('otherUserId: $otherUserId, ')
          ..write('otherUserName: $otherUserName, ')
          ..write('otherUserAvatar: $otherUserAvatar, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalChatMessagesTable extends LocalChatMessages
    with TableInfo<$LocalChatMessagesTable, LocalChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta(
    'threadId',
  );
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    threadId,
    senderId,
    recipientId,
    content,
    type,
    status,
    metadata,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalChatMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(
        _threadIdMeta,
        threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta),
      );
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalChatMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      threadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalChatMessagesTable createAlias(String alias) {
    return $LocalChatMessagesTable(attachedDatabase, alias);
  }
}

class LocalChatMessage extends DataClass
    implements Insertable<LocalChatMessage> {
  final String id;
  final String threadId;
  final String senderId;
  final String recipientId;
  final String content;
  final String type;
  final String status;
  final String? metadata;
  final DateTime createdAt;
  final bool isSynced;
  const LocalChatMessage({
    required this.id,
    required this.threadId,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.type,
    required this.status,
    this.metadata,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['thread_id'] = Variable<String>(threadId);
    map['sender_id'] = Variable<String>(senderId);
    map['recipient_id'] = Variable<String>(recipientId);
    map['content'] = Variable<String>(content);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalChatMessagesCompanion(
      id: Value(id),
      threadId: Value(threadId),
      senderId: Value(senderId),
      recipientId: Value(recipientId),
      content: Value(content),
      type: Value(type),
      status: Value(status),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalChatMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalChatMessage(
      id: serializer.fromJson<String>(json['id']),
      threadId: serializer.fromJson<String>(json['threadId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      recipientId: serializer.fromJson<String>(json['recipientId']),
      content: serializer.fromJson<String>(json['content']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'threadId': serializer.toJson<String>(threadId),
      'senderId': serializer.toJson<String>(senderId),
      'recipientId': serializer.toJson<String>(recipientId),
      'content': serializer.toJson<String>(content),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalChatMessage copyWith({
    String? id,
    String? threadId,
    String? senderId,
    String? recipientId,
    String? content,
    String? type,
    String? status,
    Value<String?> metadata = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
  }) => LocalChatMessage(
    id: id ?? this.id,
    threadId: threadId ?? this.threadId,
    senderId: senderId ?? this.senderId,
    recipientId: recipientId ?? this.recipientId,
    content: content ?? this.content,
    type: type ?? this.type,
    status: status ?? this.status,
    metadata: metadata.present ? metadata.value : this.metadata,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalChatMessage copyWithCompanion(LocalChatMessagesCompanion data) {
    return LocalChatMessage(
      id: data.id.present ? data.id.value : this.id,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      content: data.content.present ? data.content.value : this.content,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalChatMessage(')
          ..write('id: $id, ')
          ..write('threadId: $threadId, ')
          ..write('senderId: $senderId, ')
          ..write('recipientId: $recipientId, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    threadId,
    senderId,
    recipientId,
    content,
    type,
    status,
    metadata,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalChatMessage &&
          other.id == this.id &&
          other.threadId == this.threadId &&
          other.senderId == this.senderId &&
          other.recipientId == this.recipientId &&
          other.content == this.content &&
          other.type == this.type &&
          other.status == this.status &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class LocalChatMessagesCompanion extends UpdateCompanion<LocalChatMessage> {
  final Value<String> id;
  final Value<String> threadId;
  final Value<String> senderId;
  final Value<String> recipientId;
  final Value<String> content;
  final Value<String> type;
  final Value<String> status;
  final Value<String?> metadata;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalChatMessagesCompanion({
    this.id = const Value.absent(),
    this.threadId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalChatMessagesCompanion.insert({
    required String id,
    required String threadId,
    required String senderId,
    required String recipientId,
    required String content,
    required String type,
    required String status,
    this.metadata = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       threadId = Value(threadId),
       senderId = Value(senderId),
       recipientId = Value(recipientId),
       content = Value(content),
       type = Value(type),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalChatMessage> custom({
    Expression<String>? id,
    Expression<String>? threadId,
    Expression<String>? senderId,
    Expression<String>? recipientId,
    Expression<String>? content,
    Expression<String>? type,
    Expression<String>? status,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (threadId != null) 'thread_id': threadId,
      if (senderId != null) 'sender_id': senderId,
      if (recipientId != null) 'recipient_id': recipientId,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalChatMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? threadId,
    Value<String>? senderId,
    Value<String>? recipientId,
    Value<String>? content,
    Value<String>? type,
    Value<String>? status,
    Value<String?>? metadata,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalChatMessagesCompanion(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('threadId: $threadId, ')
          ..write('senderId: $senderId, ')
          ..write('recipientId: $recipientId, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalContactsTable extends LocalContacts
    with TableInfo<$LocalContactsTable, LocalContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactUserIdMeta = const VerificationMeta(
    'contactUserId',
  );
  @override
  late final GeneratedColumn<String> contactUserId = GeneratedColumn<String>(
    'contact_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    contactUserId,
    displayName,
    username,
    avatarUrl,
    phoneNumber,
    status,
    isFavorite,
    nickname,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalContact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('contact_user_id')) {
      context.handle(
        _contactUserIdMeta,
        contactUserId.isAcceptableOrUnknown(
          data['contact_user_id']!,
          _contactUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactUserIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalContact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      contactUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_user_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalContactsTable createAlias(String alias) {
    return $LocalContactsTable(attachedDatabase, alias);
  }
}

class LocalContact extends DataClass implements Insertable<LocalContact> {
  final String id;
  final String userId;
  final String contactUserId;
  final String displayName;
  final String? username;
  final String? avatarUrl;
  final String? phoneNumber;
  final String status;
  final bool isFavorite;
  final String? nickname;
  final DateTime createdAt;
  final bool isSynced;
  const LocalContact({
    required this.id,
    required this.userId,
    required this.contactUserId,
    required this.displayName,
    this.username,
    this.avatarUrl,
    this.phoneNumber,
    required this.status,
    required this.isFavorite,
    this.nickname,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['contact_user_id'] = Variable<String>(contactUserId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['status'] = Variable<String>(status);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalContactsCompanion toCompanion(bool nullToAbsent) {
    return LocalContactsCompanion(
      id: Value(id),
      userId: Value(userId),
      contactUserId: Value(contactUserId),
      displayName: Value(displayName),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      status: Value(status),
      isFavorite: Value(isFavorite),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalContact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalContact(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      contactUserId: serializer.fromJson<String>(json['contactUserId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      username: serializer.fromJson<String?>(json['username']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      status: serializer.fromJson<String>(json['status']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'contactUserId': serializer.toJson<String>(contactUserId),
      'displayName': serializer.toJson<String>(displayName),
      'username': serializer.toJson<String?>(username),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'status': serializer.toJson<String>(status),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'nickname': serializer.toJson<String?>(nickname),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalContact copyWith({
    String? id,
    String? userId,
    String? contactUserId,
    String? displayName,
    Value<String?> username = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    String? status,
    bool? isFavorite,
    Value<String?> nickname = const Value.absent(),
    DateTime? createdAt,
    bool? isSynced,
  }) => LocalContact(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    contactUserId: contactUserId ?? this.contactUserId,
    displayName: displayName ?? this.displayName,
    username: username.present ? username.value : this.username,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    status: status ?? this.status,
    isFavorite: isFavorite ?? this.isFavorite,
    nickname: nickname.present ? nickname.value : this.nickname,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalContact copyWithCompanion(LocalContactsCompanion data) {
    return LocalContact(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      contactUserId: data.contactUserId.present
          ? data.contactUserId.value
          : this.contactUserId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      username: data.username.present ? data.username.value : this.username,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      status: data.status.present ? data.status.value : this.status,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalContact(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contactUserId: $contactUserId, ')
          ..write('displayName: $displayName, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('status: $status, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('nickname: $nickname, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    contactUserId,
    displayName,
    username,
    avatarUrl,
    phoneNumber,
    status,
    isFavorite,
    nickname,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalContact &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.contactUserId == this.contactUserId &&
          other.displayName == this.displayName &&
          other.username == this.username &&
          other.avatarUrl == this.avatarUrl &&
          other.phoneNumber == this.phoneNumber &&
          other.status == this.status &&
          other.isFavorite == this.isFavorite &&
          other.nickname == this.nickname &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class LocalContactsCompanion extends UpdateCompanion<LocalContact> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> contactUserId;
  final Value<String> displayName;
  final Value<String?> username;
  final Value<String?> avatarUrl;
  final Value<String?> phoneNumber;
  final Value<String> status;
  final Value<bool> isFavorite;
  final Value<String?> nickname;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const LocalContactsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.contactUserId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.nickname = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalContactsCompanion.insert({
    required String id,
    required String userId,
    required String contactUserId,
    required String displayName,
    this.username = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    required String status,
    this.isFavorite = const Value.absent(),
    this.nickname = const Value.absent(),
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       contactUserId = Value(contactUserId),
       displayName = Value(displayName),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalContact> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? contactUserId,
    Expression<String>? displayName,
    Expression<String>? username,
    Expression<String>? avatarUrl,
    Expression<String>? phoneNumber,
    Expression<String>? status,
    Expression<bool>? isFavorite,
    Expression<String>? nickname,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (contactUserId != null) 'contact_user_id': contactUserId,
      if (displayName != null) 'display_name': displayName,
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (status != null) 'status': status,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (nickname != null) 'nickname': nickname,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalContactsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? contactUserId,
    Value<String>? displayName,
    Value<String?>? username,
    Value<String?>? avatarUrl,
    Value<String?>? phoneNumber,
    Value<String>? status,
    Value<bool>? isFavorite,
    Value<String?>? nickname,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return LocalContactsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      contactUserId: contactUserId ?? this.contactUserId,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      nickname: nickname ?? this.nickname,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (contactUserId.present) {
      map['contact_user_id'] = Variable<String>(contactUserId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalContactsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contactUserId: $contactUserId, ')
          ..write('displayName: $displayName, ')
          ..write('username: $username, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('status: $status, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('nickname: $nickname, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPendingChangesTable extends LocalPendingChanges
    with TableInfo<$LocalPendingChangesTable, LocalPendingChange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPendingChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTableMeta = const VerificationMeta(
    'entityTable',
  );
  @override
  late final GeneratedColumn<String> entityTable = GeneratedColumn<String>(
    'entity_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeTypeMeta = const VerificationMeta(
    'changeType',
  );
  @override
  late final GeneratedColumn<String> changeType = GeneratedColumn<String>(
    'change_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeDataMeta = const VerificationMeta(
    'changeData',
  );
  @override
  late final GeneratedColumn<String> changeData = GeneratedColumn<String>(
    'change_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityTable,
    recordId,
    changeType,
    changeData,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_pending_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPendingChange> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_table')) {
      context.handle(
        _entityTableMeta,
        entityTable.isAcceptableOrUnknown(
          data['entity_table']!,
          _entityTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entityTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('change_type')) {
      context.handle(
        _changeTypeMeta,
        changeType.isAcceptableOrUnknown(data['change_type']!, _changeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeTypeMeta);
    }
    if (data.containsKey('change_data')) {
      context.handle(
        _changeDataMeta,
        changeData.isAcceptableOrUnknown(data['change_data']!, _changeDataMeta),
      );
    } else if (isInserting) {
      context.missing(_changeDataMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPendingChange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPendingChange(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      changeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_type'],
      )!,
      changeData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_data'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $LocalPendingChangesTable createAlias(String alias) {
    return $LocalPendingChangesTable(attachedDatabase, alias);
  }
}

class LocalPendingChange extends DataClass
    implements Insertable<LocalPendingChange> {
  final int id;
  final String entityTable;
  final String recordId;
  final String changeType;
  final String changeData;
  final DateTime createdAt;
  final bool isSynced;
  const LocalPendingChange({
    required this.id,
    required this.entityTable,
    required this.recordId,
    required this.changeType,
    required this.changeData,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_table'] = Variable<String>(entityTable);
    map['record_id'] = Variable<String>(recordId);
    map['change_type'] = Variable<String>(changeType);
    map['change_data'] = Variable<String>(changeData);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  LocalPendingChangesCompanion toCompanion(bool nullToAbsent) {
    return LocalPendingChangesCompanion(
      id: Value(id),
      entityTable: Value(entityTable),
      recordId: Value(recordId),
      changeType: Value(changeType),
      changeData: Value(changeData),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory LocalPendingChange.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPendingChange(
      id: serializer.fromJson<int>(json['id']),
      entityTable: serializer.fromJson<String>(json['entityTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      changeType: serializer.fromJson<String>(json['changeType']),
      changeData: serializer.fromJson<String>(json['changeData']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityTable': serializer.toJson<String>(entityTable),
      'recordId': serializer.toJson<String>(recordId),
      'changeType': serializer.toJson<String>(changeType),
      'changeData': serializer.toJson<String>(changeData),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  LocalPendingChange copyWith({
    int? id,
    String? entityTable,
    String? recordId,
    String? changeType,
    String? changeData,
    DateTime? createdAt,
    bool? isSynced,
  }) => LocalPendingChange(
    id: id ?? this.id,
    entityTable: entityTable ?? this.entityTable,
    recordId: recordId ?? this.recordId,
    changeType: changeType ?? this.changeType,
    changeData: changeData ?? this.changeData,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  LocalPendingChange copyWithCompanion(LocalPendingChangesCompanion data) {
    return LocalPendingChange(
      id: data.id.present ? data.id.value : this.id,
      entityTable: data.entityTable.present
          ? data.entityTable.value
          : this.entityTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      changeType: data.changeType.present
          ? data.changeType.value
          : this.changeType,
      changeData: data.changeData.present
          ? data.changeData.value
          : this.changeData,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPendingChange(')
          ..write('id: $id, ')
          ..write('entityTable: $entityTable, ')
          ..write('recordId: $recordId, ')
          ..write('changeType: $changeType, ')
          ..write('changeData: $changeData, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityTable,
    recordId,
    changeType,
    changeData,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPendingChange &&
          other.id == this.id &&
          other.entityTable == this.entityTable &&
          other.recordId == this.recordId &&
          other.changeType == this.changeType &&
          other.changeData == this.changeData &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class LocalPendingChangesCompanion extends UpdateCompanion<LocalPendingChange> {
  final Value<int> id;
  final Value<String> entityTable;
  final Value<String> recordId;
  final Value<String> changeType;
  final Value<String> changeData;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  const LocalPendingChangesCompanion({
    this.id = const Value.absent(),
    this.entityTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.changeType = const Value.absent(),
    this.changeData = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  LocalPendingChangesCompanion.insert({
    this.id = const Value.absent(),
    required String entityTable,
    required String recordId,
    required String changeType,
    required String changeData,
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
  }) : entityTable = Value(entityTable),
       recordId = Value(recordId),
       changeType = Value(changeType),
       changeData = Value(changeData),
       createdAt = Value(createdAt);
  static Insertable<LocalPendingChange> custom({
    Expression<int>? id,
    Expression<String>? entityTable,
    Expression<String>? recordId,
    Expression<String>? changeType,
    Expression<String>? changeData,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityTable != null) 'entity_table': entityTable,
      if (recordId != null) 'record_id': recordId,
      if (changeType != null) 'change_type': changeType,
      if (changeData != null) 'change_data': changeData,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  LocalPendingChangesCompanion copyWith({
    Value<int>? id,
    Value<String>? entityTable,
    Value<String>? recordId,
    Value<String>? changeType,
    Value<String>? changeData,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
  }) {
    return LocalPendingChangesCompanion(
      id: id ?? this.id,
      entityTable: entityTable ?? this.entityTable,
      recordId: recordId ?? this.recordId,
      changeType: changeType ?? this.changeType,
      changeData: changeData ?? this.changeData,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityTable.present) {
      map['entity_table'] = Variable<String>(entityTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (changeType.present) {
      map['change_type'] = Variable<String>(changeType.value);
    }
    if (changeData.present) {
      map['change_data'] = Variable<String>(changeData.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPendingChangesCompanion(')
          ..write('id: $id, ')
          ..write('entityTable: $entityTable, ')
          ..write('recordId: $recordId, ')
          ..write('changeType: $changeType, ')
          ..write('changeData: $changeData, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $LocalSyncMetadataTable extends LocalSyncMetadata
    with TableInfo<$LocalSyncMetadataTable, LocalSyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  LocalSyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalSyncMetadataTable createAlias(String alias) {
    return $LocalSyncMetadataTable(attachedDatabase, alias);
  }
}

class LocalSyncMetadataData extends DataClass
    implements Insertable<LocalSyncMetadataData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const LocalSyncMetadataData({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalSyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return LocalSyncMetadataCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalSyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalSyncMetadataData copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => LocalSyncMetadataData(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalSyncMetadataData copyWithCompanion(LocalSyncMetadataCompanion data) {
    return LocalSyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSyncMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class LocalSyncMetadataCompanion
    extends UpdateCompanion<LocalSyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalSyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSyncMetadataCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalSyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DecryptedMessageCacheTable extends DecryptedMessageCache
    with TableInfo<$DecryptedMessageCacheTable, DecryptedMessageCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecryptedMessageCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plaintextMeta = const VerificationMeta(
    'plaintext',
  );
  @override
  late final GeneratedColumn<String> plaintext = GeneratedColumn<String>(
    'plaintext',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [messageId, plaintext, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decrypted_message_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<DecryptedMessageCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('plaintext')) {
      context.handle(
        _plaintextMeta,
        plaintext.isAcceptableOrUnknown(data['plaintext']!, _plaintextMeta),
      );
    } else if (isInserting) {
      context.missing(_plaintextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  DecryptedMessageCacheData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DecryptedMessageCacheData(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      plaintext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plaintext'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DecryptedMessageCacheTable createAlias(String alias) {
    return $DecryptedMessageCacheTable(attachedDatabase, alias);
  }
}

class DecryptedMessageCacheData extends DataClass
    implements Insertable<DecryptedMessageCacheData> {
  final String messageId;
  final String plaintext;
  final DateTime createdAt;
  const DecryptedMessageCacheData({
    required this.messageId,
    required this.plaintext,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['plaintext'] = Variable<String>(plaintext);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DecryptedMessageCacheCompanion toCompanion(bool nullToAbsent) {
    return DecryptedMessageCacheCompanion(
      messageId: Value(messageId),
      plaintext: Value(plaintext),
      createdAt: Value(createdAt),
    );
  }

  factory DecryptedMessageCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DecryptedMessageCacheData(
      messageId: serializer.fromJson<String>(json['messageId']),
      plaintext: serializer.fromJson<String>(json['plaintext']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'plaintext': serializer.toJson<String>(plaintext),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DecryptedMessageCacheData copyWith({
    String? messageId,
    String? plaintext,
    DateTime? createdAt,
  }) => DecryptedMessageCacheData(
    messageId: messageId ?? this.messageId,
    plaintext: plaintext ?? this.plaintext,
    createdAt: createdAt ?? this.createdAt,
  );
  DecryptedMessageCacheData copyWithCompanion(
    DecryptedMessageCacheCompanion data,
  ) {
    return DecryptedMessageCacheData(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      plaintext: data.plaintext.present ? data.plaintext.value : this.plaintext,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DecryptedMessageCacheData(')
          ..write('messageId: $messageId, ')
          ..write('plaintext: $plaintext, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(messageId, plaintext, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecryptedMessageCacheData &&
          other.messageId == this.messageId &&
          other.plaintext == this.plaintext &&
          other.createdAt == this.createdAt);
}

class DecryptedMessageCacheCompanion
    extends UpdateCompanion<DecryptedMessageCacheData> {
  final Value<String> messageId;
  final Value<String> plaintext;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DecryptedMessageCacheCompanion({
    this.messageId = const Value.absent(),
    this.plaintext = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DecryptedMessageCacheCompanion.insert({
    required String messageId,
    required String plaintext,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       plaintext = Value(plaintext),
       createdAt = Value(createdAt);
  static Insertable<DecryptedMessageCacheData> custom({
    Expression<String>? messageId,
    Expression<String>? plaintext,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (plaintext != null) 'plaintext': plaintext,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DecryptedMessageCacheCompanion copyWith({
    Value<String>? messageId,
    Value<String>? plaintext,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DecryptedMessageCacheCompanion(
      messageId: messageId ?? this.messageId,
      plaintext: plaintext ?? this.plaintext,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (plaintext.present) {
      map['plaintext'] = Variable<String>(plaintext.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecryptedMessageCacheCompanion(')
          ..write('messageId: $messageId, ')
          ..write('plaintext: $plaintext, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalWalletsTable localWallets = $LocalWalletsTable(this);
  late final $LocalTransactionsTable localTransactions =
      $LocalTransactionsTable(this);
  late final $LocalEarnThreadsTable localEarnThreads = $LocalEarnThreadsTable(
    this,
  );
  late final $LocalChatThreadsTable localChatThreads = $LocalChatThreadsTable(
    this,
  );
  late final $LocalChatMessagesTable localChatMessages =
      $LocalChatMessagesTable(this);
  late final $LocalContactsTable localContacts = $LocalContactsTable(this);
  late final $LocalPendingChangesTable localPendingChanges =
      $LocalPendingChangesTable(this);
  late final $LocalSyncMetadataTable localSyncMetadata =
      $LocalSyncMetadataTable(this);
  late final $DecryptedMessageCacheTable decryptedMessageCache =
      $DecryptedMessageCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localWallets,
    localTransactions,
    localEarnThreads,
    localChatThreads,
    localChatMessages,
    localContacts,
    localPendingChanges,
    localSyncMetadata,
    decryptedMessageCache,
  ];
}

typedef $$LocalWalletsTableCreateCompanionBuilder =
    LocalWalletsCompanion Function({
      required String id,
      required String userId,
      Value<int> tokenBalance,
      Value<int> pendingBalance,
      Value<int> lifetimeEarned,
      Value<int> lifetimeWithdrawn,
      Value<int> todayEarned,
      Value<int> pendingWithdrawal,
      Value<DateTime?> lastEarnedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalWalletsTableUpdateCompanionBuilder =
    LocalWalletsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<int> tokenBalance,
      Value<int> pendingBalance,
      Value<int> lifetimeEarned,
      Value<int> lifetimeWithdrawn,
      Value<int> todayEarned,
      Value<int> pendingWithdrawal,
      Value<DateTime?> lastEarnedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalWalletsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pendingBalance => $composableBuilder(
    column: $table.pendingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeEarned => $composableBuilder(
    column: $table.lifetimeEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeWithdrawn => $composableBuilder(
    column: $table.lifetimeWithdrawn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get todayEarned => $composableBuilder(
    column: $table.todayEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pendingWithdrawal => $composableBuilder(
    column: $table.pendingWithdrawal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEarnedAt => $composableBuilder(
    column: $table.lastEarnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalWalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pendingBalance => $composableBuilder(
    column: $table.pendingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeEarned => $composableBuilder(
    column: $table.lifetimeEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeWithdrawn => $composableBuilder(
    column: $table.lifetimeWithdrawn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get todayEarned => $composableBuilder(
    column: $table.todayEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pendingWithdrawal => $composableBuilder(
    column: $table.pendingWithdrawal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEarnedAt => $composableBuilder(
    column: $table.lastEarnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalWalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pendingBalance => $composableBuilder(
    column: $table.pendingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lifetimeEarned => $composableBuilder(
    column: $table.lifetimeEarned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lifetimeWithdrawn => $composableBuilder(
    column: $table.lifetimeWithdrawn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get todayEarned => $composableBuilder(
    column: $table.todayEarned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pendingWithdrawal => $composableBuilder(
    column: $table.pendingWithdrawal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastEarnedAt => $composableBuilder(
    column: $table.lastEarnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalWalletsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalWalletsTable,
          LocalWallet,
          $$LocalWalletsTableFilterComposer,
          $$LocalWalletsTableOrderingComposer,
          $$LocalWalletsTableAnnotationComposer,
          $$LocalWalletsTableCreateCompanionBuilder,
          $$LocalWalletsTableUpdateCompanionBuilder,
          (
            LocalWallet,
            BaseReferences<_$AppDatabase, $LocalWalletsTable, LocalWallet>,
          ),
          LocalWallet,
          PrefetchHooks Function()
        > {
  $$LocalWalletsTableTableManager(_$AppDatabase db, $LocalWalletsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> tokenBalance = const Value.absent(),
                Value<int> pendingBalance = const Value.absent(),
                Value<int> lifetimeEarned = const Value.absent(),
                Value<int> lifetimeWithdrawn = const Value.absent(),
                Value<int> todayEarned = const Value.absent(),
                Value<int> pendingWithdrawal = const Value.absent(),
                Value<DateTime?> lastEarnedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalWalletsCompanion(
                id: id,
                userId: userId,
                tokenBalance: tokenBalance,
                pendingBalance: pendingBalance,
                lifetimeEarned: lifetimeEarned,
                lifetimeWithdrawn: lifetimeWithdrawn,
                todayEarned: todayEarned,
                pendingWithdrawal: pendingWithdrawal,
                lastEarnedAt: lastEarnedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<int> tokenBalance = const Value.absent(),
                Value<int> pendingBalance = const Value.absent(),
                Value<int> lifetimeEarned = const Value.absent(),
                Value<int> lifetimeWithdrawn = const Value.absent(),
                Value<int> todayEarned = const Value.absent(),
                Value<int> pendingWithdrawal = const Value.absent(),
                Value<DateTime?> lastEarnedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalWalletsCompanion.insert(
                id: id,
                userId: userId,
                tokenBalance: tokenBalance,
                pendingBalance: pendingBalance,
                lifetimeEarned: lifetimeEarned,
                lifetimeWithdrawn: lifetimeWithdrawn,
                todayEarned: todayEarned,
                pendingWithdrawal: pendingWithdrawal,
                lastEarnedAt: lastEarnedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalWalletsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalWalletsTable,
      LocalWallet,
      $$LocalWalletsTableFilterComposer,
      $$LocalWalletsTableOrderingComposer,
      $$LocalWalletsTableAnnotationComposer,
      $$LocalWalletsTableCreateCompanionBuilder,
      $$LocalWalletsTableUpdateCompanionBuilder,
      (
        LocalWallet,
        BaseReferences<_$AppDatabase, $LocalWalletsTable, LocalWallet>,
      ),
      LocalWallet,
      PrefetchHooks Function()
    >;
typedef $$LocalTransactionsTableCreateCompanionBuilder =
    LocalTransactionsCompanion Function({
      required String id,
      required String walletId,
      required String userId,
      required String type,
      Value<String?> subType,
      required int tokenAmount,
      required double zarAmount,
      required String description,
      required String status,
      Value<String?> referenceId,
      Value<String?> referenceType,
      Value<String?> metadata,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalTransactionsTableUpdateCompanionBuilder =
    LocalTransactionsCompanion Function({
      Value<String> id,
      Value<String> walletId,
      Value<String> userId,
      Value<String> type,
      Value<String?> subType,
      Value<int> tokenAmount,
      Value<double> zarAmount,
      Value<String> description,
      Value<String> status,
      Value<String?> referenceId,
      Value<String?> referenceType,
      Value<String?> metadata,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zarAmount => $composableBuilder(
    column: $table.zarAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletId => $composableBuilder(
    column: $table.walletId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zarAmount => $composableBuilder(
    column: $table.zarAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get walletId =>
      $composableBuilder(column: $table.walletId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get subType =>
      $composableBuilder(column: $table.subType, builder: (column) => column);

  GeneratedColumn<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get zarAmount =>
      $composableBuilder(column: $table.zarAmount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalTransactionsTable,
          LocalTransaction,
          $$LocalTransactionsTableFilterComposer,
          $$LocalTransactionsTableOrderingComposer,
          $$LocalTransactionsTableAnnotationComposer,
          $$LocalTransactionsTableCreateCompanionBuilder,
          $$LocalTransactionsTableUpdateCompanionBuilder,
          (
            LocalTransaction,
            BaseReferences<
              _$AppDatabase,
              $LocalTransactionsTable,
              LocalTransaction
            >,
          ),
          LocalTransaction,
          PrefetchHooks Function()
        > {
  $$LocalTransactionsTableTableManager(
    _$AppDatabase db,
    $LocalTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> walletId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> subType = const Value.absent(),
                Value<int> tokenAmount = const Value.absent(),
                Value<double> zarAmount = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion(
                id: id,
                walletId: walletId,
                userId: userId,
                type: type,
                subType: subType,
                tokenAmount: tokenAmount,
                zarAmount: zarAmount,
                description: description,
                status: status,
                referenceId: referenceId,
                referenceType: referenceType,
                metadata: metadata,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String walletId,
                required String userId,
                required String type,
                Value<String?> subType = const Value.absent(),
                required int tokenAmount,
                required double zarAmount,
                required String description,
                required String status,
                Value<String?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion.insert(
                id: id,
                walletId: walletId,
                userId: userId,
                type: type,
                subType: subType,
                tokenAmount: tokenAmount,
                zarAmount: zarAmount,
                description: description,
                status: status,
                referenceId: referenceId,
                referenceType: referenceType,
                metadata: metadata,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalTransactionsTable,
      LocalTransaction,
      $$LocalTransactionsTableFilterComposer,
      $$LocalTransactionsTableOrderingComposer,
      $$LocalTransactionsTableAnnotationComposer,
      $$LocalTransactionsTableCreateCompanionBuilder,
      $$LocalTransactionsTableUpdateCompanionBuilder,
      (
        LocalTransaction,
        BaseReferences<
          _$AppDatabase,
          $LocalTransactionsTable,
          LocalTransaction
        >,
      ),
      LocalTransaction,
      PrefetchHooks Function()
    >;
typedef $$LocalEarnThreadsTableCreateCompanionBuilder =
    LocalEarnThreadsCompanion Function({
      required String id,
      required String userId,
      required String campaignId,
      required String campaignName,
      required String type,
      required String status,
      required int rewardAmount,
      Value<String?> thumbnailUrl,
      Value<int> progress,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> expiresAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalEarnThreadsTableUpdateCompanionBuilder =
    LocalEarnThreadsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> campaignId,
      Value<String> campaignName,
      Value<String> type,
      Value<String> status,
      Value<int> rewardAmount,
      Value<String?> thumbnailUrl,
      Value<int> progress,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime?> expiresAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalEarnThreadsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalEarnThreadsTable> {
  $$LocalEarnThreadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campaignName => $composableBuilder(
    column: $table.campaignName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardAmount => $composableBuilder(
    column: $table.rewardAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalEarnThreadsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalEarnThreadsTable> {
  $$LocalEarnThreadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campaignName => $composableBuilder(
    column: $table.campaignName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardAmount => $composableBuilder(
    column: $table.rewardAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalEarnThreadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalEarnThreadsTable> {
  $$LocalEarnThreadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get campaignName => $composableBuilder(
    column: $table.campaignName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get rewardAmount => $composableBuilder(
    column: $table.rewardAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
    column: $table.thumbnailUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalEarnThreadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalEarnThreadsTable,
          LocalEarnThread,
          $$LocalEarnThreadsTableFilterComposer,
          $$LocalEarnThreadsTableOrderingComposer,
          $$LocalEarnThreadsTableAnnotationComposer,
          $$LocalEarnThreadsTableCreateCompanionBuilder,
          $$LocalEarnThreadsTableUpdateCompanionBuilder,
          (
            LocalEarnThread,
            BaseReferences<
              _$AppDatabase,
              $LocalEarnThreadsTable,
              LocalEarnThread
            >,
          ),
          LocalEarnThread,
          PrefetchHooks Function()
        > {
  $$LocalEarnThreadsTableTableManager(
    _$AppDatabase db,
    $LocalEarnThreadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalEarnThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalEarnThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalEarnThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> campaignId = const Value.absent(),
                Value<String> campaignName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rewardAmount = const Value.absent(),
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalEarnThreadsCompanion(
                id: id,
                userId: userId,
                campaignId: campaignId,
                campaignName: campaignName,
                type: type,
                status: status,
                rewardAmount: rewardAmount,
                thumbnailUrl: thumbnailUrl,
                progress: progress,
                startedAt: startedAt,
                completedAt: completedAt,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String campaignId,
                required String campaignName,
                required String type,
                required String status,
                required int rewardAmount,
                Value<String?> thumbnailUrl = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalEarnThreadsCompanion.insert(
                id: id,
                userId: userId,
                campaignId: campaignId,
                campaignName: campaignName,
                type: type,
                status: status,
                rewardAmount: rewardAmount,
                thumbnailUrl: thumbnailUrl,
                progress: progress,
                startedAt: startedAt,
                completedAt: completedAt,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalEarnThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalEarnThreadsTable,
      LocalEarnThread,
      $$LocalEarnThreadsTableFilterComposer,
      $$LocalEarnThreadsTableOrderingComposer,
      $$LocalEarnThreadsTableAnnotationComposer,
      $$LocalEarnThreadsTableCreateCompanionBuilder,
      $$LocalEarnThreadsTableUpdateCompanionBuilder,
      (
        LocalEarnThread,
        BaseReferences<_$AppDatabase, $LocalEarnThreadsTable, LocalEarnThread>,
      ),
      LocalEarnThread,
      PrefetchHooks Function()
    >;
typedef $$LocalChatThreadsTableCreateCompanionBuilder =
    LocalChatThreadsCompanion Function({
      required String id,
      required String userId,
      required String otherUserId,
      required String otherUserName,
      Value<String?> otherUserAvatar,
      Value<String?> lastMessage,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalChatThreadsTableUpdateCompanionBuilder =
    LocalChatThreadsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> otherUserId,
      Value<String> otherUserName,
      Value<String?> otherUserAvatar,
      Value<String?> lastMessage,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalChatThreadsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalChatThreadsTable> {
  $$LocalChatThreadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUserId => $composableBuilder(
    column: $table.otherUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherUserAvatar => $composableBuilder(
    column: $table.otherUserAvatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalChatThreadsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalChatThreadsTable> {
  $$LocalChatThreadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUserId => $composableBuilder(
    column: $table.otherUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherUserAvatar => $composableBuilder(
    column: $table.otherUserAvatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalChatThreadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalChatThreadsTable> {
  $$LocalChatThreadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get otherUserId => $composableBuilder(
    column: $table.otherUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherUserName => $composableBuilder(
    column: $table.otherUserName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherUserAvatar => $composableBuilder(
    column: $table.otherUserAvatar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalChatThreadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalChatThreadsTable,
          LocalChatThread,
          $$LocalChatThreadsTableFilterComposer,
          $$LocalChatThreadsTableOrderingComposer,
          $$LocalChatThreadsTableAnnotationComposer,
          $$LocalChatThreadsTableCreateCompanionBuilder,
          $$LocalChatThreadsTableUpdateCompanionBuilder,
          (
            LocalChatThread,
            BaseReferences<
              _$AppDatabase,
              $LocalChatThreadsTable,
              LocalChatThread
            >,
          ),
          LocalChatThread,
          PrefetchHooks Function()
        > {
  $$LocalChatThreadsTableTableManager(
    _$AppDatabase db,
    $LocalChatThreadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalChatThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalChatThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalChatThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> otherUserId = const Value.absent(),
                Value<String> otherUserName = const Value.absent(),
                Value<String?> otherUserAvatar = const Value.absent(),
                Value<String?> lastMessage = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalChatThreadsCompanion(
                id: id,
                userId: userId,
                otherUserId: otherUserId,
                otherUserName: otherUserName,
                otherUserAvatar: otherUserAvatar,
                lastMessage: lastMessage,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String otherUserId,
                required String otherUserName,
                Value<String?> otherUserAvatar = const Value.absent(),
                Value<String?> lastMessage = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalChatThreadsCompanion.insert(
                id: id,
                userId: userId,
                otherUserId: otherUserId,
                otherUserName: otherUserName,
                otherUserAvatar: otherUserAvatar,
                lastMessage: lastMessage,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalChatThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalChatThreadsTable,
      LocalChatThread,
      $$LocalChatThreadsTableFilterComposer,
      $$LocalChatThreadsTableOrderingComposer,
      $$LocalChatThreadsTableAnnotationComposer,
      $$LocalChatThreadsTableCreateCompanionBuilder,
      $$LocalChatThreadsTableUpdateCompanionBuilder,
      (
        LocalChatThread,
        BaseReferences<_$AppDatabase, $LocalChatThreadsTable, LocalChatThread>,
      ),
      LocalChatThread,
      PrefetchHooks Function()
    >;
typedef $$LocalChatMessagesTableCreateCompanionBuilder =
    LocalChatMessagesCompanion Function({
      required String id,
      required String threadId,
      required String senderId,
      required String recipientId,
      required String content,
      required String type,
      required String status,
      Value<String?> metadata,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalChatMessagesTableUpdateCompanionBuilder =
    LocalChatMessagesCompanion Function({
      Value<String> id,
      Value<String> threadId,
      Value<String> senderId,
      Value<String> recipientId,
      Value<String> content,
      Value<String> type,
      Value<String> status,
      Value<String?> metadata,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalChatMessagesTable> {
  $$LocalChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalChatMessagesTable> {
  $$LocalChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalChatMessagesTable> {
  $$LocalChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalChatMessagesTable,
          LocalChatMessage,
          $$LocalChatMessagesTableFilterComposer,
          $$LocalChatMessagesTableOrderingComposer,
          $$LocalChatMessagesTableAnnotationComposer,
          $$LocalChatMessagesTableCreateCompanionBuilder,
          $$LocalChatMessagesTableUpdateCompanionBuilder,
          (
            LocalChatMessage,
            BaseReferences<
              _$AppDatabase,
              $LocalChatMessagesTable,
              LocalChatMessage
            >,
          ),
          LocalChatMessage,
          PrefetchHooks Function()
        > {
  $$LocalChatMessagesTableTableManager(
    _$AppDatabase db,
    $LocalChatMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalChatMessagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> threadId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> recipientId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalChatMessagesCompanion(
                id: id,
                threadId: threadId,
                senderId: senderId,
                recipientId: recipientId,
                content: content,
                type: type,
                status: status,
                metadata: metadata,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String threadId,
                required String senderId,
                required String recipientId,
                required String content,
                required String type,
                required String status,
                Value<String?> metadata = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalChatMessagesCompanion.insert(
                id: id,
                threadId: threadId,
                senderId: senderId,
                recipientId: recipientId,
                content: content,
                type: type,
                status: status,
                metadata: metadata,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalChatMessagesTable,
      LocalChatMessage,
      $$LocalChatMessagesTableFilterComposer,
      $$LocalChatMessagesTableOrderingComposer,
      $$LocalChatMessagesTableAnnotationComposer,
      $$LocalChatMessagesTableCreateCompanionBuilder,
      $$LocalChatMessagesTableUpdateCompanionBuilder,
      (
        LocalChatMessage,
        BaseReferences<
          _$AppDatabase,
          $LocalChatMessagesTable,
          LocalChatMessage
        >,
      ),
      LocalChatMessage,
      PrefetchHooks Function()
    >;
typedef $$LocalContactsTableCreateCompanionBuilder =
    LocalContactsCompanion Function({
      required String id,
      required String userId,
      required String contactUserId,
      required String displayName,
      Value<String?> username,
      Value<String?> avatarUrl,
      Value<String?> phoneNumber,
      required String status,
      Value<bool> isFavorite,
      Value<String?> nickname,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$LocalContactsTableUpdateCompanionBuilder =
    LocalContactsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> contactUserId,
      Value<String> displayName,
      Value<String?> username,
      Value<String?> avatarUrl,
      Value<String?> phoneNumber,
      Value<String> status,
      Value<bool> isFavorite,
      Value<String?> nickname,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$LocalContactsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalContactsTable> {
  $$LocalContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactUserId => $composableBuilder(
    column: $table.contactUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalContactsTable> {
  $$LocalContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactUserId => $composableBuilder(
    column: $table.contactUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalContactsTable> {
  $$LocalContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get contactUserId => $composableBuilder(
    column: $table.contactUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalContactsTable,
          LocalContact,
          $$LocalContactsTableFilterComposer,
          $$LocalContactsTableOrderingComposer,
          $$LocalContactsTableAnnotationComposer,
          $$LocalContactsTableCreateCompanionBuilder,
          $$LocalContactsTableUpdateCompanionBuilder,
          (
            LocalContact,
            BaseReferences<_$AppDatabase, $LocalContactsTable, LocalContact>,
          ),
          LocalContact,
          PrefetchHooks Function()
        > {
  $$LocalContactsTableTableManager(_$AppDatabase db, $LocalContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> contactUserId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalContactsCompanion(
                id: id,
                userId: userId,
                contactUserId: contactUserId,
                displayName: displayName,
                username: username,
                avatarUrl: avatarUrl,
                phoneNumber: phoneNumber,
                status: status,
                isFavorite: isFavorite,
                nickname: nickname,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String contactUserId,
                required String displayName,
                Value<String?> username = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                required String status,
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalContactsCompanion.insert(
                id: id,
                userId: userId,
                contactUserId: contactUserId,
                displayName: displayName,
                username: username,
                avatarUrl: avatarUrl,
                phoneNumber: phoneNumber,
                status: status,
                isFavorite: isFavorite,
                nickname: nickname,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalContactsTable,
      LocalContact,
      $$LocalContactsTableFilterComposer,
      $$LocalContactsTableOrderingComposer,
      $$LocalContactsTableAnnotationComposer,
      $$LocalContactsTableCreateCompanionBuilder,
      $$LocalContactsTableUpdateCompanionBuilder,
      (
        LocalContact,
        BaseReferences<_$AppDatabase, $LocalContactsTable, LocalContact>,
      ),
      LocalContact,
      PrefetchHooks Function()
    >;
typedef $$LocalPendingChangesTableCreateCompanionBuilder =
    LocalPendingChangesCompanion Function({
      Value<int> id,
      required String entityTable,
      required String recordId,
      required String changeType,
      required String changeData,
      required DateTime createdAt,
      Value<bool> isSynced,
    });
typedef $$LocalPendingChangesTableUpdateCompanionBuilder =
    LocalPendingChangesCompanion Function({
      Value<int> id,
      Value<String> entityTable,
      Value<String> recordId,
      Value<String> changeType,
      Value<String> changeData,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
    });

class $$LocalPendingChangesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPendingChangesTable> {
  $$LocalPendingChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeData => $composableBuilder(
    column: $table.changeData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPendingChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPendingChangesTable> {
  $$LocalPendingChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeData => $composableBuilder(
    column: $table.changeData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPendingChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPendingChangesTable> {
  $$LocalPendingChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityTable => $composableBuilder(
    column: $table.entityTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get changeType => $composableBuilder(
    column: $table.changeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeData => $composableBuilder(
    column: $table.changeData,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$LocalPendingChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPendingChangesTable,
          LocalPendingChange,
          $$LocalPendingChangesTableFilterComposer,
          $$LocalPendingChangesTableOrderingComposer,
          $$LocalPendingChangesTableAnnotationComposer,
          $$LocalPendingChangesTableCreateCompanionBuilder,
          $$LocalPendingChangesTableUpdateCompanionBuilder,
          (
            LocalPendingChange,
            BaseReferences<
              _$AppDatabase,
              $LocalPendingChangesTable,
              LocalPendingChange
            >,
          ),
          LocalPendingChange,
          PrefetchHooks Function()
        > {
  $$LocalPendingChangesTableTableManager(
    _$AppDatabase db,
    $LocalPendingChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPendingChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPendingChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalPendingChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityTable = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> changeType = const Value.absent(),
                Value<String> changeData = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => LocalPendingChangesCompanion(
                id: id,
                entityTable: entityTable,
                recordId: recordId,
                changeType: changeType,
                changeData: changeData,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityTable,
                required String recordId,
                required String changeType,
                required String changeData,
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
              }) => LocalPendingChangesCompanion.insert(
                id: id,
                entityTable: entityTable,
                recordId: recordId,
                changeType: changeType,
                changeData: changeData,
                createdAt: createdAt,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPendingChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPendingChangesTable,
      LocalPendingChange,
      $$LocalPendingChangesTableFilterComposer,
      $$LocalPendingChangesTableOrderingComposer,
      $$LocalPendingChangesTableAnnotationComposer,
      $$LocalPendingChangesTableCreateCompanionBuilder,
      $$LocalPendingChangesTableUpdateCompanionBuilder,
      (
        LocalPendingChange,
        BaseReferences<
          _$AppDatabase,
          $LocalPendingChangesTable,
          LocalPendingChange
        >,
      ),
      LocalPendingChange,
      PrefetchHooks Function()
    >;
typedef $$LocalSyncMetadataTableCreateCompanionBuilder =
    LocalSyncMetadataCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LocalSyncMetadataTableUpdateCompanionBuilder =
    LocalSyncMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocalSyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSyncMetadataTable> {
  $$LocalSyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSyncMetadataTable> {
  $$LocalSyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSyncMetadataTable> {
  $$LocalSyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalSyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSyncMetadataTable,
          LocalSyncMetadataData,
          $$LocalSyncMetadataTableFilterComposer,
          $$LocalSyncMetadataTableOrderingComposer,
          $$LocalSyncMetadataTableAnnotationComposer,
          $$LocalSyncMetadataTableCreateCompanionBuilder,
          $$LocalSyncMetadataTableUpdateCompanionBuilder,
          (
            LocalSyncMetadataData,
            BaseReferences<
              _$AppDatabase,
              $LocalSyncMetadataTable,
              LocalSyncMetadataData
            >,
          ),
          LocalSyncMetadataData,
          PrefetchHooks Function()
        > {
  $$LocalSyncMetadataTableTableManager(
    _$AppDatabase db,
    $LocalSyncMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSyncMetadataTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSyncMetadataCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalSyncMetadataCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSyncMetadataTable,
      LocalSyncMetadataData,
      $$LocalSyncMetadataTableFilterComposer,
      $$LocalSyncMetadataTableOrderingComposer,
      $$LocalSyncMetadataTableAnnotationComposer,
      $$LocalSyncMetadataTableCreateCompanionBuilder,
      $$LocalSyncMetadataTableUpdateCompanionBuilder,
      (
        LocalSyncMetadataData,
        BaseReferences<
          _$AppDatabase,
          $LocalSyncMetadataTable,
          LocalSyncMetadataData
        >,
      ),
      LocalSyncMetadataData,
      PrefetchHooks Function()
    >;
typedef $$DecryptedMessageCacheTableCreateCompanionBuilder =
    DecryptedMessageCacheCompanion Function({
      required String messageId,
      required String plaintext,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DecryptedMessageCacheTableUpdateCompanionBuilder =
    DecryptedMessageCacheCompanion Function({
      Value<String> messageId,
      Value<String> plaintext,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DecryptedMessageCacheTableFilterComposer
    extends Composer<_$AppDatabase, $DecryptedMessageCacheTable> {
  $$DecryptedMessageCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plaintext => $composableBuilder(
    column: $table.plaintext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DecryptedMessageCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $DecryptedMessageCacheTable> {
  $$DecryptedMessageCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plaintext => $composableBuilder(
    column: $table.plaintext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DecryptedMessageCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecryptedMessageCacheTable> {
  $$DecryptedMessageCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get plaintext =>
      $composableBuilder(column: $table.plaintext, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DecryptedMessageCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecryptedMessageCacheTable,
          DecryptedMessageCacheData,
          $$DecryptedMessageCacheTableFilterComposer,
          $$DecryptedMessageCacheTableOrderingComposer,
          $$DecryptedMessageCacheTableAnnotationComposer,
          $$DecryptedMessageCacheTableCreateCompanionBuilder,
          $$DecryptedMessageCacheTableUpdateCompanionBuilder,
          (
            DecryptedMessageCacheData,
            BaseReferences<
              _$AppDatabase,
              $DecryptedMessageCacheTable,
              DecryptedMessageCacheData
            >,
          ),
          DecryptedMessageCacheData,
          PrefetchHooks Function()
        > {
  $$DecryptedMessageCacheTableTableManager(
    _$AppDatabase db,
    $DecryptedMessageCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecryptedMessageCacheTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DecryptedMessageCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DecryptedMessageCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String> plaintext = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecryptedMessageCacheCompanion(
                messageId: messageId,
                plaintext: plaintext,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                required String plaintext,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DecryptedMessageCacheCompanion.insert(
                messageId: messageId,
                plaintext: plaintext,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DecryptedMessageCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecryptedMessageCacheTable,
      DecryptedMessageCacheData,
      $$DecryptedMessageCacheTableFilterComposer,
      $$DecryptedMessageCacheTableOrderingComposer,
      $$DecryptedMessageCacheTableAnnotationComposer,
      $$DecryptedMessageCacheTableCreateCompanionBuilder,
      $$DecryptedMessageCacheTableUpdateCompanionBuilder,
      (
        DecryptedMessageCacheData,
        BaseReferences<
          _$AppDatabase,
          $DecryptedMessageCacheTable,
          DecryptedMessageCacheData
        >,
      ),
      DecryptedMessageCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalWalletsTableTableManager get localWallets =>
      $$LocalWalletsTableTableManager(_db, _db.localWallets);
  $$LocalTransactionsTableTableManager get localTransactions =>
      $$LocalTransactionsTableTableManager(_db, _db.localTransactions);
  $$LocalEarnThreadsTableTableManager get localEarnThreads =>
      $$LocalEarnThreadsTableTableManager(_db, _db.localEarnThreads);
  $$LocalChatThreadsTableTableManager get localChatThreads =>
      $$LocalChatThreadsTableTableManager(_db, _db.localChatThreads);
  $$LocalChatMessagesTableTableManager get localChatMessages =>
      $$LocalChatMessagesTableTableManager(_db, _db.localChatMessages);
  $$LocalContactsTableTableManager get localContacts =>
      $$LocalContactsTableTableManager(_db, _db.localContacts);
  $$LocalPendingChangesTableTableManager get localPendingChanges =>
      $$LocalPendingChangesTableTableManager(_db, _db.localPendingChanges);
  $$LocalSyncMetadataTableTableManager get localSyncMetadata =>
      $$LocalSyncMetadataTableTableManager(_db, _db.localSyncMetadata);
  $$DecryptedMessageCacheTableTableManager get decryptedMessageCache =>
      $$DecryptedMessageCacheTableTableManager(_db, _db.decryptedMessageCache);
}
