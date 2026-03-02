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

class $LocalFullMessagesTable extends LocalFullMessages
    with TableInfo<$LocalFullMessagesTable, LocalFullMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFullMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
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
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderAvatarUrlMeta = const VerificationMeta(
    'senderAvatarUrl',
  );
  @override
  late final GeneratedColumn<String> senderAvatarUrl = GeneratedColumn<String>(
    'sender_avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ledgerJournalIdMeta = const VerificationMeta(
    'ledgerJournalId',
  );
  @override
  late final GeneratedColumn<String> ledgerJournalId = GeneratedColumn<String>(
    'ledger_journal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaJsonMeta = const VerificationMeta(
    'mediaJson',
  );
  @override
  late final GeneratedColumn<String> mediaJson = GeneratedColumn<String>(
    'media_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reactionsJsonMeta = const VerificationMeta(
    'reactionsJson',
  );
  @override
  late final GeneratedColumn<String> reactionsJson = GeneratedColumn<String>(
    'reactions_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyToJsonMeta = const VerificationMeta(
    'replyToJson',
  );
  @override
  late final GeneratedColumn<String> replyToJson = GeneratedColumn<String>(
    'reply_to_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _giftJsonMeta = const VerificationMeta(
    'giftJson',
  );
  @override
  late final GeneratedColumn<String> giftJson = GeneratedColumn<String>(
    'gift_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tokenSprayJsonMeta = const VerificationMeta(
    'tokenSprayJson',
  );
  @override
  late final GeneratedColumn<String> tokenSprayJson = GeneratedColumn<String>(
    'token_spray_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _communityIdMeta = const VerificationMeta(
    'communityId',
  );
  @override
  late final GeneratedColumn<String> communityId = GeneratedColumn<String>(
    'community_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemEventTypeMeta = const VerificationMeta(
    'systemEventType',
  );
  @override
  late final GeneratedColumn<String> systemEventType = GeneratedColumn<String>(
    'system_event_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemEventDataJsonMeta =
      const VerificationMeta('systemEventDataJson');
  @override
  late final GeneratedColumn<String> systemEventDataJson =
      GeneratedColumn<String>(
        'system_event_data_json',
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
  static const VerificationMeta _actionedAtMeta = const VerificationMeta(
    'actionedAt',
  );
  @override
  late final GeneratedColumn<DateTime> actionedAt = GeneratedColumn<DateTime>(
    'actioned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedForJsonMeta = const VerificationMeta(
    'deletedForJson',
  );
  @override
  late final GeneratedColumn<String> deletedForJson = GeneratedColumn<String>(
    'deleted_for_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _deletedForEveryoneMeta =
      const VerificationMeta('deletedForEveryone');
  @override
  late final GeneratedColumn<bool> deletedForEveryone = GeneratedColumn<bool>(
    'deleted_for_everyone',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted_for_everyone" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDecryptedMeta = const VerificationMeta(
    'isDecrypted',
  );
  @override
  late final GeneratedColumn<bool> isDecrypted = GeneratedColumn<bool>(
    'is_decrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_decrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readByJsonMeta = const VerificationMeta(
    'readByJson',
  );
  @override
  late final GeneratedColumn<String> readByJson = GeneratedColumn<String>(
    'read_by_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _forwardedFromJsonMeta = const VerificationMeta(
    'forwardedFromJson',
  );
  @override
  late final GeneratedColumn<String> forwardedFromJson =
      GeneratedColumn<String>(
        'forwarded_from_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    senderId,
    senderName,
    senderAvatarUrl,
    type,
    status,
    textContent,
    tokenAmount,
    recipientId,
    ledgerJournalId,
    mediaJson,
    reactionsJson,
    replyToJson,
    giftJson,
    tokenSprayJson,
    communityId,
    systemEventType,
    systemEventDataJson,
    createdAt,
    expiresAt,
    actionedAt,
    deletedAt,
    deletedForJson,
    deletedForEveryone,
    isDecrypted,
    readByJson,
    forwardedFromJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_full_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalFullMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('sender_avatar_url')) {
      context.handle(
        _senderAvatarUrlMeta,
        senderAvatarUrl.isAcceptableOrUnknown(
          data['sender_avatar_url']!,
          _senderAvatarUrlMeta,
        ),
      );
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
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
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
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    }
    if (data.containsKey('ledger_journal_id')) {
      context.handle(
        _ledgerJournalIdMeta,
        ledgerJournalId.isAcceptableOrUnknown(
          data['ledger_journal_id']!,
          _ledgerJournalIdMeta,
        ),
      );
    }
    if (data.containsKey('media_json')) {
      context.handle(
        _mediaJsonMeta,
        mediaJson.isAcceptableOrUnknown(data['media_json']!, _mediaJsonMeta),
      );
    }
    if (data.containsKey('reactions_json')) {
      context.handle(
        _reactionsJsonMeta,
        reactionsJson.isAcceptableOrUnknown(
          data['reactions_json']!,
          _reactionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('reply_to_json')) {
      context.handle(
        _replyToJsonMeta,
        replyToJson.isAcceptableOrUnknown(
          data['reply_to_json']!,
          _replyToJsonMeta,
        ),
      );
    }
    if (data.containsKey('gift_json')) {
      context.handle(
        _giftJsonMeta,
        giftJson.isAcceptableOrUnknown(data['gift_json']!, _giftJsonMeta),
      );
    }
    if (data.containsKey('token_spray_json')) {
      context.handle(
        _tokenSprayJsonMeta,
        tokenSprayJson.isAcceptableOrUnknown(
          data['token_spray_json']!,
          _tokenSprayJsonMeta,
        ),
      );
    }
    if (data.containsKey('community_id')) {
      context.handle(
        _communityIdMeta,
        communityId.isAcceptableOrUnknown(
          data['community_id']!,
          _communityIdMeta,
        ),
      );
    }
    if (data.containsKey('system_event_type')) {
      context.handle(
        _systemEventTypeMeta,
        systemEventType.isAcceptableOrUnknown(
          data['system_event_type']!,
          _systemEventTypeMeta,
        ),
      );
    }
    if (data.containsKey('system_event_data_json')) {
      context.handle(
        _systemEventDataJsonMeta,
        systemEventDataJson.isAcceptableOrUnknown(
          data['system_event_data_json']!,
          _systemEventDataJsonMeta,
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
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('actioned_at')) {
      context.handle(
        _actionedAtMeta,
        actionedAt.isAcceptableOrUnknown(data['actioned_at']!, _actionedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('deleted_for_json')) {
      context.handle(
        _deletedForJsonMeta,
        deletedForJson.isAcceptableOrUnknown(
          data['deleted_for_json']!,
          _deletedForJsonMeta,
        ),
      );
    }
    if (data.containsKey('deleted_for_everyone')) {
      context.handle(
        _deletedForEveryoneMeta,
        deletedForEveryone.isAcceptableOrUnknown(
          data['deleted_for_everyone']!,
          _deletedForEveryoneMeta,
        ),
      );
    }
    if (data.containsKey('is_decrypted')) {
      context.handle(
        _isDecryptedMeta,
        isDecrypted.isAcceptableOrUnknown(
          data['is_decrypted']!,
          _isDecryptedMeta,
        ),
      );
    }
    if (data.containsKey('read_by_json')) {
      context.handle(
        _readByJsonMeta,
        readByJson.isAcceptableOrUnknown(
          data['read_by_json']!,
          _readByJsonMeta,
        ),
      );
    }
    if (data.containsKey('forwarded_from_json')) {
      context.handle(
        _forwardedFromJsonMeta,
        forwardedFromJson.isAcceptableOrUnknown(
          data['forwarded_from_json']!,
          _forwardedFromJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFullMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFullMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      senderAvatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_avatar_url'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      ),
      tokenAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_amount'],
      ),
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      ),
      ledgerJournalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_journal_id'],
      ),
      mediaJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_json'],
      ),
      reactionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reactions_json'],
      ),
      replyToJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_json'],
      ),
      giftJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gift_json'],
      ),
      tokenSprayJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token_spray_json'],
      ),
      communityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community_id'],
      ),
      systemEventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_event_type'],
      ),
      systemEventDataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_event_data_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      actionedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actioned_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      deletedForJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_for_json'],
      )!,
      deletedForEveryone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted_for_everyone'],
      )!,
      isDecrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_decrypted'],
      )!,
      readByJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}read_by_json'],
      )!,
      forwardedFromJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forwarded_from_json'],
      ),
    );
  }

  @override
  $LocalFullMessagesTable createAlias(String alias) {
    return $LocalFullMessagesTable(attachedDatabase, alias);
  }
}

class LocalFullMessage extends DataClass
    implements Insertable<LocalFullMessage> {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderAvatarUrl;
  final String type;
  final String status;
  final String? textContent;
  final int? tokenAmount;
  final String? recipientId;
  final String? ledgerJournalId;
  final String? mediaJson;
  final String? reactionsJson;
  final String? replyToJson;
  final String? giftJson;
  final String? tokenSprayJson;
  final String? communityId;
  final String? systemEventType;
  final String? systemEventDataJson;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final DateTime? actionedAt;
  final DateTime? deletedAt;
  final String deletedForJson;
  final bool deletedForEveryone;
  final bool isDecrypted;
  final String readByJson;
  final String? forwardedFromJson;
  const LocalFullMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.type,
    required this.status,
    this.textContent,
    this.tokenAmount,
    this.recipientId,
    this.ledgerJournalId,
    this.mediaJson,
    this.reactionsJson,
    this.replyToJson,
    this.giftJson,
    this.tokenSprayJson,
    this.communityId,
    this.systemEventType,
    this.systemEventDataJson,
    required this.createdAt,
    this.expiresAt,
    this.actionedAt,
    this.deletedAt,
    required this.deletedForJson,
    required this.deletedForEveryone,
    required this.isDecrypted,
    required this.readByJson,
    this.forwardedFromJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['sender_id'] = Variable<String>(senderId);
    map['sender_name'] = Variable<String>(senderName);
    if (!nullToAbsent || senderAvatarUrl != null) {
      map['sender_avatar_url'] = Variable<String>(senderAvatarUrl);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || textContent != null) {
      map['text_content'] = Variable<String>(textContent);
    }
    if (!nullToAbsent || tokenAmount != null) {
      map['token_amount'] = Variable<int>(tokenAmount);
    }
    if (!nullToAbsent || recipientId != null) {
      map['recipient_id'] = Variable<String>(recipientId);
    }
    if (!nullToAbsent || ledgerJournalId != null) {
      map['ledger_journal_id'] = Variable<String>(ledgerJournalId);
    }
    if (!nullToAbsent || mediaJson != null) {
      map['media_json'] = Variable<String>(mediaJson);
    }
    if (!nullToAbsent || reactionsJson != null) {
      map['reactions_json'] = Variable<String>(reactionsJson);
    }
    if (!nullToAbsent || replyToJson != null) {
      map['reply_to_json'] = Variable<String>(replyToJson);
    }
    if (!nullToAbsent || giftJson != null) {
      map['gift_json'] = Variable<String>(giftJson);
    }
    if (!nullToAbsent || tokenSprayJson != null) {
      map['token_spray_json'] = Variable<String>(tokenSprayJson);
    }
    if (!nullToAbsent || communityId != null) {
      map['community_id'] = Variable<String>(communityId);
    }
    if (!nullToAbsent || systemEventType != null) {
      map['system_event_type'] = Variable<String>(systemEventType);
    }
    if (!nullToAbsent || systemEventDataJson != null) {
      map['system_event_data_json'] = Variable<String>(systemEventDataJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    if (!nullToAbsent || actionedAt != null) {
      map['actioned_at'] = Variable<DateTime>(actionedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['deleted_for_json'] = Variable<String>(deletedForJson);
    map['deleted_for_everyone'] = Variable<bool>(deletedForEveryone);
    map['is_decrypted'] = Variable<bool>(isDecrypted);
    map['read_by_json'] = Variable<String>(readByJson);
    if (!nullToAbsent || forwardedFromJson != null) {
      map['forwarded_from_json'] = Variable<String>(forwardedFromJson);
    }
    return map;
  }

  LocalFullMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalFullMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      senderId: Value(senderId),
      senderName: Value(senderName),
      senderAvatarUrl: senderAvatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(senderAvatarUrl),
      type: Value(type),
      status: Value(status),
      textContent: textContent == null && nullToAbsent
          ? const Value.absent()
          : Value(textContent),
      tokenAmount: tokenAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenAmount),
      recipientId: recipientId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipientId),
      ledgerJournalId: ledgerJournalId == null && nullToAbsent
          ? const Value.absent()
          : Value(ledgerJournalId),
      mediaJson: mediaJson == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaJson),
      reactionsJson: reactionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(reactionsJson),
      replyToJson: replyToJson == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToJson),
      giftJson: giftJson == null && nullToAbsent
          ? const Value.absent()
          : Value(giftJson),
      tokenSprayJson: tokenSprayJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenSprayJson),
      communityId: communityId == null && nullToAbsent
          ? const Value.absent()
          : Value(communityId),
      systemEventType: systemEventType == null && nullToAbsent
          ? const Value.absent()
          : Value(systemEventType),
      systemEventDataJson: systemEventDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(systemEventDataJson),
      createdAt: Value(createdAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      actionedAt: actionedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(actionedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      deletedForJson: Value(deletedForJson),
      deletedForEveryone: Value(deletedForEveryone),
      isDecrypted: Value(isDecrypted),
      readByJson: Value(readByJson),
      forwardedFromJson: forwardedFromJson == null && nullToAbsent
          ? const Value.absent()
          : Value(forwardedFromJson),
    );
  }

  factory LocalFullMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFullMessage(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      senderName: serializer.fromJson<String>(json['senderName']),
      senderAvatarUrl: serializer.fromJson<String?>(json['senderAvatarUrl']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      textContent: serializer.fromJson<String?>(json['textContent']),
      tokenAmount: serializer.fromJson<int?>(json['tokenAmount']),
      recipientId: serializer.fromJson<String?>(json['recipientId']),
      ledgerJournalId: serializer.fromJson<String?>(json['ledgerJournalId']),
      mediaJson: serializer.fromJson<String?>(json['mediaJson']),
      reactionsJson: serializer.fromJson<String?>(json['reactionsJson']),
      replyToJson: serializer.fromJson<String?>(json['replyToJson']),
      giftJson: serializer.fromJson<String?>(json['giftJson']),
      tokenSprayJson: serializer.fromJson<String?>(json['tokenSprayJson']),
      communityId: serializer.fromJson<String?>(json['communityId']),
      systemEventType: serializer.fromJson<String?>(json['systemEventType']),
      systemEventDataJson: serializer.fromJson<String?>(
        json['systemEventDataJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      actionedAt: serializer.fromJson<DateTime?>(json['actionedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      deletedForJson: serializer.fromJson<String>(json['deletedForJson']),
      deletedForEveryone: serializer.fromJson<bool>(json['deletedForEveryone']),
      isDecrypted: serializer.fromJson<bool>(json['isDecrypted']),
      readByJson: serializer.fromJson<String>(json['readByJson']),
      forwardedFromJson: serializer.fromJson<String?>(
        json['forwardedFromJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'senderId': serializer.toJson<String>(senderId),
      'senderName': serializer.toJson<String>(senderName),
      'senderAvatarUrl': serializer.toJson<String?>(senderAvatarUrl),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'textContent': serializer.toJson<String?>(textContent),
      'tokenAmount': serializer.toJson<int?>(tokenAmount),
      'recipientId': serializer.toJson<String?>(recipientId),
      'ledgerJournalId': serializer.toJson<String?>(ledgerJournalId),
      'mediaJson': serializer.toJson<String?>(mediaJson),
      'reactionsJson': serializer.toJson<String?>(reactionsJson),
      'replyToJson': serializer.toJson<String?>(replyToJson),
      'giftJson': serializer.toJson<String?>(giftJson),
      'tokenSprayJson': serializer.toJson<String?>(tokenSprayJson),
      'communityId': serializer.toJson<String?>(communityId),
      'systemEventType': serializer.toJson<String?>(systemEventType),
      'systemEventDataJson': serializer.toJson<String?>(systemEventDataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'actionedAt': serializer.toJson<DateTime?>(actionedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'deletedForJson': serializer.toJson<String>(deletedForJson),
      'deletedForEveryone': serializer.toJson<bool>(deletedForEveryone),
      'isDecrypted': serializer.toJson<bool>(isDecrypted),
      'readByJson': serializer.toJson<String>(readByJson),
      'forwardedFromJson': serializer.toJson<String?>(forwardedFromJson),
    };
  }

  LocalFullMessage copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderName,
    Value<String?> senderAvatarUrl = const Value.absent(),
    String? type,
    String? status,
    Value<String?> textContent = const Value.absent(),
    Value<int?> tokenAmount = const Value.absent(),
    Value<String?> recipientId = const Value.absent(),
    Value<String?> ledgerJournalId = const Value.absent(),
    Value<String?> mediaJson = const Value.absent(),
    Value<String?> reactionsJson = const Value.absent(),
    Value<String?> replyToJson = const Value.absent(),
    Value<String?> giftJson = const Value.absent(),
    Value<String?> tokenSprayJson = const Value.absent(),
    Value<String?> communityId = const Value.absent(),
    Value<String?> systemEventType = const Value.absent(),
    Value<String?> systemEventDataJson = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> expiresAt = const Value.absent(),
    Value<DateTime?> actionedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? deletedForJson,
    bool? deletedForEveryone,
    bool? isDecrypted,
    String? readByJson,
    Value<String?> forwardedFromJson = const Value.absent(),
  }) => LocalFullMessage(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    senderId: senderId ?? this.senderId,
    senderName: senderName ?? this.senderName,
    senderAvatarUrl: senderAvatarUrl.present
        ? senderAvatarUrl.value
        : this.senderAvatarUrl,
    type: type ?? this.type,
    status: status ?? this.status,
    textContent: textContent.present ? textContent.value : this.textContent,
    tokenAmount: tokenAmount.present ? tokenAmount.value : this.tokenAmount,
    recipientId: recipientId.present ? recipientId.value : this.recipientId,
    ledgerJournalId: ledgerJournalId.present
        ? ledgerJournalId.value
        : this.ledgerJournalId,
    mediaJson: mediaJson.present ? mediaJson.value : this.mediaJson,
    reactionsJson: reactionsJson.present
        ? reactionsJson.value
        : this.reactionsJson,
    replyToJson: replyToJson.present ? replyToJson.value : this.replyToJson,
    giftJson: giftJson.present ? giftJson.value : this.giftJson,
    tokenSprayJson: tokenSprayJson.present
        ? tokenSprayJson.value
        : this.tokenSprayJson,
    communityId: communityId.present ? communityId.value : this.communityId,
    systemEventType: systemEventType.present
        ? systemEventType.value
        : this.systemEventType,
    systemEventDataJson: systemEventDataJson.present
        ? systemEventDataJson.value
        : this.systemEventDataJson,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    actionedAt: actionedAt.present ? actionedAt.value : this.actionedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    deletedForJson: deletedForJson ?? this.deletedForJson,
    deletedForEveryone: deletedForEveryone ?? this.deletedForEveryone,
    isDecrypted: isDecrypted ?? this.isDecrypted,
    readByJson: readByJson ?? this.readByJson,
    forwardedFromJson: forwardedFromJson.present
        ? forwardedFromJson.value
        : this.forwardedFromJson,
  );
  LocalFullMessage copyWithCompanion(LocalFullMessagesCompanion data) {
    return LocalFullMessage(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      senderAvatarUrl: data.senderAvatarUrl.present
          ? data.senderAvatarUrl.value
          : this.senderAvatarUrl,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      tokenAmount: data.tokenAmount.present
          ? data.tokenAmount.value
          : this.tokenAmount,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      ledgerJournalId: data.ledgerJournalId.present
          ? data.ledgerJournalId.value
          : this.ledgerJournalId,
      mediaJson: data.mediaJson.present ? data.mediaJson.value : this.mediaJson,
      reactionsJson: data.reactionsJson.present
          ? data.reactionsJson.value
          : this.reactionsJson,
      replyToJson: data.replyToJson.present
          ? data.replyToJson.value
          : this.replyToJson,
      giftJson: data.giftJson.present ? data.giftJson.value : this.giftJson,
      tokenSprayJson: data.tokenSprayJson.present
          ? data.tokenSprayJson.value
          : this.tokenSprayJson,
      communityId: data.communityId.present
          ? data.communityId.value
          : this.communityId,
      systemEventType: data.systemEventType.present
          ? data.systemEventType.value
          : this.systemEventType,
      systemEventDataJson: data.systemEventDataJson.present
          ? data.systemEventDataJson.value
          : this.systemEventDataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      actionedAt: data.actionedAt.present
          ? data.actionedAt.value
          : this.actionedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      deletedForJson: data.deletedForJson.present
          ? data.deletedForJson.value
          : this.deletedForJson,
      deletedForEveryone: data.deletedForEveryone.present
          ? data.deletedForEveryone.value
          : this.deletedForEveryone,
      isDecrypted: data.isDecrypted.present
          ? data.isDecrypted.value
          : this.isDecrypted,
      readByJson: data.readByJson.present
          ? data.readByJson.value
          : this.readByJson,
      forwardedFromJson: data.forwardedFromJson.present
          ? data.forwardedFromJson.value
          : this.forwardedFromJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFullMessage(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('senderAvatarUrl: $senderAvatarUrl, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('textContent: $textContent, ')
          ..write('tokenAmount: $tokenAmount, ')
          ..write('recipientId: $recipientId, ')
          ..write('ledgerJournalId: $ledgerJournalId, ')
          ..write('mediaJson: $mediaJson, ')
          ..write('reactionsJson: $reactionsJson, ')
          ..write('replyToJson: $replyToJson, ')
          ..write('giftJson: $giftJson, ')
          ..write('tokenSprayJson: $tokenSprayJson, ')
          ..write('communityId: $communityId, ')
          ..write('systemEventType: $systemEventType, ')
          ..write('systemEventDataJson: $systemEventDataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('actionedAt: $actionedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deletedForJson: $deletedForJson, ')
          ..write('deletedForEveryone: $deletedForEveryone, ')
          ..write('isDecrypted: $isDecrypted, ')
          ..write('readByJson: $readByJson, ')
          ..write('forwardedFromJson: $forwardedFromJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    conversationId,
    senderId,
    senderName,
    senderAvatarUrl,
    type,
    status,
    textContent,
    tokenAmount,
    recipientId,
    ledgerJournalId,
    mediaJson,
    reactionsJson,
    replyToJson,
    giftJson,
    tokenSprayJson,
    communityId,
    systemEventType,
    systemEventDataJson,
    createdAt,
    expiresAt,
    actionedAt,
    deletedAt,
    deletedForJson,
    deletedForEveryone,
    isDecrypted,
    readByJson,
    forwardedFromJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFullMessage &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.senderId == this.senderId &&
          other.senderName == this.senderName &&
          other.senderAvatarUrl == this.senderAvatarUrl &&
          other.type == this.type &&
          other.status == this.status &&
          other.textContent == this.textContent &&
          other.tokenAmount == this.tokenAmount &&
          other.recipientId == this.recipientId &&
          other.ledgerJournalId == this.ledgerJournalId &&
          other.mediaJson == this.mediaJson &&
          other.reactionsJson == this.reactionsJson &&
          other.replyToJson == this.replyToJson &&
          other.giftJson == this.giftJson &&
          other.tokenSprayJson == this.tokenSprayJson &&
          other.communityId == this.communityId &&
          other.systemEventType == this.systemEventType &&
          other.systemEventDataJson == this.systemEventDataJson &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt &&
          other.actionedAt == this.actionedAt &&
          other.deletedAt == this.deletedAt &&
          other.deletedForJson == this.deletedForJson &&
          other.deletedForEveryone == this.deletedForEveryone &&
          other.isDecrypted == this.isDecrypted &&
          other.readByJson == this.readByJson &&
          other.forwardedFromJson == this.forwardedFromJson);
}

class LocalFullMessagesCompanion extends UpdateCompanion<LocalFullMessage> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> senderId;
  final Value<String> senderName;
  final Value<String?> senderAvatarUrl;
  final Value<String> type;
  final Value<String> status;
  final Value<String?> textContent;
  final Value<int?> tokenAmount;
  final Value<String?> recipientId;
  final Value<String?> ledgerJournalId;
  final Value<String?> mediaJson;
  final Value<String?> reactionsJson;
  final Value<String?> replyToJson;
  final Value<String?> giftJson;
  final Value<String?> tokenSprayJson;
  final Value<String?> communityId;
  final Value<String?> systemEventType;
  final Value<String?> systemEventDataJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> expiresAt;
  final Value<DateTime?> actionedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> deletedForJson;
  final Value<bool> deletedForEveryone;
  final Value<bool> isDecrypted;
  final Value<String> readByJson;
  final Value<String?> forwardedFromJson;
  final Value<int> rowid;
  const LocalFullMessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.senderName = const Value.absent(),
    this.senderAvatarUrl = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.textContent = const Value.absent(),
    this.tokenAmount = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.ledgerJournalId = const Value.absent(),
    this.mediaJson = const Value.absent(),
    this.reactionsJson = const Value.absent(),
    this.replyToJson = const Value.absent(),
    this.giftJson = const Value.absent(),
    this.tokenSprayJson = const Value.absent(),
    this.communityId = const Value.absent(),
    this.systemEventType = const Value.absent(),
    this.systemEventDataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.actionedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.deletedForJson = const Value.absent(),
    this.deletedForEveryone = const Value.absent(),
    this.isDecrypted = const Value.absent(),
    this.readByJson = const Value.absent(),
    this.forwardedFromJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalFullMessagesCompanion.insert({
    required String id,
    required String conversationId,
    required String senderId,
    required String senderName,
    this.senderAvatarUrl = const Value.absent(),
    required String type,
    required String status,
    this.textContent = const Value.absent(),
    this.tokenAmount = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.ledgerJournalId = const Value.absent(),
    this.mediaJson = const Value.absent(),
    this.reactionsJson = const Value.absent(),
    this.replyToJson = const Value.absent(),
    this.giftJson = const Value.absent(),
    this.tokenSprayJson = const Value.absent(),
    this.communityId = const Value.absent(),
    this.systemEventType = const Value.absent(),
    this.systemEventDataJson = const Value.absent(),
    required DateTime createdAt,
    this.expiresAt = const Value.absent(),
    this.actionedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.deletedForJson = const Value.absent(),
    this.deletedForEveryone = const Value.absent(),
    this.isDecrypted = const Value.absent(),
    this.readByJson = const Value.absent(),
    this.forwardedFromJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conversationId = Value(conversationId),
       senderId = Value(senderId),
       senderName = Value(senderName),
       type = Value(type),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalFullMessage> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? senderId,
    Expression<String>? senderName,
    Expression<String>? senderAvatarUrl,
    Expression<String>? type,
    Expression<String>? status,
    Expression<String>? textContent,
    Expression<int>? tokenAmount,
    Expression<String>? recipientId,
    Expression<String>? ledgerJournalId,
    Expression<String>? mediaJson,
    Expression<String>? reactionsJson,
    Expression<String>? replyToJson,
    Expression<String>? giftJson,
    Expression<String>? tokenSprayJson,
    Expression<String>? communityId,
    Expression<String>? systemEventType,
    Expression<String>? systemEventDataJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
    Expression<DateTime>? actionedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? deletedForJson,
    Expression<bool>? deletedForEveryone,
    Expression<bool>? isDecrypted,
    Expression<String>? readByJson,
    Expression<String>? forwardedFromJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (senderId != null) 'sender_id': senderId,
      if (senderName != null) 'sender_name': senderName,
      if (senderAvatarUrl != null) 'sender_avatar_url': senderAvatarUrl,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (textContent != null) 'text_content': textContent,
      if (tokenAmount != null) 'token_amount': tokenAmount,
      if (recipientId != null) 'recipient_id': recipientId,
      if (ledgerJournalId != null) 'ledger_journal_id': ledgerJournalId,
      if (mediaJson != null) 'media_json': mediaJson,
      if (reactionsJson != null) 'reactions_json': reactionsJson,
      if (replyToJson != null) 'reply_to_json': replyToJson,
      if (giftJson != null) 'gift_json': giftJson,
      if (tokenSprayJson != null) 'token_spray_json': tokenSprayJson,
      if (communityId != null) 'community_id': communityId,
      if (systemEventType != null) 'system_event_type': systemEventType,
      if (systemEventDataJson != null)
        'system_event_data_json': systemEventDataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (actionedAt != null) 'actioned_at': actionedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (deletedForJson != null) 'deleted_for_json': deletedForJson,
      if (deletedForEveryone != null)
        'deleted_for_everyone': deletedForEveryone,
      if (isDecrypted != null) 'is_decrypted': isDecrypted,
      if (readByJson != null) 'read_by_json': readByJson,
      if (forwardedFromJson != null) 'forwarded_from_json': forwardedFromJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalFullMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<String>? senderId,
    Value<String>? senderName,
    Value<String?>? senderAvatarUrl,
    Value<String>? type,
    Value<String>? status,
    Value<String?>? textContent,
    Value<int?>? tokenAmount,
    Value<String?>? recipientId,
    Value<String?>? ledgerJournalId,
    Value<String?>? mediaJson,
    Value<String?>? reactionsJson,
    Value<String?>? replyToJson,
    Value<String?>? giftJson,
    Value<String?>? tokenSprayJson,
    Value<String?>? communityId,
    Value<String?>? systemEventType,
    Value<String?>? systemEventDataJson,
    Value<DateTime>? createdAt,
    Value<DateTime?>? expiresAt,
    Value<DateTime?>? actionedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? deletedForJson,
    Value<bool>? deletedForEveryone,
    Value<bool>? isDecrypted,
    Value<String>? readByJson,
    Value<String?>? forwardedFromJson,
    Value<int>? rowid,
  }) {
    return LocalFullMessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderAvatarUrl: senderAvatarUrl ?? this.senderAvatarUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      textContent: textContent ?? this.textContent,
      tokenAmount: tokenAmount ?? this.tokenAmount,
      recipientId: recipientId ?? this.recipientId,
      ledgerJournalId: ledgerJournalId ?? this.ledgerJournalId,
      mediaJson: mediaJson ?? this.mediaJson,
      reactionsJson: reactionsJson ?? this.reactionsJson,
      replyToJson: replyToJson ?? this.replyToJson,
      giftJson: giftJson ?? this.giftJson,
      tokenSprayJson: tokenSprayJson ?? this.tokenSprayJson,
      communityId: communityId ?? this.communityId,
      systemEventType: systemEventType ?? this.systemEventType,
      systemEventDataJson: systemEventDataJson ?? this.systemEventDataJson,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      actionedAt: actionedAt ?? this.actionedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedForJson: deletedForJson ?? this.deletedForJson,
      deletedForEveryone: deletedForEveryone ?? this.deletedForEveryone,
      isDecrypted: isDecrypted ?? this.isDecrypted,
      readByJson: readByJson ?? this.readByJson,
      forwardedFromJson: forwardedFromJson ?? this.forwardedFromJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (senderAvatarUrl.present) {
      map['sender_avatar_url'] = Variable<String>(senderAvatarUrl.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (tokenAmount.present) {
      map['token_amount'] = Variable<int>(tokenAmount.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (ledgerJournalId.present) {
      map['ledger_journal_id'] = Variable<String>(ledgerJournalId.value);
    }
    if (mediaJson.present) {
      map['media_json'] = Variable<String>(mediaJson.value);
    }
    if (reactionsJson.present) {
      map['reactions_json'] = Variable<String>(reactionsJson.value);
    }
    if (replyToJson.present) {
      map['reply_to_json'] = Variable<String>(replyToJson.value);
    }
    if (giftJson.present) {
      map['gift_json'] = Variable<String>(giftJson.value);
    }
    if (tokenSprayJson.present) {
      map['token_spray_json'] = Variable<String>(tokenSprayJson.value);
    }
    if (communityId.present) {
      map['community_id'] = Variable<String>(communityId.value);
    }
    if (systemEventType.present) {
      map['system_event_type'] = Variable<String>(systemEventType.value);
    }
    if (systemEventDataJson.present) {
      map['system_event_data_json'] = Variable<String>(
        systemEventDataJson.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (actionedAt.present) {
      map['actioned_at'] = Variable<DateTime>(actionedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (deletedForJson.present) {
      map['deleted_for_json'] = Variable<String>(deletedForJson.value);
    }
    if (deletedForEveryone.present) {
      map['deleted_for_everyone'] = Variable<bool>(deletedForEveryone.value);
    }
    if (isDecrypted.present) {
      map['is_decrypted'] = Variable<bool>(isDecrypted.value);
    }
    if (readByJson.present) {
      map['read_by_json'] = Variable<String>(readByJson.value);
    }
    if (forwardedFromJson.present) {
      map['forwarded_from_json'] = Variable<String>(forwardedFromJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFullMessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('senderAvatarUrl: $senderAvatarUrl, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('textContent: $textContent, ')
          ..write('tokenAmount: $tokenAmount, ')
          ..write('recipientId: $recipientId, ')
          ..write('ledgerJournalId: $ledgerJournalId, ')
          ..write('mediaJson: $mediaJson, ')
          ..write('reactionsJson: $reactionsJson, ')
          ..write('replyToJson: $replyToJson, ')
          ..write('giftJson: $giftJson, ')
          ..write('tokenSprayJson: $tokenSprayJson, ')
          ..write('communityId: $communityId, ')
          ..write('systemEventType: $systemEventType, ')
          ..write('systemEventDataJson: $systemEventDataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('actionedAt: $actionedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('deletedForJson: $deletedForJson, ')
          ..write('deletedForEveryone: $deletedForEveryone, ')
          ..write('isDecrypted: $isDecrypted, ')
          ..write('readByJson: $readByJson, ')
          ..write('forwardedFromJson: $forwardedFromJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalFullConversationsTable extends LocalFullConversations
    with TableInfo<$LocalFullConversationsTable, LocalFullConversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFullConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _participantIdsJsonMeta =
      const VerificationMeta('participantIdsJson');
  @override
  late final GeneratedColumn<String> participantIdsJson =
      GeneratedColumn<String>(
        'participant_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _participantsJsonMeta = const VerificationMeta(
    'participantsJson',
  );
  @override
  late final GeneratedColumn<String> participantsJson = GeneratedColumn<String>(
    'participants_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMessageIdMeta = const VerificationMeta(
    'lastMessageId',
  );
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
    'last_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageTextMeta = const VerificationMeta(
    'lastMessageText',
  );
  @override
  late final GeneratedColumn<String> lastMessageText = GeneratedColumn<String>(
    'last_message_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageSenderIdMeta =
      const VerificationMeta('lastMessageSenderId');
  @override
  late final GeneratedColumn<String> lastMessageSenderId =
      GeneratedColumn<String>(
        'last_message_sender_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageSenderNameMeta =
      const VerificationMeta('lastMessageSenderName');
  @override
  late final GeneratedColumn<String> lastMessageSenderName =
      GeneratedColumn<String>(
        'last_message_sender_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageTypeMeta = const VerificationMeta(
    'lastMessageType',
  );
  @override
  late final GeneratedColumn<String> lastMessageType = GeneratedColumn<String>(
    'last_message_type',
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
  static const VerificationMeta _unreadCountsJsonMeta = const VerificationMeta(
    'unreadCountsJson',
  );
  @override
  late final GeneratedColumn<String> unreadCountsJson = GeneratedColumn<String>(
    'unread_counts_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _archivedJsonMeta = const VerificationMeta(
    'archivedJson',
  );
  @override
  late final GeneratedColumn<String> archivedJson = GeneratedColumn<String>(
    'archived_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _pinnedJsonMeta = const VerificationMeta(
    'pinnedJson',
  );
  @override
  late final GeneratedColumn<String> pinnedJson = GeneratedColumn<String>(
    'pinned_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _mutedJsonMeta = const VerificationMeta(
    'mutedJson',
  );
  @override
  late final GeneratedColumn<String> mutedJson = GeneratedColumn<String>(
    'muted_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _chatClearedAtJsonMeta = const VerificationMeta(
    'chatClearedAtJson',
  );
  @override
  late final GeneratedColumn<String> chatClearedAtJson =
      GeneratedColumn<String>(
        'chat_cleared_at_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _acceptedJsonMeta = const VerificationMeta(
    'acceptedJson',
  );
  @override
  late final GeneratedColumn<String> acceptedJson = GeneratedColumn<String>(
    'accepted_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _disappearingMessagesDurationMsMeta =
      const VerificationMeta('disappearingMessagesDurationMs');
  @override
  late final GeneratedColumn<int> disappearingMessagesDurationMs =
      GeneratedColumn<int>(
        'disappearing_messages_duration_ms',
        aliasedName,
        true,
        type: DriftSqlType.int,
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    participantIdsJson,
    participantsJson,
    lastMessageId,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    unreadCountsJson,
    archivedJson,
    pinnedJson,
    mutedJson,
    chatClearedAtJson,
    acceptedJson,
    disappearingMessagesDurationMs,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_full_conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalFullConversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('participant_ids_json')) {
      context.handle(
        _participantIdsJsonMeta,
        participantIdsJson.isAcceptableOrUnknown(
          data['participant_ids_json']!,
          _participantIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participantIdsJsonMeta);
    }
    if (data.containsKey('participants_json')) {
      context.handle(
        _participantsJsonMeta,
        participantsJson.isAcceptableOrUnknown(
          data['participants_json']!,
          _participantsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_participantsJsonMeta);
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
        _lastMessageIdMeta,
        lastMessageId.isAcceptableOrUnknown(
          data['last_message_id']!,
          _lastMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_text')) {
      context.handle(
        _lastMessageTextMeta,
        lastMessageText.isAcceptableOrUnknown(
          data['last_message_text']!,
          _lastMessageTextMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_id')) {
      context.handle(
        _lastMessageSenderIdMeta,
        lastMessageSenderId.isAcceptableOrUnknown(
          data['last_message_sender_id']!,
          _lastMessageSenderIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_name')) {
      context.handle(
        _lastMessageSenderNameMeta,
        lastMessageSenderName.isAcceptableOrUnknown(
          data['last_message_sender_name']!,
          _lastMessageSenderNameMeta,
        ),
      );
    }
    if (data.containsKey('last_message_type')) {
      context.handle(
        _lastMessageTypeMeta,
        lastMessageType.isAcceptableOrUnknown(
          data['last_message_type']!,
          _lastMessageTypeMeta,
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
    if (data.containsKey('unread_counts_json')) {
      context.handle(
        _unreadCountsJsonMeta,
        unreadCountsJson.isAcceptableOrUnknown(
          data['unread_counts_json']!,
          _unreadCountsJsonMeta,
        ),
      );
    }
    if (data.containsKey('archived_json')) {
      context.handle(
        _archivedJsonMeta,
        archivedJson.isAcceptableOrUnknown(
          data['archived_json']!,
          _archivedJsonMeta,
        ),
      );
    }
    if (data.containsKey('pinned_json')) {
      context.handle(
        _pinnedJsonMeta,
        pinnedJson.isAcceptableOrUnknown(data['pinned_json']!, _pinnedJsonMeta),
      );
    }
    if (data.containsKey('muted_json')) {
      context.handle(
        _mutedJsonMeta,
        mutedJson.isAcceptableOrUnknown(data['muted_json']!, _mutedJsonMeta),
      );
    }
    if (data.containsKey('chat_cleared_at_json')) {
      context.handle(
        _chatClearedAtJsonMeta,
        chatClearedAtJson.isAcceptableOrUnknown(
          data['chat_cleared_at_json']!,
          _chatClearedAtJsonMeta,
        ),
      );
    }
    if (data.containsKey('accepted_json')) {
      context.handle(
        _acceptedJsonMeta,
        acceptedJson.isAcceptableOrUnknown(
          data['accepted_json']!,
          _acceptedJsonMeta,
        ),
      );
    }
    if (data.containsKey('disappearing_messages_duration_ms')) {
      context.handle(
        _disappearingMessagesDurationMsMeta,
        disappearingMessagesDurationMs.isAcceptableOrUnknown(
          data['disappearing_messages_duration_ms']!,
          _disappearingMessagesDurationMsMeta,
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFullConversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFullConversation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      participantIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participant_ids_json'],
      )!,
      participantsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participants_json'],
      )!,
      lastMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_id'],
      ),
      lastMessageText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_text'],
      ),
      lastMessageSenderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_id'],
      ),
      lastMessageSenderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_name'],
      ),
      lastMessageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_type'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCountsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unread_counts_json'],
      )!,
      archivedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}archived_json'],
      )!,
      pinnedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pinned_json'],
      )!,
      mutedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muted_json'],
      )!,
      chatClearedAtJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_cleared_at_json'],
      )!,
      acceptedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accepted_json'],
      )!,
      disappearingMessagesDurationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disappearing_messages_duration_ms'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalFullConversationsTable createAlias(String alias) {
    return $LocalFullConversationsTable(attachedDatabase, alias);
  }
}

class LocalFullConversation extends DataClass
    implements Insertable<LocalFullConversation> {
  final String id;
  final String type;
  final String participantIdsJson;
  final String participantsJson;
  final String? lastMessageId;
  final String? lastMessageText;
  final String? lastMessageSenderId;
  final String? lastMessageSenderName;
  final String? lastMessageType;
  final DateTime? lastMessageAt;
  final String unreadCountsJson;
  final String archivedJson;
  final String pinnedJson;
  final String mutedJson;
  final String chatClearedAtJson;
  final String acceptedJson;
  final int? disappearingMessagesDurationMs;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const LocalFullConversation({
    required this.id,
    required this.type,
    required this.participantIdsJson,
    required this.participantsJson,
    this.lastMessageId,
    this.lastMessageText,
    this.lastMessageSenderId,
    this.lastMessageSenderName,
    this.lastMessageType,
    this.lastMessageAt,
    required this.unreadCountsJson,
    required this.archivedJson,
    required this.pinnedJson,
    required this.mutedJson,
    required this.chatClearedAtJson,
    required this.acceptedJson,
    this.disappearingMessagesDurationMs,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['participant_ids_json'] = Variable<String>(participantIdsJson);
    map['participants_json'] = Variable<String>(participantsJson);
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    if (!nullToAbsent || lastMessageText != null) {
      map['last_message_text'] = Variable<String>(lastMessageText);
    }
    if (!nullToAbsent || lastMessageSenderId != null) {
      map['last_message_sender_id'] = Variable<String>(lastMessageSenderId);
    }
    if (!nullToAbsent || lastMessageSenderName != null) {
      map['last_message_sender_name'] = Variable<String>(lastMessageSenderName);
    }
    if (!nullToAbsent || lastMessageType != null) {
      map['last_message_type'] = Variable<String>(lastMessageType);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_counts_json'] = Variable<String>(unreadCountsJson);
    map['archived_json'] = Variable<String>(archivedJson);
    map['pinned_json'] = Variable<String>(pinnedJson);
    map['muted_json'] = Variable<String>(mutedJson);
    map['chat_cleared_at_json'] = Variable<String>(chatClearedAtJson);
    map['accepted_json'] = Variable<String>(acceptedJson);
    if (!nullToAbsent || disappearingMessagesDurationMs != null) {
      map['disappearing_messages_duration_ms'] = Variable<int>(
        disappearingMessagesDurationMs,
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalFullConversationsCompanion toCompanion(bool nullToAbsent) {
    return LocalFullConversationsCompanion(
      id: Value(id),
      type: Value(type),
      participantIdsJson: Value(participantIdsJson),
      participantsJson: Value(participantsJson),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
      lastMessageText: lastMessageText == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageText),
      lastMessageSenderId: lastMessageSenderId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderId),
      lastMessageSenderName: lastMessageSenderName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderName),
      lastMessageType: lastMessageType == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageType),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCountsJson: Value(unreadCountsJson),
      archivedJson: Value(archivedJson),
      pinnedJson: Value(pinnedJson),
      mutedJson: Value(mutedJson),
      chatClearedAtJson: Value(chatClearedAtJson),
      acceptedJson: Value(acceptedJson),
      disappearingMessagesDurationMs:
          disappearingMessagesDurationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(disappearingMessagesDurationMs),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalFullConversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFullConversation(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      participantIdsJson: serializer.fromJson<String>(
        json['participantIdsJson'],
      ),
      participantsJson: serializer.fromJson<String>(json['participantsJson']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
      lastMessageText: serializer.fromJson<String?>(json['lastMessageText']),
      lastMessageSenderId: serializer.fromJson<String?>(
        json['lastMessageSenderId'],
      ),
      lastMessageSenderName: serializer.fromJson<String?>(
        json['lastMessageSenderName'],
      ),
      lastMessageType: serializer.fromJson<String?>(json['lastMessageType']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCountsJson: serializer.fromJson<String>(json['unreadCountsJson']),
      archivedJson: serializer.fromJson<String>(json['archivedJson']),
      pinnedJson: serializer.fromJson<String>(json['pinnedJson']),
      mutedJson: serializer.fromJson<String>(json['mutedJson']),
      chatClearedAtJson: serializer.fromJson<String>(json['chatClearedAtJson']),
      acceptedJson: serializer.fromJson<String>(json['acceptedJson']),
      disappearingMessagesDurationMs: serializer.fromJson<int?>(
        json['disappearingMessagesDurationMs'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'participantIdsJson': serializer.toJson<String>(participantIdsJson),
      'participantsJson': serializer.toJson<String>(participantsJson),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
      'lastMessageText': serializer.toJson<String?>(lastMessageText),
      'lastMessageSenderId': serializer.toJson<String?>(lastMessageSenderId),
      'lastMessageSenderName': serializer.toJson<String?>(
        lastMessageSenderName,
      ),
      'lastMessageType': serializer.toJson<String?>(lastMessageType),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCountsJson': serializer.toJson<String>(unreadCountsJson),
      'archivedJson': serializer.toJson<String>(archivedJson),
      'pinnedJson': serializer.toJson<String>(pinnedJson),
      'mutedJson': serializer.toJson<String>(mutedJson),
      'chatClearedAtJson': serializer.toJson<String>(chatClearedAtJson),
      'acceptedJson': serializer.toJson<String>(acceptedJson),
      'disappearingMessagesDurationMs': serializer.toJson<int?>(
        disappearingMessagesDurationMs,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalFullConversation copyWith({
    String? id,
    String? type,
    String? participantIdsJson,
    String? participantsJson,
    Value<String?> lastMessageId = const Value.absent(),
    Value<String?> lastMessageText = const Value.absent(),
    Value<String?> lastMessageSenderId = const Value.absent(),
    Value<String?> lastMessageSenderName = const Value.absent(),
    Value<String?> lastMessageType = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    String? unreadCountsJson,
    String? archivedJson,
    String? pinnedJson,
    String? mutedJson,
    String? chatClearedAtJson,
    String? acceptedJson,
    Value<int?> disappearingMessagesDurationMs = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalFullConversation(
    id: id ?? this.id,
    type: type ?? this.type,
    participantIdsJson: participantIdsJson ?? this.participantIdsJson,
    participantsJson: participantsJson ?? this.participantsJson,
    lastMessageId: lastMessageId.present
        ? lastMessageId.value
        : this.lastMessageId,
    lastMessageText: lastMessageText.present
        ? lastMessageText.value
        : this.lastMessageText,
    lastMessageSenderId: lastMessageSenderId.present
        ? lastMessageSenderId.value
        : this.lastMessageSenderId,
    lastMessageSenderName: lastMessageSenderName.present
        ? lastMessageSenderName.value
        : this.lastMessageSenderName,
    lastMessageType: lastMessageType.present
        ? lastMessageType.value
        : this.lastMessageType,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCountsJson: unreadCountsJson ?? this.unreadCountsJson,
    archivedJson: archivedJson ?? this.archivedJson,
    pinnedJson: pinnedJson ?? this.pinnedJson,
    mutedJson: mutedJson ?? this.mutedJson,
    chatClearedAtJson: chatClearedAtJson ?? this.chatClearedAtJson,
    acceptedJson: acceptedJson ?? this.acceptedJson,
    disappearingMessagesDurationMs: disappearingMessagesDurationMs.present
        ? disappearingMessagesDurationMs.value
        : this.disappearingMessagesDurationMs,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalFullConversation copyWithCompanion(
    LocalFullConversationsCompanion data,
  ) {
    return LocalFullConversation(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      participantIdsJson: data.participantIdsJson.present
          ? data.participantIdsJson.value
          : this.participantIdsJson,
      participantsJson: data.participantsJson.present
          ? data.participantsJson.value
          : this.participantsJson,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
      lastMessageText: data.lastMessageText.present
          ? data.lastMessageText.value
          : this.lastMessageText,
      lastMessageSenderId: data.lastMessageSenderId.present
          ? data.lastMessageSenderId.value
          : this.lastMessageSenderId,
      lastMessageSenderName: data.lastMessageSenderName.present
          ? data.lastMessageSenderName.value
          : this.lastMessageSenderName,
      lastMessageType: data.lastMessageType.present
          ? data.lastMessageType.value
          : this.lastMessageType,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCountsJson: data.unreadCountsJson.present
          ? data.unreadCountsJson.value
          : this.unreadCountsJson,
      archivedJson: data.archivedJson.present
          ? data.archivedJson.value
          : this.archivedJson,
      pinnedJson: data.pinnedJson.present
          ? data.pinnedJson.value
          : this.pinnedJson,
      mutedJson: data.mutedJson.present ? data.mutedJson.value : this.mutedJson,
      chatClearedAtJson: data.chatClearedAtJson.present
          ? data.chatClearedAtJson.value
          : this.chatClearedAtJson,
      acceptedJson: data.acceptedJson.present
          ? data.acceptedJson.value
          : this.acceptedJson,
      disappearingMessagesDurationMs:
          data.disappearingMessagesDurationMs.present
          ? data.disappearingMessagesDurationMs.value
          : this.disappearingMessagesDurationMs,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFullConversation(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('participantIdsJson: $participantIdsJson, ')
          ..write('participantsJson: $participantsJson, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageText: $lastMessageText, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCountsJson: $unreadCountsJson, ')
          ..write('archivedJson: $archivedJson, ')
          ..write('pinnedJson: $pinnedJson, ')
          ..write('mutedJson: $mutedJson, ')
          ..write('chatClearedAtJson: $chatClearedAtJson, ')
          ..write('acceptedJson: $acceptedJson, ')
          ..write(
            'disappearingMessagesDurationMs: $disappearingMessagesDurationMs, ',
          )
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    participantIdsJson,
    participantsJson,
    lastMessageId,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    unreadCountsJson,
    archivedJson,
    pinnedJson,
    mutedJson,
    chatClearedAtJson,
    acceptedJson,
    disappearingMessagesDurationMs,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFullConversation &&
          other.id == this.id &&
          other.type == this.type &&
          other.participantIdsJson == this.participantIdsJson &&
          other.participantsJson == this.participantsJson &&
          other.lastMessageId == this.lastMessageId &&
          other.lastMessageText == this.lastMessageText &&
          other.lastMessageSenderId == this.lastMessageSenderId &&
          other.lastMessageSenderName == this.lastMessageSenderName &&
          other.lastMessageType == this.lastMessageType &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCountsJson == this.unreadCountsJson &&
          other.archivedJson == this.archivedJson &&
          other.pinnedJson == this.pinnedJson &&
          other.mutedJson == this.mutedJson &&
          other.chatClearedAtJson == this.chatClearedAtJson &&
          other.acceptedJson == this.acceptedJson &&
          other.disappearingMessagesDurationMs ==
              this.disappearingMessagesDurationMs &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalFullConversationsCompanion
    extends UpdateCompanion<LocalFullConversation> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> participantIdsJson;
  final Value<String> participantsJson;
  final Value<String?> lastMessageId;
  final Value<String?> lastMessageText;
  final Value<String?> lastMessageSenderId;
  final Value<String?> lastMessageSenderName;
  final Value<String?> lastMessageType;
  final Value<DateTime?> lastMessageAt;
  final Value<String> unreadCountsJson;
  final Value<String> archivedJson;
  final Value<String> pinnedJson;
  final Value<String> mutedJson;
  final Value<String> chatClearedAtJson;
  final Value<String> acceptedJson;
  final Value<int?> disappearingMessagesDurationMs;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LocalFullConversationsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.participantIdsJson = const Value.absent(),
    this.participantsJson = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.lastMessageText = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCountsJson = const Value.absent(),
    this.archivedJson = const Value.absent(),
    this.pinnedJson = const Value.absent(),
    this.mutedJson = const Value.absent(),
    this.chatClearedAtJson = const Value.absent(),
    this.acceptedJson = const Value.absent(),
    this.disappearingMessagesDurationMs = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalFullConversationsCompanion.insert({
    required String id,
    required String type,
    required String participantIdsJson,
    required String participantsJson,
    this.lastMessageId = const Value.absent(),
    this.lastMessageText = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCountsJson = const Value.absent(),
    this.archivedJson = const Value.absent(),
    this.pinnedJson = const Value.absent(),
    this.mutedJson = const Value.absent(),
    this.chatClearedAtJson = const Value.absent(),
    this.acceptedJson = const Value.absent(),
    this.disappearingMessagesDurationMs = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       participantIdsJson = Value(participantIdsJson),
       participantsJson = Value(participantsJson),
       createdAt = Value(createdAt);
  static Insertable<LocalFullConversation> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? participantIdsJson,
    Expression<String>? participantsJson,
    Expression<String>? lastMessageId,
    Expression<String>? lastMessageText,
    Expression<String>? lastMessageSenderId,
    Expression<String>? lastMessageSenderName,
    Expression<String>? lastMessageType,
    Expression<DateTime>? lastMessageAt,
    Expression<String>? unreadCountsJson,
    Expression<String>? archivedJson,
    Expression<String>? pinnedJson,
    Expression<String>? mutedJson,
    Expression<String>? chatClearedAtJson,
    Expression<String>? acceptedJson,
    Expression<int>? disappearingMessagesDurationMs,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (participantIdsJson != null)
        'participant_ids_json': participantIdsJson,
      if (participantsJson != null) 'participants_json': participantsJson,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
      if (lastMessageText != null) 'last_message_text': lastMessageText,
      if (lastMessageSenderId != null)
        'last_message_sender_id': lastMessageSenderId,
      if (lastMessageSenderName != null)
        'last_message_sender_name': lastMessageSenderName,
      if (lastMessageType != null) 'last_message_type': lastMessageType,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCountsJson != null) 'unread_counts_json': unreadCountsJson,
      if (archivedJson != null) 'archived_json': archivedJson,
      if (pinnedJson != null) 'pinned_json': pinnedJson,
      if (mutedJson != null) 'muted_json': mutedJson,
      if (chatClearedAtJson != null) 'chat_cleared_at_json': chatClearedAtJson,
      if (acceptedJson != null) 'accepted_json': acceptedJson,
      if (disappearingMessagesDurationMs != null)
        'disappearing_messages_duration_ms': disappearingMessagesDurationMs,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalFullConversationsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? participantIdsJson,
    Value<String>? participantsJson,
    Value<String?>? lastMessageId,
    Value<String?>? lastMessageText,
    Value<String?>? lastMessageSenderId,
    Value<String?>? lastMessageSenderName,
    Value<String?>? lastMessageType,
    Value<DateTime?>? lastMessageAt,
    Value<String>? unreadCountsJson,
    Value<String>? archivedJson,
    Value<String>? pinnedJson,
    Value<String>? mutedJson,
    Value<String>? chatClearedAtJson,
    Value<String>? acceptedJson,
    Value<int?>? disappearingMessagesDurationMs,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalFullConversationsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      participantIdsJson: participantIdsJson ?? this.participantIdsJson,
      participantsJson: participantsJson ?? this.participantsJson,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCountsJson: unreadCountsJson ?? this.unreadCountsJson,
      archivedJson: archivedJson ?? this.archivedJson,
      pinnedJson: pinnedJson ?? this.pinnedJson,
      mutedJson: mutedJson ?? this.mutedJson,
      chatClearedAtJson: chatClearedAtJson ?? this.chatClearedAtJson,
      acceptedJson: acceptedJson ?? this.acceptedJson,
      disappearingMessagesDurationMs:
          disappearingMessagesDurationMs ?? this.disappearingMessagesDurationMs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (participantIdsJson.present) {
      map['participant_ids_json'] = Variable<String>(participantIdsJson.value);
    }
    if (participantsJson.present) {
      map['participants_json'] = Variable<String>(participantsJson.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    if (lastMessageText.present) {
      map['last_message_text'] = Variable<String>(lastMessageText.value);
    }
    if (lastMessageSenderId.present) {
      map['last_message_sender_id'] = Variable<String>(
        lastMessageSenderId.value,
      );
    }
    if (lastMessageSenderName.present) {
      map['last_message_sender_name'] = Variable<String>(
        lastMessageSenderName.value,
      );
    }
    if (lastMessageType.present) {
      map['last_message_type'] = Variable<String>(lastMessageType.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCountsJson.present) {
      map['unread_counts_json'] = Variable<String>(unreadCountsJson.value);
    }
    if (archivedJson.present) {
      map['archived_json'] = Variable<String>(archivedJson.value);
    }
    if (pinnedJson.present) {
      map['pinned_json'] = Variable<String>(pinnedJson.value);
    }
    if (mutedJson.present) {
      map['muted_json'] = Variable<String>(mutedJson.value);
    }
    if (chatClearedAtJson.present) {
      map['chat_cleared_at_json'] = Variable<String>(chatClearedAtJson.value);
    }
    if (acceptedJson.present) {
      map['accepted_json'] = Variable<String>(acceptedJson.value);
    }
    if (disappearingMessagesDurationMs.present) {
      map['disappearing_messages_duration_ms'] = Variable<int>(
        disappearingMessagesDurationMs.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('LocalFullConversationsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('participantIdsJson: $participantIdsJson, ')
          ..write('participantsJson: $participantsJson, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageText: $lastMessageText, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCountsJson: $unreadCountsJson, ')
          ..write('archivedJson: $archivedJson, ')
          ..write('pinnedJson: $pinnedJson, ')
          ..write('mutedJson: $mutedJson, ')
          ..write('chatClearedAtJson: $chatClearedAtJson, ')
          ..write('acceptedJson: $acceptedJson, ')
          ..write(
            'disappearingMessagesDurationMs: $disappearingMessagesDurationMs, ',
          )
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPendingMessagesTable extends LocalPendingMessages
    with TableInfo<$LocalPendingMessagesTable, LocalPendingMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPendingMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
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
  static const VerificationMeta _plaintextMeta = const VerificationMeta(
    'plaintext',
  );
  @override
  late final GeneratedColumn<String> plaintext = GeneratedColumn<String>(
    'plaintext',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _replyToMessageIdMeta = const VerificationMeta(
    'replyToMessageId',
  );
  @override
  late final GeneratedColumn<String> replyToMessageId = GeneratedColumn<String>(
    'reply_to_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
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
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    type,
    plaintext,
    recipientId,
    replyToMessageId,
    payloadJson,
    status,
    errorMessage,
    retryCount,
    createdAt,
    lastAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_pending_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPendingMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('plaintext')) {
      context.handle(
        _plaintextMeta,
        plaintext.isAcceptableOrUnknown(data['plaintext']!, _plaintextMeta),
      );
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    }
    if (data.containsKey('reply_to_message_id')) {
      context.handle(
        _replyToMessageIdMeta,
        replyToMessageId.isAcceptableOrUnknown(
          data['reply_to_message_id']!,
          _replyToMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
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
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
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
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPendingMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPendingMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      plaintext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plaintext'],
      ),
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      ),
      replyToMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_message_id'],
      ),
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
    );
  }

  @override
  $LocalPendingMessagesTable createAlias(String alias) {
    return $LocalPendingMessagesTable(attachedDatabase, alias);
  }
}

class LocalPendingMessage extends DataClass
    implements Insertable<LocalPendingMessage> {
  final String id;
  final String conversationId;
  final String type;
  final String? plaintext;
  final String? recipientId;
  final String? replyToMessageId;
  final String? payloadJson;
  final String status;
  final String? errorMessage;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  const LocalPendingMessage({
    required this.id,
    required this.conversationId,
    required this.type,
    this.plaintext,
    this.recipientId,
    this.replyToMessageId,
    this.payloadJson,
    required this.status,
    this.errorMessage,
    required this.retryCount,
    required this.createdAt,
    this.lastAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || plaintext != null) {
      map['plaintext'] = Variable<String>(plaintext);
    }
    if (!nullToAbsent || recipientId != null) {
      map['recipient_id'] = Variable<String>(recipientId);
    }
    if (!nullToAbsent || replyToMessageId != null) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId);
    }
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  LocalPendingMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalPendingMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      type: Value(type),
      plaintext: plaintext == null && nullToAbsent
          ? const Value.absent()
          : Value(plaintext),
      recipientId: recipientId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipientId),
      replyToMessageId: replyToMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToMessageId),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory LocalPendingMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPendingMessage(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      type: serializer.fromJson<String>(json['type']),
      plaintext: serializer.fromJson<String?>(json['plaintext']),
      recipientId: serializer.fromJson<String?>(json['recipientId']),
      replyToMessageId: serializer.fromJson<String?>(json['replyToMessageId']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'type': serializer.toJson<String>(type),
      'plaintext': serializer.toJson<String?>(plaintext),
      'recipientId': serializer.toJson<String?>(recipientId),
      'replyToMessageId': serializer.toJson<String?>(replyToMessageId),
      'payloadJson': serializer.toJson<String?>(payloadJson),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  LocalPendingMessage copyWith({
    String? id,
    String? conversationId,
    String? type,
    Value<String?> plaintext = const Value.absent(),
    Value<String?> recipientId = const Value.absent(),
    Value<String?> replyToMessageId = const Value.absent(),
    Value<String?> payloadJson = const Value.absent(),
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    int? retryCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
  }) => LocalPendingMessage(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    type: type ?? this.type,
    plaintext: plaintext.present ? plaintext.value : this.plaintext,
    recipientId: recipientId.present ? recipientId.value : this.recipientId,
    replyToMessageId: replyToMessageId.present
        ? replyToMessageId.value
        : this.replyToMessageId,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
  );
  LocalPendingMessage copyWithCompanion(LocalPendingMessagesCompanion data) {
    return LocalPendingMessage(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      type: data.type.present ? data.type.value : this.type,
      plaintext: data.plaintext.present ? data.plaintext.value : this.plaintext,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      replyToMessageId: data.replyToMessageId.present
          ? data.replyToMessageId.value
          : this.replyToMessageId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPendingMessage(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('plaintext: $plaintext, ')
          ..write('recipientId: $recipientId, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    type,
    plaintext,
    recipientId,
    replyToMessageId,
    payloadJson,
    status,
    errorMessage,
    retryCount,
    createdAt,
    lastAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPendingMessage &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.type == this.type &&
          other.plaintext == this.plaintext &&
          other.recipientId == this.recipientId &&
          other.replyToMessageId == this.replyToMessageId &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class LocalPendingMessagesCompanion
    extends UpdateCompanion<LocalPendingMessage> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> type;
  final Value<String?> plaintext;
  final Value<String?> recipientId;
  final Value<String?> replyToMessageId;
  final Value<String?> payloadJson;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<int> rowid;
  const LocalPendingMessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.type = const Value.absent(),
    this.plaintext = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPendingMessagesCompanion.insert({
    required String id,
    required String conversationId,
    required String type,
    this.plaintext = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.replyToMessageId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    required String status,
    this.errorMessage = const Value.absent(),
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conversationId = Value(conversationId),
       type = Value(type),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalPendingMessage> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? type,
    Expression<String>? plaintext,
    Expression<String>? recipientId,
    Expression<String>? replyToMessageId,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (type != null) 'type': type,
      if (plaintext != null) 'plaintext': plaintext,
      if (recipientId != null) 'recipient_id': recipientId,
      if (replyToMessageId != null) 'reply_to_message_id': replyToMessageId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPendingMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<String>? type,
    Value<String?>? plaintext,
    Value<String?>? recipientId,
    Value<String?>? replyToMessageId,
    Value<String?>? payloadJson,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<int>? rowid,
  }) {
    return LocalPendingMessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      type: type ?? this.type,
      plaintext: plaintext ?? this.plaintext,
      recipientId: recipientId ?? this.recipientId,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (plaintext.present) {
      map['plaintext'] = Variable<String>(plaintext.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (replyToMessageId.present) {
      map['reply_to_message_id'] = Variable<String>(replyToMessageId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPendingMessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('plaintext: $plaintext, ')
          ..write('recipientId: $recipientId, ')
          ..write('replyToMessageId: $replyToMessageId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCommunitiesTable extends LocalCommunities
    with TableInfo<$LocalCommunitiesTable, LocalCommunity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCommunitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
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
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdsJsonMeta = const VerificationMeta(
    'memberIdsJson',
  );
  @override
  late final GeneratedColumn<String> memberIdsJson = GeneratedColumn<String>(
    'member_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminIdsJsonMeta = const VerificationMeta(
    'adminIdsJson',
  );
  @override
  late final GeneratedColumn<String> adminIdsJson = GeneratedColumn<String>(
    'admin_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberCountMeta = const VerificationMeta(
    'memberCount',
  );
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
    'member_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalBalanceMeta = const VerificationMeta(
    'totalBalance',
  );
  @override
  late final GeneratedColumn<int> totalBalance = GeneratedColumn<int>(
    'total_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _settingsJsonMeta = const VerificationMeta(
    'settingsJson',
  );
  @override
  late final GeneratedColumn<String> settingsJson = GeneratedColumn<String>(
    'settings_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stokvelSettingsJsonMeta =
      const VerificationMeta('stokvelSettingsJson');
  @override
  late final GeneratedColumn<String> stokvelSettingsJson =
      GeneratedColumn<String>(
        'stokvel_settings_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageTextMeta = const VerificationMeta(
    'lastMessageText',
  );
  @override
  late final GeneratedColumn<String> lastMessageText = GeneratedColumn<String>(
    'last_message_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageSenderIdMeta =
      const VerificationMeta('lastMessageSenderId');
  @override
  late final GeneratedColumn<String> lastMessageSenderId =
      GeneratedColumn<String>(
        'last_message_sender_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageSenderNameMeta =
      const VerificationMeta('lastMessageSenderName');
  @override
  late final GeneratedColumn<String> lastMessageSenderName =
      GeneratedColumn<String>(
        'last_message_sender_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageTypeMeta = const VerificationMeta(
    'lastMessageType',
  );
  @override
  late final GeneratedColumn<String> lastMessageType = GeneratedColumn<String>(
    'last_message_type',
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
  static const VerificationMeta _unreadCountsJsonMeta = const VerificationMeta(
    'unreadCountsJson',
  );
  @override
  late final GeneratedColumn<String> unreadCountsJson = GeneratedColumn<String>(
    'unread_counts_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _mutedJsonMeta = const VerificationMeta(
    'mutedJson',
  );
  @override
  late final GeneratedColumn<String> mutedJson = GeneratedColumn<String>(
    'muted_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _encryptedPreviewsJsonMeta =
      const VerificationMeta('encryptedPreviewsJson');
  @override
  late final GeneratedColumn<String> encryptedPreviewsJson =
      GeneratedColumn<String>(
        'encrypted_previews_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    description,
    avatarUrl,
    ownerId,
    memberIdsJson,
    adminIdsJson,
    memberCount,
    totalBalance,
    status,
    settingsJson,
    stokvelSettingsJson,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    unreadCountsJson,
    mutedJson,
    encryptedPreviewsJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_communities';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCommunity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('member_ids_json')) {
      context.handle(
        _memberIdsJsonMeta,
        memberIdsJson.isAcceptableOrUnknown(
          data['member_ids_json']!,
          _memberIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberIdsJsonMeta);
    }
    if (data.containsKey('admin_ids_json')) {
      context.handle(
        _adminIdsJsonMeta,
        adminIdsJson.isAcceptableOrUnknown(
          data['admin_ids_json']!,
          _adminIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_adminIdsJsonMeta);
    }
    if (data.containsKey('member_count')) {
      context.handle(
        _memberCountMeta,
        memberCount.isAcceptableOrUnknown(
          data['member_count']!,
          _memberCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberCountMeta);
    }
    if (data.containsKey('total_balance')) {
      context.handle(
        _totalBalanceMeta,
        totalBalance.isAcceptableOrUnknown(
          data['total_balance']!,
          _totalBalanceMeta,
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
    if (data.containsKey('settings_json')) {
      context.handle(
        _settingsJsonMeta,
        settingsJson.isAcceptableOrUnknown(
          data['settings_json']!,
          _settingsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settingsJsonMeta);
    }
    if (data.containsKey('stokvel_settings_json')) {
      context.handle(
        _stokvelSettingsJsonMeta,
        stokvelSettingsJson.isAcceptableOrUnknown(
          data['stokvel_settings_json']!,
          _stokvelSettingsJsonMeta,
        ),
      );
    }
    if (data.containsKey('last_message_text')) {
      context.handle(
        _lastMessageTextMeta,
        lastMessageText.isAcceptableOrUnknown(
          data['last_message_text']!,
          _lastMessageTextMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_id')) {
      context.handle(
        _lastMessageSenderIdMeta,
        lastMessageSenderId.isAcceptableOrUnknown(
          data['last_message_sender_id']!,
          _lastMessageSenderIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_name')) {
      context.handle(
        _lastMessageSenderNameMeta,
        lastMessageSenderName.isAcceptableOrUnknown(
          data['last_message_sender_name']!,
          _lastMessageSenderNameMeta,
        ),
      );
    }
    if (data.containsKey('last_message_type')) {
      context.handle(
        _lastMessageTypeMeta,
        lastMessageType.isAcceptableOrUnknown(
          data['last_message_type']!,
          _lastMessageTypeMeta,
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
    if (data.containsKey('unread_counts_json')) {
      context.handle(
        _unreadCountsJsonMeta,
        unreadCountsJson.isAcceptableOrUnknown(
          data['unread_counts_json']!,
          _unreadCountsJsonMeta,
        ),
      );
    }
    if (data.containsKey('muted_json')) {
      context.handle(
        _mutedJsonMeta,
        mutedJson.isAcceptableOrUnknown(data['muted_json']!, _mutedJsonMeta),
      );
    }
    if (data.containsKey('encrypted_previews_json')) {
      context.handle(
        _encryptedPreviewsJsonMeta,
        encryptedPreviewsJson.isAcceptableOrUnknown(
          data['encrypted_previews_json']!,
          _encryptedPreviewsJsonMeta,
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCommunity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCommunity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      memberIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_ids_json'],
      )!,
      adminIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_ids_json'],
      )!,
      memberCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_count'],
      )!,
      totalBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_balance'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      settingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settings_json'],
      )!,
      stokvelSettingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stokvel_settings_json'],
      ),
      lastMessageText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_text'],
      ),
      lastMessageSenderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_id'],
      ),
      lastMessageSenderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_name'],
      ),
      lastMessageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_type'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCountsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unread_counts_json'],
      )!,
      mutedJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muted_json'],
      )!,
      encryptedPreviewsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}encrypted_previews_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LocalCommunitiesTable createAlias(String alias) {
    return $LocalCommunitiesTable(attachedDatabase, alias);
  }
}

class LocalCommunity extends DataClass implements Insertable<LocalCommunity> {
  final String id;
  final String type;
  final String name;
  final String? description;
  final String? avatarUrl;
  final String ownerId;
  final String memberIdsJson;
  final String adminIdsJson;
  final int memberCount;
  final int totalBalance;
  final String status;
  final String settingsJson;
  final String? stokvelSettingsJson;
  final String? lastMessageText;
  final String? lastMessageSenderId;
  final String? lastMessageSenderName;
  final String? lastMessageType;
  final DateTime? lastMessageAt;
  final String unreadCountsJson;
  final String mutedJson;
  final String encryptedPreviewsJson;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const LocalCommunity({
    required this.id,
    required this.type,
    required this.name,
    this.description,
    this.avatarUrl,
    required this.ownerId,
    required this.memberIdsJson,
    required this.adminIdsJson,
    required this.memberCount,
    required this.totalBalance,
    required this.status,
    required this.settingsJson,
    this.stokvelSettingsJson,
    this.lastMessageText,
    this.lastMessageSenderId,
    this.lastMessageSenderName,
    this.lastMessageType,
    this.lastMessageAt,
    required this.unreadCountsJson,
    required this.mutedJson,
    required this.encryptedPreviewsJson,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['owner_id'] = Variable<String>(ownerId);
    map['member_ids_json'] = Variable<String>(memberIdsJson);
    map['admin_ids_json'] = Variable<String>(adminIdsJson);
    map['member_count'] = Variable<int>(memberCount);
    map['total_balance'] = Variable<int>(totalBalance);
    map['status'] = Variable<String>(status);
    map['settings_json'] = Variable<String>(settingsJson);
    if (!nullToAbsent || stokvelSettingsJson != null) {
      map['stokvel_settings_json'] = Variable<String>(stokvelSettingsJson);
    }
    if (!nullToAbsent || lastMessageText != null) {
      map['last_message_text'] = Variable<String>(lastMessageText);
    }
    if (!nullToAbsent || lastMessageSenderId != null) {
      map['last_message_sender_id'] = Variable<String>(lastMessageSenderId);
    }
    if (!nullToAbsent || lastMessageSenderName != null) {
      map['last_message_sender_name'] = Variable<String>(lastMessageSenderName);
    }
    if (!nullToAbsent || lastMessageType != null) {
      map['last_message_type'] = Variable<String>(lastMessageType);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_counts_json'] = Variable<String>(unreadCountsJson);
    map['muted_json'] = Variable<String>(mutedJson);
    map['encrypted_previews_json'] = Variable<String>(encryptedPreviewsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  LocalCommunitiesCompanion toCompanion(bool nullToAbsent) {
    return LocalCommunitiesCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      ownerId: Value(ownerId),
      memberIdsJson: Value(memberIdsJson),
      adminIdsJson: Value(adminIdsJson),
      memberCount: Value(memberCount),
      totalBalance: Value(totalBalance),
      status: Value(status),
      settingsJson: Value(settingsJson),
      stokvelSettingsJson: stokvelSettingsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(stokvelSettingsJson),
      lastMessageText: lastMessageText == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageText),
      lastMessageSenderId: lastMessageSenderId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderId),
      lastMessageSenderName: lastMessageSenderName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderName),
      lastMessageType: lastMessageType == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageType),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCountsJson: Value(unreadCountsJson),
      mutedJson: Value(mutedJson),
      encryptedPreviewsJson: Value(encryptedPreviewsJson),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LocalCommunity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCommunity(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      memberIdsJson: serializer.fromJson<String>(json['memberIdsJson']),
      adminIdsJson: serializer.fromJson<String>(json['adminIdsJson']),
      memberCount: serializer.fromJson<int>(json['memberCount']),
      totalBalance: serializer.fromJson<int>(json['totalBalance']),
      status: serializer.fromJson<String>(json['status']),
      settingsJson: serializer.fromJson<String>(json['settingsJson']),
      stokvelSettingsJson: serializer.fromJson<String?>(
        json['stokvelSettingsJson'],
      ),
      lastMessageText: serializer.fromJson<String?>(json['lastMessageText']),
      lastMessageSenderId: serializer.fromJson<String?>(
        json['lastMessageSenderId'],
      ),
      lastMessageSenderName: serializer.fromJson<String?>(
        json['lastMessageSenderName'],
      ),
      lastMessageType: serializer.fromJson<String?>(json['lastMessageType']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCountsJson: serializer.fromJson<String>(json['unreadCountsJson']),
      mutedJson: serializer.fromJson<String>(json['mutedJson']),
      encryptedPreviewsJson: serializer.fromJson<String>(
        json['encryptedPreviewsJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'ownerId': serializer.toJson<String>(ownerId),
      'memberIdsJson': serializer.toJson<String>(memberIdsJson),
      'adminIdsJson': serializer.toJson<String>(adminIdsJson),
      'memberCount': serializer.toJson<int>(memberCount),
      'totalBalance': serializer.toJson<int>(totalBalance),
      'status': serializer.toJson<String>(status),
      'settingsJson': serializer.toJson<String>(settingsJson),
      'stokvelSettingsJson': serializer.toJson<String?>(stokvelSettingsJson),
      'lastMessageText': serializer.toJson<String?>(lastMessageText),
      'lastMessageSenderId': serializer.toJson<String?>(lastMessageSenderId),
      'lastMessageSenderName': serializer.toJson<String?>(
        lastMessageSenderName,
      ),
      'lastMessageType': serializer.toJson<String?>(lastMessageType),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCountsJson': serializer.toJson<String>(unreadCountsJson),
      'mutedJson': serializer.toJson<String>(mutedJson),
      'encryptedPreviewsJson': serializer.toJson<String>(encryptedPreviewsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  LocalCommunity copyWith({
    String? id,
    String? type,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    String? ownerId,
    String? memberIdsJson,
    String? adminIdsJson,
    int? memberCount,
    int? totalBalance,
    String? status,
    String? settingsJson,
    Value<String?> stokvelSettingsJson = const Value.absent(),
    Value<String?> lastMessageText = const Value.absent(),
    Value<String?> lastMessageSenderId = const Value.absent(),
    Value<String?> lastMessageSenderName = const Value.absent(),
    Value<String?> lastMessageType = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    String? unreadCountsJson,
    String? mutedJson,
    String? encryptedPreviewsJson,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => LocalCommunity(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    ownerId: ownerId ?? this.ownerId,
    memberIdsJson: memberIdsJson ?? this.memberIdsJson,
    adminIdsJson: adminIdsJson ?? this.adminIdsJson,
    memberCount: memberCount ?? this.memberCount,
    totalBalance: totalBalance ?? this.totalBalance,
    status: status ?? this.status,
    settingsJson: settingsJson ?? this.settingsJson,
    stokvelSettingsJson: stokvelSettingsJson.present
        ? stokvelSettingsJson.value
        : this.stokvelSettingsJson,
    lastMessageText: lastMessageText.present
        ? lastMessageText.value
        : this.lastMessageText,
    lastMessageSenderId: lastMessageSenderId.present
        ? lastMessageSenderId.value
        : this.lastMessageSenderId,
    lastMessageSenderName: lastMessageSenderName.present
        ? lastMessageSenderName.value
        : this.lastMessageSenderName,
    lastMessageType: lastMessageType.present
        ? lastMessageType.value
        : this.lastMessageType,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCountsJson: unreadCountsJson ?? this.unreadCountsJson,
    mutedJson: mutedJson ?? this.mutedJson,
    encryptedPreviewsJson: encryptedPreviewsJson ?? this.encryptedPreviewsJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LocalCommunity copyWithCompanion(LocalCommunitiesCompanion data) {
    return LocalCommunity(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      memberIdsJson: data.memberIdsJson.present
          ? data.memberIdsJson.value
          : this.memberIdsJson,
      adminIdsJson: data.adminIdsJson.present
          ? data.adminIdsJson.value
          : this.adminIdsJson,
      memberCount: data.memberCount.present
          ? data.memberCount.value
          : this.memberCount,
      totalBalance: data.totalBalance.present
          ? data.totalBalance.value
          : this.totalBalance,
      status: data.status.present ? data.status.value : this.status,
      settingsJson: data.settingsJson.present
          ? data.settingsJson.value
          : this.settingsJson,
      stokvelSettingsJson: data.stokvelSettingsJson.present
          ? data.stokvelSettingsJson.value
          : this.stokvelSettingsJson,
      lastMessageText: data.lastMessageText.present
          ? data.lastMessageText.value
          : this.lastMessageText,
      lastMessageSenderId: data.lastMessageSenderId.present
          ? data.lastMessageSenderId.value
          : this.lastMessageSenderId,
      lastMessageSenderName: data.lastMessageSenderName.present
          ? data.lastMessageSenderName.value
          : this.lastMessageSenderName,
      lastMessageType: data.lastMessageType.present
          ? data.lastMessageType.value
          : this.lastMessageType,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCountsJson: data.unreadCountsJson.present
          ? data.unreadCountsJson.value
          : this.unreadCountsJson,
      mutedJson: data.mutedJson.present ? data.mutedJson.value : this.mutedJson,
      encryptedPreviewsJson: data.encryptedPreviewsJson.present
          ? data.encryptedPreviewsJson.value
          : this.encryptedPreviewsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCommunity(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('ownerId: $ownerId, ')
          ..write('memberIdsJson: $memberIdsJson, ')
          ..write('adminIdsJson: $adminIdsJson, ')
          ..write('memberCount: $memberCount, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('status: $status, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('stokvelSettingsJson: $stokvelSettingsJson, ')
          ..write('lastMessageText: $lastMessageText, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCountsJson: $unreadCountsJson, ')
          ..write('mutedJson: $mutedJson, ')
          ..write('encryptedPreviewsJson: $encryptedPreviewsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    type,
    name,
    description,
    avatarUrl,
    ownerId,
    memberIdsJson,
    adminIdsJson,
    memberCount,
    totalBalance,
    status,
    settingsJson,
    stokvelSettingsJson,
    lastMessageText,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageType,
    lastMessageAt,
    unreadCountsJson,
    mutedJson,
    encryptedPreviewsJson,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCommunity &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.description == this.description &&
          other.avatarUrl == this.avatarUrl &&
          other.ownerId == this.ownerId &&
          other.memberIdsJson == this.memberIdsJson &&
          other.adminIdsJson == this.adminIdsJson &&
          other.memberCount == this.memberCount &&
          other.totalBalance == this.totalBalance &&
          other.status == this.status &&
          other.settingsJson == this.settingsJson &&
          other.stokvelSettingsJson == this.stokvelSettingsJson &&
          other.lastMessageText == this.lastMessageText &&
          other.lastMessageSenderId == this.lastMessageSenderId &&
          other.lastMessageSenderName == this.lastMessageSenderName &&
          other.lastMessageType == this.lastMessageType &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCountsJson == this.unreadCountsJson &&
          other.mutedJson == this.mutedJson &&
          other.encryptedPreviewsJson == this.encryptedPreviewsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalCommunitiesCompanion extends UpdateCompanion<LocalCommunity> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> avatarUrl;
  final Value<String> ownerId;
  final Value<String> memberIdsJson;
  final Value<String> adminIdsJson;
  final Value<int> memberCount;
  final Value<int> totalBalance;
  final Value<String> status;
  final Value<String> settingsJson;
  final Value<String?> stokvelSettingsJson;
  final Value<String?> lastMessageText;
  final Value<String?> lastMessageSenderId;
  final Value<String?> lastMessageSenderName;
  final Value<String?> lastMessageType;
  final Value<DateTime?> lastMessageAt;
  final Value<String> unreadCountsJson;
  final Value<String> mutedJson;
  final Value<String> encryptedPreviewsJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const LocalCommunitiesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.memberIdsJson = const Value.absent(),
    this.adminIdsJson = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.totalBalance = const Value.absent(),
    this.status = const Value.absent(),
    this.settingsJson = const Value.absent(),
    this.stokvelSettingsJson = const Value.absent(),
    this.lastMessageText = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCountsJson = const Value.absent(),
    this.mutedJson = const Value.absent(),
    this.encryptedPreviewsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCommunitiesCompanion.insert({
    required String id,
    required String type,
    required String name,
    this.description = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    required String ownerId,
    required String memberIdsJson,
    required String adminIdsJson,
    required int memberCount,
    this.totalBalance = const Value.absent(),
    required String status,
    required String settingsJson,
    this.stokvelSettingsJson = const Value.absent(),
    this.lastMessageText = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCountsJson = const Value.absent(),
    this.mutedJson = const Value.absent(),
    this.encryptedPreviewsJson = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       name = Value(name),
       ownerId = Value(ownerId),
       memberIdsJson = Value(memberIdsJson),
       adminIdsJson = Value(adminIdsJson),
       memberCount = Value(memberCount),
       status = Value(status),
       settingsJson = Value(settingsJson),
       createdAt = Value(createdAt);
  static Insertable<LocalCommunity> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? avatarUrl,
    Expression<String>? ownerId,
    Expression<String>? memberIdsJson,
    Expression<String>? adminIdsJson,
    Expression<int>? memberCount,
    Expression<int>? totalBalance,
    Expression<String>? status,
    Expression<String>? settingsJson,
    Expression<String>? stokvelSettingsJson,
    Expression<String>? lastMessageText,
    Expression<String>? lastMessageSenderId,
    Expression<String>? lastMessageSenderName,
    Expression<String>? lastMessageType,
    Expression<DateTime>? lastMessageAt,
    Expression<String>? unreadCountsJson,
    Expression<String>? mutedJson,
    Expression<String>? encryptedPreviewsJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (ownerId != null) 'owner_id': ownerId,
      if (memberIdsJson != null) 'member_ids_json': memberIdsJson,
      if (adminIdsJson != null) 'admin_ids_json': adminIdsJson,
      if (memberCount != null) 'member_count': memberCount,
      if (totalBalance != null) 'total_balance': totalBalance,
      if (status != null) 'status': status,
      if (settingsJson != null) 'settings_json': settingsJson,
      if (stokvelSettingsJson != null)
        'stokvel_settings_json': stokvelSettingsJson,
      if (lastMessageText != null) 'last_message_text': lastMessageText,
      if (lastMessageSenderId != null)
        'last_message_sender_id': lastMessageSenderId,
      if (lastMessageSenderName != null)
        'last_message_sender_name': lastMessageSenderName,
      if (lastMessageType != null) 'last_message_type': lastMessageType,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCountsJson != null) 'unread_counts_json': unreadCountsJson,
      if (mutedJson != null) 'muted_json': mutedJson,
      if (encryptedPreviewsJson != null)
        'encrypted_previews_json': encryptedPreviewsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCommunitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? avatarUrl,
    Value<String>? ownerId,
    Value<String>? memberIdsJson,
    Value<String>? adminIdsJson,
    Value<int>? memberCount,
    Value<int>? totalBalance,
    Value<String>? status,
    Value<String>? settingsJson,
    Value<String?>? stokvelSettingsJson,
    Value<String?>? lastMessageText,
    Value<String?>? lastMessageSenderId,
    Value<String?>? lastMessageSenderName,
    Value<String?>? lastMessageType,
    Value<DateTime?>? lastMessageAt,
    Value<String>? unreadCountsJson,
    Value<String>? mutedJson,
    Value<String>? encryptedPreviewsJson,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalCommunitiesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      ownerId: ownerId ?? this.ownerId,
      memberIdsJson: memberIdsJson ?? this.memberIdsJson,
      adminIdsJson: adminIdsJson ?? this.adminIdsJson,
      memberCount: memberCount ?? this.memberCount,
      totalBalance: totalBalance ?? this.totalBalance,
      status: status ?? this.status,
      settingsJson: settingsJson ?? this.settingsJson,
      stokvelSettingsJson: stokvelSettingsJson ?? this.stokvelSettingsJson,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCountsJson: unreadCountsJson ?? this.unreadCountsJson,
      mutedJson: mutedJson ?? this.mutedJson,
      encryptedPreviewsJson:
          encryptedPreviewsJson ?? this.encryptedPreviewsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (memberIdsJson.present) {
      map['member_ids_json'] = Variable<String>(memberIdsJson.value);
    }
    if (adminIdsJson.present) {
      map['admin_ids_json'] = Variable<String>(adminIdsJson.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
    }
    if (totalBalance.present) {
      map['total_balance'] = Variable<int>(totalBalance.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (settingsJson.present) {
      map['settings_json'] = Variable<String>(settingsJson.value);
    }
    if (stokvelSettingsJson.present) {
      map['stokvel_settings_json'] = Variable<String>(
        stokvelSettingsJson.value,
      );
    }
    if (lastMessageText.present) {
      map['last_message_text'] = Variable<String>(lastMessageText.value);
    }
    if (lastMessageSenderId.present) {
      map['last_message_sender_id'] = Variable<String>(
        lastMessageSenderId.value,
      );
    }
    if (lastMessageSenderName.present) {
      map['last_message_sender_name'] = Variable<String>(
        lastMessageSenderName.value,
      );
    }
    if (lastMessageType.present) {
      map['last_message_type'] = Variable<String>(lastMessageType.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCountsJson.present) {
      map['unread_counts_json'] = Variable<String>(unreadCountsJson.value);
    }
    if (mutedJson.present) {
      map['muted_json'] = Variable<String>(mutedJson.value);
    }
    if (encryptedPreviewsJson.present) {
      map['encrypted_previews_json'] = Variable<String>(
        encryptedPreviewsJson.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('LocalCommunitiesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('ownerId: $ownerId, ')
          ..write('memberIdsJson: $memberIdsJson, ')
          ..write('adminIdsJson: $adminIdsJson, ')
          ..write('memberCount: $memberCount, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('status: $status, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('stokvelSettingsJson: $stokvelSettingsJson, ')
          ..write('lastMessageText: $lastMessageText, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCountsJson: $unreadCountsJson, ')
          ..write('mutedJson: $mutedJson, ')
          ..write('encryptedPreviewsJson: $encryptedPreviewsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCommunityMembersTable extends LocalCommunityMembers
    with TableInfo<$LocalCommunityMembersTable, LocalCommunityMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCommunityMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _communityIdMeta = const VerificationMeta(
    'communityId',
  );
  @override
  late final GeneratedColumn<String> communityId = GeneratedColumn<String>(
    'community_id',
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
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
  static const VerificationMeta _contributionBalanceMeta =
      const VerificationMeta('contributionBalance');
  @override
  late final GeneratedColumn<int> contributionBalance = GeneratedColumn<int>(
    'contribution_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invitedByMeta = const VerificationMeta(
    'invitedBy',
  );
  @override
  late final GeneratedColumn<String> invitedBy = GeneratedColumn<String>(
    'invited_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _invitedAtMeta = const VerificationMeta(
    'invitedAt',
  );
  @override
  late final GeneratedColumn<DateTime> invitedAt = GeneratedColumn<DateTime>(
    'invited_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReadAt = GeneratedColumn<DateTime>(
    'last_read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _communityNameMeta = const VerificationMeta(
    'communityName',
  );
  @override
  late final GeneratedColumn<String> communityName = GeneratedColumn<String>(
    'community_name',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    communityId,
    userId,
    displayName,
    avatarUrl,
    role,
    status,
    contributionBalance,
    joinedAt,
    invitedBy,
    invitedAt,
    lastReadAt,
    communityName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_community_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCommunityMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('community_id')) {
      context.handle(
        _communityIdMeta,
        communityId.isAcceptableOrUnknown(
          data['community_id']!,
          _communityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_communityIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('contribution_balance')) {
      context.handle(
        _contributionBalanceMeta,
        contributionBalance.isAcceptableOrUnknown(
          data['contribution_balance']!,
          _contributionBalanceMeta,
        ),
      );
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    }
    if (data.containsKey('invited_by')) {
      context.handle(
        _invitedByMeta,
        invitedBy.isAcceptableOrUnknown(data['invited_by']!, _invitedByMeta),
      );
    }
    if (data.containsKey('invited_at')) {
      context.handle(
        _invitedAtMeta,
        invitedAt.isAcceptableOrUnknown(data['invited_at']!, _invitedAtMeta),
      );
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    }
    if (data.containsKey('community_name')) {
      context.handle(
        _communityNameMeta,
        communityName.isAcceptableOrUnknown(
          data['community_name']!,
          _communityNameMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCommunityMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCommunityMember(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      communityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      contributionBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}contribution_balance'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      ),
      invitedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invited_by'],
      )!,
      invitedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invited_at'],
      ),
      lastReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_read_at'],
      ),
      communityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalCommunityMembersTable createAlias(String alias) {
    return $LocalCommunityMembersTable(attachedDatabase, alias);
  }
}

class LocalCommunityMember extends DataClass
    implements Insertable<LocalCommunityMember> {
  final String id;
  final String communityId;
  final String userId;
  final String displayName;
  final String? avatarUrl;
  final String role;
  final String status;
  final int contributionBalance;
  final DateTime? joinedAt;
  final String invitedBy;
  final DateTime? invitedAt;
  final DateTime? lastReadAt;
  final String? communityName;
  final DateTime createdAt;
  const LocalCommunityMember({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    required this.role,
    required this.status,
    required this.contributionBalance,
    this.joinedAt,
    required this.invitedBy,
    this.invitedAt,
    this.lastReadAt,
    this.communityName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['community_id'] = Variable<String>(communityId);
    map['user_id'] = Variable<String>(userId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['contribution_balance'] = Variable<int>(contributionBalance);
    if (!nullToAbsent || joinedAt != null) {
      map['joined_at'] = Variable<DateTime>(joinedAt);
    }
    map['invited_by'] = Variable<String>(invitedBy);
    if (!nullToAbsent || invitedAt != null) {
      map['invited_at'] = Variable<DateTime>(invitedAt);
    }
    if (!nullToAbsent || lastReadAt != null) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt);
    }
    if (!nullToAbsent || communityName != null) {
      map['community_name'] = Variable<String>(communityName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalCommunityMembersCompanion toCompanion(bool nullToAbsent) {
    return LocalCommunityMembersCompanion(
      id: Value(id),
      communityId: Value(communityId),
      userId: Value(userId),
      displayName: Value(displayName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      role: Value(role),
      status: Value(status),
      contributionBalance: Value(contributionBalance),
      joinedAt: joinedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(joinedAt),
      invitedBy: Value(invitedBy),
      invitedAt: invitedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(invitedAt),
      lastReadAt: lastReadAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadAt),
      communityName: communityName == null && nullToAbsent
          ? const Value.absent()
          : Value(communityName),
      createdAt: Value(createdAt),
    );
  }

  factory LocalCommunityMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCommunityMember(
      id: serializer.fromJson<String>(json['id']),
      communityId: serializer.fromJson<String>(json['communityId']),
      userId: serializer.fromJson<String>(json['userId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      contributionBalance: serializer.fromJson<int>(
        json['contributionBalance'],
      ),
      joinedAt: serializer.fromJson<DateTime?>(json['joinedAt']),
      invitedBy: serializer.fromJson<String>(json['invitedBy']),
      invitedAt: serializer.fromJson<DateTime?>(json['invitedAt']),
      lastReadAt: serializer.fromJson<DateTime?>(json['lastReadAt']),
      communityName: serializer.fromJson<String?>(json['communityName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'communityId': serializer.toJson<String>(communityId),
      'userId': serializer.toJson<String>(userId),
      'displayName': serializer.toJson<String>(displayName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'contributionBalance': serializer.toJson<int>(contributionBalance),
      'joinedAt': serializer.toJson<DateTime?>(joinedAt),
      'invitedBy': serializer.toJson<String>(invitedBy),
      'invitedAt': serializer.toJson<DateTime?>(invitedAt),
      'lastReadAt': serializer.toJson<DateTime?>(lastReadAt),
      'communityName': serializer.toJson<String?>(communityName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalCommunityMember copyWith({
    String? id,
    String? communityId,
    String? userId,
    String? displayName,
    Value<String?> avatarUrl = const Value.absent(),
    String? role,
    String? status,
    int? contributionBalance,
    Value<DateTime?> joinedAt = const Value.absent(),
    String? invitedBy,
    Value<DateTime?> invitedAt = const Value.absent(),
    Value<DateTime?> lastReadAt = const Value.absent(),
    Value<String?> communityName = const Value.absent(),
    DateTime? createdAt,
  }) => LocalCommunityMember(
    id: id ?? this.id,
    communityId: communityId ?? this.communityId,
    userId: userId ?? this.userId,
    displayName: displayName ?? this.displayName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    role: role ?? this.role,
    status: status ?? this.status,
    contributionBalance: contributionBalance ?? this.contributionBalance,
    joinedAt: joinedAt.present ? joinedAt.value : this.joinedAt,
    invitedBy: invitedBy ?? this.invitedBy,
    invitedAt: invitedAt.present ? invitedAt.value : this.invitedAt,
    lastReadAt: lastReadAt.present ? lastReadAt.value : this.lastReadAt,
    communityName: communityName.present
        ? communityName.value
        : this.communityName,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalCommunityMember copyWithCompanion(LocalCommunityMembersCompanion data) {
    return LocalCommunityMember(
      id: data.id.present ? data.id.value : this.id,
      communityId: data.communityId.present
          ? data.communityId.value
          : this.communityId,
      userId: data.userId.present ? data.userId.value : this.userId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      contributionBalance: data.contributionBalance.present
          ? data.contributionBalance.value
          : this.contributionBalance,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      invitedBy: data.invitedBy.present ? data.invitedBy.value : this.invitedBy,
      invitedAt: data.invitedAt.present ? data.invitedAt.value : this.invitedAt,
      lastReadAt: data.lastReadAt.present
          ? data.lastReadAt.value
          : this.lastReadAt,
      communityName: data.communityName.present
          ? data.communityName.value
          : this.communityName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCommunityMember(')
          ..write('id: $id, ')
          ..write('communityId: $communityId, ')
          ..write('userId: $userId, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('contributionBalance: $contributionBalance, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedAt: $invitedAt, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('communityName: $communityName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    communityId,
    userId,
    displayName,
    avatarUrl,
    role,
    status,
    contributionBalance,
    joinedAt,
    invitedBy,
    invitedAt,
    lastReadAt,
    communityName,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCommunityMember &&
          other.id == this.id &&
          other.communityId == this.communityId &&
          other.userId == this.userId &&
          other.displayName == this.displayName &&
          other.avatarUrl == this.avatarUrl &&
          other.role == this.role &&
          other.status == this.status &&
          other.contributionBalance == this.contributionBalance &&
          other.joinedAt == this.joinedAt &&
          other.invitedBy == this.invitedBy &&
          other.invitedAt == this.invitedAt &&
          other.lastReadAt == this.lastReadAt &&
          other.communityName == this.communityName &&
          other.createdAt == this.createdAt);
}

class LocalCommunityMembersCompanion
    extends UpdateCompanion<LocalCommunityMember> {
  final Value<String> id;
  final Value<String> communityId;
  final Value<String> userId;
  final Value<String> displayName;
  final Value<String?> avatarUrl;
  final Value<String> role;
  final Value<String> status;
  final Value<int> contributionBalance;
  final Value<DateTime?> joinedAt;
  final Value<String> invitedBy;
  final Value<DateTime?> invitedAt;
  final Value<DateTime?> lastReadAt;
  final Value<String?> communityName;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalCommunityMembersCompanion({
    this.id = const Value.absent(),
    this.communityId = const Value.absent(),
    this.userId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.contributionBalance = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.invitedBy = const Value.absent(),
    this.invitedAt = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.communityName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCommunityMembersCompanion.insert({
    required String id,
    required String communityId,
    required String userId,
    required String displayName,
    this.avatarUrl = const Value.absent(),
    required String role,
    required String status,
    this.contributionBalance = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.invitedBy = const Value.absent(),
    this.invitedAt = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.communityName = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       communityId = Value(communityId),
       userId = Value(userId),
       displayName = Value(displayName),
       role = Value(role),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<LocalCommunityMember> custom({
    Expression<String>? id,
    Expression<String>? communityId,
    Expression<String>? userId,
    Expression<String>? displayName,
    Expression<String>? avatarUrl,
    Expression<String>? role,
    Expression<String>? status,
    Expression<int>? contributionBalance,
    Expression<DateTime>? joinedAt,
    Expression<String>? invitedBy,
    Expression<DateTime>? invitedAt,
    Expression<DateTime>? lastReadAt,
    Expression<String>? communityName,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (communityId != null) 'community_id': communityId,
      if (userId != null) 'user_id': userId,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (contributionBalance != null)
        'contribution_balance': contributionBalance,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (invitedBy != null) 'invited_by': invitedBy,
      if (invitedAt != null) 'invited_at': invitedAt,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
      if (communityName != null) 'community_name': communityName,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCommunityMembersCompanion copyWith({
    Value<String>? id,
    Value<String>? communityId,
    Value<String>? userId,
    Value<String>? displayName,
    Value<String?>? avatarUrl,
    Value<String>? role,
    Value<String>? status,
    Value<int>? contributionBalance,
    Value<DateTime?>? joinedAt,
    Value<String>? invitedBy,
    Value<DateTime?>? invitedAt,
    Value<DateTime?>? lastReadAt,
    Value<String?>? communityName,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalCommunityMembersCompanion(
      id: id ?? this.id,
      communityId: communityId ?? this.communityId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      status: status ?? this.status,
      contributionBalance: contributionBalance ?? this.contributionBalance,
      joinedAt: joinedAt ?? this.joinedAt,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedAt: invitedAt ?? this.invitedAt,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      communityName: communityName ?? this.communityName,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (communityId.present) {
      map['community_id'] = Variable<String>(communityId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (contributionBalance.present) {
      map['contribution_balance'] = Variable<int>(contributionBalance.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (invitedBy.present) {
      map['invited_by'] = Variable<String>(invitedBy.value);
    }
    if (invitedAt.present) {
      map['invited_at'] = Variable<DateTime>(invitedAt.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt.value);
    }
    if (communityName.present) {
      map['community_name'] = Variable<String>(communityName.value);
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
    return (StringBuffer('LocalCommunityMembersCompanion(')
          ..write('id: $id, ')
          ..write('communityId: $communityId, ')
          ..write('userId: $userId, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('contributionBalance: $contributionBalance, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedAt: $invitedAt, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('communityName: $communityName, ')
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
  late final $LocalFullMessagesTable localFullMessages =
      $LocalFullMessagesTable(this);
  late final $LocalFullConversationsTable localFullConversations =
      $LocalFullConversationsTable(this);
  late final $LocalPendingMessagesTable localPendingMessages =
      $LocalPendingMessagesTable(this);
  late final $LocalCommunitiesTable localCommunities = $LocalCommunitiesTable(
    this,
  );
  late final $LocalCommunityMembersTable localCommunityMembers =
      $LocalCommunityMembersTable(this);
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
    localFullMessages,
    localFullConversations,
    localPendingMessages,
    localCommunities,
    localCommunityMembers,
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
typedef $$LocalFullMessagesTableCreateCompanionBuilder =
    LocalFullMessagesCompanion Function({
      required String id,
      required String conversationId,
      required String senderId,
      required String senderName,
      Value<String?> senderAvatarUrl,
      required String type,
      required String status,
      Value<String?> textContent,
      Value<int?> tokenAmount,
      Value<String?> recipientId,
      Value<String?> ledgerJournalId,
      Value<String?> mediaJson,
      Value<String?> reactionsJson,
      Value<String?> replyToJson,
      Value<String?> giftJson,
      Value<String?> tokenSprayJson,
      Value<String?> communityId,
      Value<String?> systemEventType,
      Value<String?> systemEventDataJson,
      required DateTime createdAt,
      Value<DateTime?> expiresAt,
      Value<DateTime?> actionedAt,
      Value<DateTime?> deletedAt,
      Value<String> deletedForJson,
      Value<bool> deletedForEveryone,
      Value<bool> isDecrypted,
      Value<String> readByJson,
      Value<String?> forwardedFromJson,
      Value<int> rowid,
    });
typedef $$LocalFullMessagesTableUpdateCompanionBuilder =
    LocalFullMessagesCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<String> senderId,
      Value<String> senderName,
      Value<String?> senderAvatarUrl,
      Value<String> type,
      Value<String> status,
      Value<String?> textContent,
      Value<int?> tokenAmount,
      Value<String?> recipientId,
      Value<String?> ledgerJournalId,
      Value<String?> mediaJson,
      Value<String?> reactionsJson,
      Value<String?> replyToJson,
      Value<String?> giftJson,
      Value<String?> tokenSprayJson,
      Value<String?> communityId,
      Value<String?> systemEventType,
      Value<String?> systemEventDataJson,
      Value<DateTime> createdAt,
      Value<DateTime?> expiresAt,
      Value<DateTime?> actionedAt,
      Value<DateTime?> deletedAt,
      Value<String> deletedForJson,
      Value<bool> deletedForEveryone,
      Value<bool> isDecrypted,
      Value<String> readByJson,
      Value<String?> forwardedFromJson,
      Value<int> rowid,
    });

class $$LocalFullMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalFullMessagesTable> {
  $$LocalFullMessagesTableFilterComposer({
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

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderAvatarUrl => $composableBuilder(
    column: $table.senderAvatarUrl,
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

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ledgerJournalId => $composableBuilder(
    column: $table.ledgerJournalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaJson => $composableBuilder(
    column: $table.mediaJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToJson => $composableBuilder(
    column: $table.replyToJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get giftJson => $composableBuilder(
    column: $table.giftJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tokenSprayJson => $composableBuilder(
    column: $table.tokenSprayJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemEventType => $composableBuilder(
    column: $table.systemEventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemEventDataJson => $composableBuilder(
    column: $table.systemEventDataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actionedAt => $composableBuilder(
    column: $table.actionedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedForJson => $composableBuilder(
    column: $table.deletedForJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deletedForEveryone => $composableBuilder(
    column: $table.deletedForEveryone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDecrypted => $composableBuilder(
    column: $table.isDecrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readByJson => $composableBuilder(
    column: $table.readByJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get forwardedFromJson => $composableBuilder(
    column: $table.forwardedFromJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalFullMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalFullMessagesTable> {
  $$LocalFullMessagesTableOrderingComposer({
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

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderAvatarUrl => $composableBuilder(
    column: $table.senderAvatarUrl,
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

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ledgerJournalId => $composableBuilder(
    column: $table.ledgerJournalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaJson => $composableBuilder(
    column: $table.mediaJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToJson => $composableBuilder(
    column: $table.replyToJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get giftJson => $composableBuilder(
    column: $table.giftJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tokenSprayJson => $composableBuilder(
    column: $table.tokenSprayJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemEventType => $composableBuilder(
    column: $table.systemEventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemEventDataJson => $composableBuilder(
    column: $table.systemEventDataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actionedAt => $composableBuilder(
    column: $table.actionedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedForJson => $composableBuilder(
    column: $table.deletedForJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deletedForEveryone => $composableBuilder(
    column: $table.deletedForEveryone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDecrypted => $composableBuilder(
    column: $table.isDecrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readByJson => $composableBuilder(
    column: $table.readByJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get forwardedFromJson => $composableBuilder(
    column: $table.forwardedFromJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalFullMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalFullMessagesTable> {
  $$LocalFullMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderAvatarUrl => $composableBuilder(
    column: $table.senderAvatarUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tokenAmount => $composableBuilder(
    column: $table.tokenAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ledgerJournalId => $composableBuilder(
    column: $table.ledgerJournalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediaJson =>
      $composableBuilder(column: $table.mediaJson, builder: (column) => column);

  GeneratedColumn<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyToJson => $composableBuilder(
    column: $table.replyToJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get giftJson =>
      $composableBuilder(column: $table.giftJson, builder: (column) => column);

  GeneratedColumn<String> get tokenSprayJson => $composableBuilder(
    column: $table.tokenSprayJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemEventType => $composableBuilder(
    column: $table.systemEventType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get systemEventDataJson => $composableBuilder(
    column: $table.systemEventDataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<DateTime> get actionedAt => $composableBuilder(
    column: $table.actionedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedForJson => $composableBuilder(
    column: $table.deletedForJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deletedForEveryone => $composableBuilder(
    column: $table.deletedForEveryone,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDecrypted => $composableBuilder(
    column: $table.isDecrypted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readByJson => $composableBuilder(
    column: $table.readByJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get forwardedFromJson => $composableBuilder(
    column: $table.forwardedFromJson,
    builder: (column) => column,
  );
}

class $$LocalFullMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalFullMessagesTable,
          LocalFullMessage,
          $$LocalFullMessagesTableFilterComposer,
          $$LocalFullMessagesTableOrderingComposer,
          $$LocalFullMessagesTableAnnotationComposer,
          $$LocalFullMessagesTableCreateCompanionBuilder,
          $$LocalFullMessagesTableUpdateCompanionBuilder,
          (
            LocalFullMessage,
            BaseReferences<
              _$AppDatabase,
              $LocalFullMessagesTable,
              LocalFullMessage
            >,
          ),
          LocalFullMessage,
          PrefetchHooks Function()
        > {
  $$LocalFullMessagesTableTableManager(
    _$AppDatabase db,
    $LocalFullMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFullMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalFullMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalFullMessagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String?> senderAvatarUrl = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> textContent = const Value.absent(),
                Value<int?> tokenAmount = const Value.absent(),
                Value<String?> recipientId = const Value.absent(),
                Value<String?> ledgerJournalId = const Value.absent(),
                Value<String?> mediaJson = const Value.absent(),
                Value<String?> reactionsJson = const Value.absent(),
                Value<String?> replyToJson = const Value.absent(),
                Value<String?> giftJson = const Value.absent(),
                Value<String?> tokenSprayJson = const Value.absent(),
                Value<String?> communityId = const Value.absent(),
                Value<String?> systemEventType = const Value.absent(),
                Value<String?> systemEventDataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime?> actionedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> deletedForJson = const Value.absent(),
                Value<bool> deletedForEveryone = const Value.absent(),
                Value<bool> isDecrypted = const Value.absent(),
                Value<String> readByJson = const Value.absent(),
                Value<String?> forwardedFromJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFullMessagesCompanion(
                id: id,
                conversationId: conversationId,
                senderId: senderId,
                senderName: senderName,
                senderAvatarUrl: senderAvatarUrl,
                type: type,
                status: status,
                textContent: textContent,
                tokenAmount: tokenAmount,
                recipientId: recipientId,
                ledgerJournalId: ledgerJournalId,
                mediaJson: mediaJson,
                reactionsJson: reactionsJson,
                replyToJson: replyToJson,
                giftJson: giftJson,
                tokenSprayJson: tokenSprayJson,
                communityId: communityId,
                systemEventType: systemEventType,
                systemEventDataJson: systemEventDataJson,
                createdAt: createdAt,
                expiresAt: expiresAt,
                actionedAt: actionedAt,
                deletedAt: deletedAt,
                deletedForJson: deletedForJson,
                deletedForEveryone: deletedForEveryone,
                isDecrypted: isDecrypted,
                readByJson: readByJson,
                forwardedFromJson: forwardedFromJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conversationId,
                required String senderId,
                required String senderName,
                Value<String?> senderAvatarUrl = const Value.absent(),
                required String type,
                required String status,
                Value<String?> textContent = const Value.absent(),
                Value<int?> tokenAmount = const Value.absent(),
                Value<String?> recipientId = const Value.absent(),
                Value<String?> ledgerJournalId = const Value.absent(),
                Value<String?> mediaJson = const Value.absent(),
                Value<String?> reactionsJson = const Value.absent(),
                Value<String?> replyToJson = const Value.absent(),
                Value<String?> giftJson = const Value.absent(),
                Value<String?> tokenSprayJson = const Value.absent(),
                Value<String?> communityId = const Value.absent(),
                Value<String?> systemEventType = const Value.absent(),
                Value<String?> systemEventDataJson = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<DateTime?> actionedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> deletedForJson = const Value.absent(),
                Value<bool> deletedForEveryone = const Value.absent(),
                Value<bool> isDecrypted = const Value.absent(),
                Value<String> readByJson = const Value.absent(),
                Value<String?> forwardedFromJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFullMessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                senderId: senderId,
                senderName: senderName,
                senderAvatarUrl: senderAvatarUrl,
                type: type,
                status: status,
                textContent: textContent,
                tokenAmount: tokenAmount,
                recipientId: recipientId,
                ledgerJournalId: ledgerJournalId,
                mediaJson: mediaJson,
                reactionsJson: reactionsJson,
                replyToJson: replyToJson,
                giftJson: giftJson,
                tokenSprayJson: tokenSprayJson,
                communityId: communityId,
                systemEventType: systemEventType,
                systemEventDataJson: systemEventDataJson,
                createdAt: createdAt,
                expiresAt: expiresAt,
                actionedAt: actionedAt,
                deletedAt: deletedAt,
                deletedForJson: deletedForJson,
                deletedForEveryone: deletedForEveryone,
                isDecrypted: isDecrypted,
                readByJson: readByJson,
                forwardedFromJson: forwardedFromJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalFullMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalFullMessagesTable,
      LocalFullMessage,
      $$LocalFullMessagesTableFilterComposer,
      $$LocalFullMessagesTableOrderingComposer,
      $$LocalFullMessagesTableAnnotationComposer,
      $$LocalFullMessagesTableCreateCompanionBuilder,
      $$LocalFullMessagesTableUpdateCompanionBuilder,
      (
        LocalFullMessage,
        BaseReferences<
          _$AppDatabase,
          $LocalFullMessagesTable,
          LocalFullMessage
        >,
      ),
      LocalFullMessage,
      PrefetchHooks Function()
    >;
typedef $$LocalFullConversationsTableCreateCompanionBuilder =
    LocalFullConversationsCompanion Function({
      required String id,
      required String type,
      required String participantIdsJson,
      required String participantsJson,
      Value<String?> lastMessageId,
      Value<String?> lastMessageText,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<String?> lastMessageType,
      Value<DateTime?> lastMessageAt,
      Value<String> unreadCountsJson,
      Value<String> archivedJson,
      Value<String> pinnedJson,
      Value<String> mutedJson,
      Value<String> chatClearedAtJson,
      Value<String> acceptedJson,
      Value<int?> disappearingMessagesDurationMs,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$LocalFullConversationsTableUpdateCompanionBuilder =
    LocalFullConversationsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> participantIdsJson,
      Value<String> participantsJson,
      Value<String?> lastMessageId,
      Value<String?> lastMessageText,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<String?> lastMessageType,
      Value<DateTime?> lastMessageAt,
      Value<String> unreadCountsJson,
      Value<String> archivedJson,
      Value<String> pinnedJson,
      Value<String> mutedJson,
      Value<String> chatClearedAtJson,
      Value<String> acceptedJson,
      Value<int?> disappearingMessagesDurationMs,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$LocalFullConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalFullConversationsTable> {
  $$LocalFullConversationsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get participantIdsJson => $composableBuilder(
    column: $table.participantIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get archivedJson => $composableBuilder(
    column: $table.archivedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinnedJson => $composableBuilder(
    column: $table.pinnedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mutedJson => $composableBuilder(
    column: $table.mutedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatClearedAtJson => $composableBuilder(
    column: $table.chatClearedAtJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get acceptedJson => $composableBuilder(
    column: $table.acceptedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disappearingMessagesDurationMs => $composableBuilder(
    column: $table.disappearingMessagesDurationMs,
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
}

class $$LocalFullConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalFullConversationsTable> {
  $$LocalFullConversationsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get participantIdsJson => $composableBuilder(
    column: $table.participantIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get archivedJson => $composableBuilder(
    column: $table.archivedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinnedJson => $composableBuilder(
    column: $table.pinnedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mutedJson => $composableBuilder(
    column: $table.mutedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatClearedAtJson => $composableBuilder(
    column: $table.chatClearedAtJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get acceptedJson => $composableBuilder(
    column: $table.acceptedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disappearingMessagesDurationMs => $composableBuilder(
    column: $table.disappearingMessagesDurationMs,
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
}

class $$LocalFullConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalFullConversationsTable> {
  $$LocalFullConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get participantIdsJson => $composableBuilder(
    column: $table.participantIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get archivedJson => $composableBuilder(
    column: $table.archivedJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pinnedJson => $composableBuilder(
    column: $table.pinnedJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mutedJson =>
      $composableBuilder(column: $table.mutedJson, builder: (column) => column);

  GeneratedColumn<String> get chatClearedAtJson => $composableBuilder(
    column: $table.chatClearedAtJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get acceptedJson => $composableBuilder(
    column: $table.acceptedJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disappearingMessagesDurationMs => $composableBuilder(
    column: $table.disappearingMessagesDurationMs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalFullConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalFullConversationsTable,
          LocalFullConversation,
          $$LocalFullConversationsTableFilterComposer,
          $$LocalFullConversationsTableOrderingComposer,
          $$LocalFullConversationsTableAnnotationComposer,
          $$LocalFullConversationsTableCreateCompanionBuilder,
          $$LocalFullConversationsTableUpdateCompanionBuilder,
          (
            LocalFullConversation,
            BaseReferences<
              _$AppDatabase,
              $LocalFullConversationsTable,
              LocalFullConversation
            >,
          ),
          LocalFullConversation,
          PrefetchHooks Function()
        > {
  $$LocalFullConversationsTableTableManager(
    _$AppDatabase db,
    $LocalFullConversationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFullConversationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalFullConversationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalFullConversationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> participantIdsJson = const Value.absent(),
                Value<String> participantsJson = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageText = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String> unreadCountsJson = const Value.absent(),
                Value<String> archivedJson = const Value.absent(),
                Value<String> pinnedJson = const Value.absent(),
                Value<String> mutedJson = const Value.absent(),
                Value<String> chatClearedAtJson = const Value.absent(),
                Value<String> acceptedJson = const Value.absent(),
                Value<int?> disappearingMessagesDurationMs =
                    const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFullConversationsCompanion(
                id: id,
                type: type,
                participantIdsJson: participantIdsJson,
                participantsJson: participantsJson,
                lastMessageId: lastMessageId,
                lastMessageText: lastMessageText,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageType: lastMessageType,
                lastMessageAt: lastMessageAt,
                unreadCountsJson: unreadCountsJson,
                archivedJson: archivedJson,
                pinnedJson: pinnedJson,
                mutedJson: mutedJson,
                chatClearedAtJson: chatClearedAtJson,
                acceptedJson: acceptedJson,
                disappearingMessagesDurationMs: disappearingMessagesDurationMs,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String participantIdsJson,
                required String participantsJson,
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageText = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String> unreadCountsJson = const Value.absent(),
                Value<String> archivedJson = const Value.absent(),
                Value<String> pinnedJson = const Value.absent(),
                Value<String> mutedJson = const Value.absent(),
                Value<String> chatClearedAtJson = const Value.absent(),
                Value<String> acceptedJson = const Value.absent(),
                Value<int?> disappearingMessagesDurationMs =
                    const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalFullConversationsCompanion.insert(
                id: id,
                type: type,
                participantIdsJson: participantIdsJson,
                participantsJson: participantsJson,
                lastMessageId: lastMessageId,
                lastMessageText: lastMessageText,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageType: lastMessageType,
                lastMessageAt: lastMessageAt,
                unreadCountsJson: unreadCountsJson,
                archivedJson: archivedJson,
                pinnedJson: pinnedJson,
                mutedJson: mutedJson,
                chatClearedAtJson: chatClearedAtJson,
                acceptedJson: acceptedJson,
                disappearingMessagesDurationMs: disappearingMessagesDurationMs,
                createdAt: createdAt,
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

typedef $$LocalFullConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalFullConversationsTable,
      LocalFullConversation,
      $$LocalFullConversationsTableFilterComposer,
      $$LocalFullConversationsTableOrderingComposer,
      $$LocalFullConversationsTableAnnotationComposer,
      $$LocalFullConversationsTableCreateCompanionBuilder,
      $$LocalFullConversationsTableUpdateCompanionBuilder,
      (
        LocalFullConversation,
        BaseReferences<
          _$AppDatabase,
          $LocalFullConversationsTable,
          LocalFullConversation
        >,
      ),
      LocalFullConversation,
      PrefetchHooks Function()
    >;
typedef $$LocalPendingMessagesTableCreateCompanionBuilder =
    LocalPendingMessagesCompanion Function({
      required String id,
      required String conversationId,
      required String type,
      Value<String?> plaintext,
      Value<String?> recipientId,
      Value<String?> replyToMessageId,
      Value<String?> payloadJson,
      required String status,
      Value<String?> errorMessage,
      Value<int> retryCount,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> rowid,
    });
typedef $$LocalPendingMessagesTableUpdateCompanionBuilder =
    LocalPendingMessagesCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<String> type,
      Value<String?> plaintext,
      Value<String?> recipientId,
      Value<String?> replyToMessageId,
      Value<String?> payloadJson,
      Value<String> status,
      Value<String?> errorMessage,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<int> rowid,
    });

class $$LocalPendingMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPendingMessagesTable> {
  $$LocalPendingMessagesTableFilterComposer({
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

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plaintext => $composableBuilder(
    column: $table.plaintext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalPendingMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPendingMessagesTable> {
  $$LocalPendingMessagesTableOrderingComposer({
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

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plaintext => $composableBuilder(
    column: $table.plaintext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPendingMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPendingMessagesTable> {
  $$LocalPendingMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get plaintext =>
      $composableBuilder(column: $table.plaintext, builder: (column) => column);

  GeneratedColumn<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyToMessageId => $composableBuilder(
    column: $table.replyToMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );
}

class $$LocalPendingMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPendingMessagesTable,
          LocalPendingMessage,
          $$LocalPendingMessagesTableFilterComposer,
          $$LocalPendingMessagesTableOrderingComposer,
          $$LocalPendingMessagesTableAnnotationComposer,
          $$LocalPendingMessagesTableCreateCompanionBuilder,
          $$LocalPendingMessagesTableUpdateCompanionBuilder,
          (
            LocalPendingMessage,
            BaseReferences<
              _$AppDatabase,
              $LocalPendingMessagesTable,
              LocalPendingMessage
            >,
          ),
          LocalPendingMessage,
          PrefetchHooks Function()
        > {
  $$LocalPendingMessagesTableTableManager(
    _$AppDatabase db,
    $LocalPendingMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPendingMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPendingMessagesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalPendingMessagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> plaintext = const Value.absent(),
                Value<String?> recipientId = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPendingMessagesCompanion(
                id: id,
                conversationId: conversationId,
                type: type,
                plaintext: plaintext,
                recipientId: recipientId,
                replyToMessageId: replyToMessageId,
                payloadJson: payloadJson,
                status: status,
                errorMessage: errorMessage,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conversationId,
                required String type,
                Value<String?> plaintext = const Value.absent(),
                Value<String?> recipientId = const Value.absent(),
                Value<String?> replyToMessageId = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPendingMessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                type: type,
                plaintext: plaintext,
                recipientId: recipientId,
                replyToMessageId: replyToMessageId,
                payloadJson: payloadJson,
                status: status,
                errorMessage: errorMessage,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalPendingMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPendingMessagesTable,
      LocalPendingMessage,
      $$LocalPendingMessagesTableFilterComposer,
      $$LocalPendingMessagesTableOrderingComposer,
      $$LocalPendingMessagesTableAnnotationComposer,
      $$LocalPendingMessagesTableCreateCompanionBuilder,
      $$LocalPendingMessagesTableUpdateCompanionBuilder,
      (
        LocalPendingMessage,
        BaseReferences<
          _$AppDatabase,
          $LocalPendingMessagesTable,
          LocalPendingMessage
        >,
      ),
      LocalPendingMessage,
      PrefetchHooks Function()
    >;
typedef $$LocalCommunitiesTableCreateCompanionBuilder =
    LocalCommunitiesCompanion Function({
      required String id,
      required String type,
      required String name,
      Value<String?> description,
      Value<String?> avatarUrl,
      required String ownerId,
      required String memberIdsJson,
      required String adminIdsJson,
      required int memberCount,
      Value<int> totalBalance,
      required String status,
      required String settingsJson,
      Value<String?> stokvelSettingsJson,
      Value<String?> lastMessageText,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<String?> lastMessageType,
      Value<DateTime?> lastMessageAt,
      Value<String> unreadCountsJson,
      Value<String> mutedJson,
      Value<String> encryptedPreviewsJson,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$LocalCommunitiesTableUpdateCompanionBuilder =
    LocalCommunitiesCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> name,
      Value<String?> description,
      Value<String?> avatarUrl,
      Value<String> ownerId,
      Value<String> memberIdsJson,
      Value<String> adminIdsJson,
      Value<int> memberCount,
      Value<int> totalBalance,
      Value<String> status,
      Value<String> settingsJson,
      Value<String?> stokvelSettingsJson,
      Value<String?> lastMessageText,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<String?> lastMessageType,
      Value<DateTime?> lastMessageAt,
      Value<String> unreadCountsJson,
      Value<String> mutedJson,
      Value<String> encryptedPreviewsJson,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$LocalCommunitiesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCommunitiesTable> {
  $$LocalCommunitiesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberIdsJson => $composableBuilder(
    column: $table.memberIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminIdsJson => $composableBuilder(
    column: $table.adminIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stokvelSettingsJson => $composableBuilder(
    column: $table.stokvelSettingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mutedJson => $composableBuilder(
    column: $table.mutedJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get encryptedPreviewsJson => $composableBuilder(
    column: $table.encryptedPreviewsJson,
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
}

class $$LocalCommunitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCommunitiesTable> {
  $$LocalCommunitiesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberIdsJson => $composableBuilder(
    column: $table.memberIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminIdsJson => $composableBuilder(
    column: $table.adminIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stokvelSettingsJson => $composableBuilder(
    column: $table.stokvelSettingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mutedJson => $composableBuilder(
    column: $table.mutedJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get encryptedPreviewsJson => $composableBuilder(
    column: $table.encryptedPreviewsJson,
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
}

class $$LocalCommunitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCommunitiesTable> {
  $$LocalCommunitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get memberIdsJson => $composableBuilder(
    column: $table.memberIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get adminIdsJson => $composableBuilder(
    column: $table.adminIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get memberCount => $composableBuilder(
    column: $table.memberCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBalance => $composableBuilder(
    column: $table.totalBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stokvelSettingsJson => $composableBuilder(
    column: $table.stokvelSettingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageText => $composableBuilder(
    column: $table.lastMessageText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unreadCountsJson => $composableBuilder(
    column: $table.unreadCountsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mutedJson =>
      $composableBuilder(column: $table.mutedJson, builder: (column) => column);

  GeneratedColumn<String> get encryptedPreviewsJson => $composableBuilder(
    column: $table.encryptedPreviewsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalCommunitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCommunitiesTable,
          LocalCommunity,
          $$LocalCommunitiesTableFilterComposer,
          $$LocalCommunitiesTableOrderingComposer,
          $$LocalCommunitiesTableAnnotationComposer,
          $$LocalCommunitiesTableCreateCompanionBuilder,
          $$LocalCommunitiesTableUpdateCompanionBuilder,
          (
            LocalCommunity,
            BaseReferences<
              _$AppDatabase,
              $LocalCommunitiesTable,
              LocalCommunity
            >,
          ),
          LocalCommunity,
          PrefetchHooks Function()
        > {
  $$LocalCommunitiesTableTableManager(
    _$AppDatabase db,
    $LocalCommunitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCommunitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCommunitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCommunitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> memberIdsJson = const Value.absent(),
                Value<String> adminIdsJson = const Value.absent(),
                Value<int> memberCount = const Value.absent(),
                Value<int> totalBalance = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> settingsJson = const Value.absent(),
                Value<String?> stokvelSettingsJson = const Value.absent(),
                Value<String?> lastMessageText = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String> unreadCountsJson = const Value.absent(),
                Value<String> mutedJson = const Value.absent(),
                Value<String> encryptedPreviewsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCommunitiesCompanion(
                id: id,
                type: type,
                name: name,
                description: description,
                avatarUrl: avatarUrl,
                ownerId: ownerId,
                memberIdsJson: memberIdsJson,
                adminIdsJson: adminIdsJson,
                memberCount: memberCount,
                totalBalance: totalBalance,
                status: status,
                settingsJson: settingsJson,
                stokvelSettingsJson: stokvelSettingsJson,
                lastMessageText: lastMessageText,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageType: lastMessageType,
                lastMessageAt: lastMessageAt,
                unreadCountsJson: unreadCountsJson,
                mutedJson: mutedJson,
                encryptedPreviewsJson: encryptedPreviewsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                required String ownerId,
                required String memberIdsJson,
                required String adminIdsJson,
                required int memberCount,
                Value<int> totalBalance = const Value.absent(),
                required String status,
                required String settingsJson,
                Value<String?> stokvelSettingsJson = const Value.absent(),
                Value<String?> lastMessageText = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<String> unreadCountsJson = const Value.absent(),
                Value<String> mutedJson = const Value.absent(),
                Value<String> encryptedPreviewsJson = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCommunitiesCompanion.insert(
                id: id,
                type: type,
                name: name,
                description: description,
                avatarUrl: avatarUrl,
                ownerId: ownerId,
                memberIdsJson: memberIdsJson,
                adminIdsJson: adminIdsJson,
                memberCount: memberCount,
                totalBalance: totalBalance,
                status: status,
                settingsJson: settingsJson,
                stokvelSettingsJson: stokvelSettingsJson,
                lastMessageText: lastMessageText,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageType: lastMessageType,
                lastMessageAt: lastMessageAt,
                unreadCountsJson: unreadCountsJson,
                mutedJson: mutedJson,
                encryptedPreviewsJson: encryptedPreviewsJson,
                createdAt: createdAt,
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

typedef $$LocalCommunitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCommunitiesTable,
      LocalCommunity,
      $$LocalCommunitiesTableFilterComposer,
      $$LocalCommunitiesTableOrderingComposer,
      $$LocalCommunitiesTableAnnotationComposer,
      $$LocalCommunitiesTableCreateCompanionBuilder,
      $$LocalCommunitiesTableUpdateCompanionBuilder,
      (
        LocalCommunity,
        BaseReferences<_$AppDatabase, $LocalCommunitiesTable, LocalCommunity>,
      ),
      LocalCommunity,
      PrefetchHooks Function()
    >;
typedef $$LocalCommunityMembersTableCreateCompanionBuilder =
    LocalCommunityMembersCompanion Function({
      required String id,
      required String communityId,
      required String userId,
      required String displayName,
      Value<String?> avatarUrl,
      required String role,
      required String status,
      Value<int> contributionBalance,
      Value<DateTime?> joinedAt,
      Value<String> invitedBy,
      Value<DateTime?> invitedAt,
      Value<DateTime?> lastReadAt,
      Value<String?> communityName,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LocalCommunityMembersTableUpdateCompanionBuilder =
    LocalCommunityMembersCompanion Function({
      Value<String> id,
      Value<String> communityId,
      Value<String> userId,
      Value<String> displayName,
      Value<String?> avatarUrl,
      Value<String> role,
      Value<String> status,
      Value<int> contributionBalance,
      Value<DateTime?> joinedAt,
      Value<String> invitedBy,
      Value<DateTime?> invitedAt,
      Value<DateTime?> lastReadAt,
      Value<String?> communityName,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocalCommunityMembersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCommunityMembersTable> {
  $$LocalCommunityMembersTableFilterComposer({
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

  ColumnFilters<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contributionBalance => $composableBuilder(
    column: $table.contributionBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invitedBy => $composableBuilder(
    column: $table.invitedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invitedAt => $composableBuilder(
    column: $table.invitedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get communityName => $composableBuilder(
    column: $table.communityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalCommunityMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCommunityMembersTable> {
  $$LocalCommunityMembersTableOrderingComposer({
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

  ColumnOrderings<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contributionBalance => $composableBuilder(
    column: $table.contributionBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invitedBy => $composableBuilder(
    column: $table.invitedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invitedAt => $composableBuilder(
    column: $table.invitedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get communityName => $composableBuilder(
    column: $table.communityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCommunityMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCommunityMembersTable> {
  $$LocalCommunityMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get communityId => $composableBuilder(
    column: $table.communityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get contributionBalance => $composableBuilder(
    column: $table.contributionBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<String> get invitedBy =>
      $composableBuilder(column: $table.invitedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get invitedAt =>
      $composableBuilder(column: $table.invitedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get communityName => $composableBuilder(
    column: $table.communityName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalCommunityMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCommunityMembersTable,
          LocalCommunityMember,
          $$LocalCommunityMembersTableFilterComposer,
          $$LocalCommunityMembersTableOrderingComposer,
          $$LocalCommunityMembersTableAnnotationComposer,
          $$LocalCommunityMembersTableCreateCompanionBuilder,
          $$LocalCommunityMembersTableUpdateCompanionBuilder,
          (
            LocalCommunityMember,
            BaseReferences<
              _$AppDatabase,
              $LocalCommunityMembersTable,
              LocalCommunityMember
            >,
          ),
          LocalCommunityMember,
          PrefetchHooks Function()
        > {
  $$LocalCommunityMembersTableTableManager(
    _$AppDatabase db,
    $LocalCommunityMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCommunityMembersTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalCommunityMembersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalCommunityMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> communityId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> contributionBalance = const Value.absent(),
                Value<DateTime?> joinedAt = const Value.absent(),
                Value<String> invitedBy = const Value.absent(),
                Value<DateTime?> invitedAt = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<String?> communityName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCommunityMembersCompanion(
                id: id,
                communityId: communityId,
                userId: userId,
                displayName: displayName,
                avatarUrl: avatarUrl,
                role: role,
                status: status,
                contributionBalance: contributionBalance,
                joinedAt: joinedAt,
                invitedBy: invitedBy,
                invitedAt: invitedAt,
                lastReadAt: lastReadAt,
                communityName: communityName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String communityId,
                required String userId,
                required String displayName,
                Value<String?> avatarUrl = const Value.absent(),
                required String role,
                required String status,
                Value<int> contributionBalance = const Value.absent(),
                Value<DateTime?> joinedAt = const Value.absent(),
                Value<String> invitedBy = const Value.absent(),
                Value<DateTime?> invitedAt = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<String?> communityName = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalCommunityMembersCompanion.insert(
                id: id,
                communityId: communityId,
                userId: userId,
                displayName: displayName,
                avatarUrl: avatarUrl,
                role: role,
                status: status,
                contributionBalance: contributionBalance,
                joinedAt: joinedAt,
                invitedBy: invitedBy,
                invitedAt: invitedAt,
                lastReadAt: lastReadAt,
                communityName: communityName,
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

typedef $$LocalCommunityMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCommunityMembersTable,
      LocalCommunityMember,
      $$LocalCommunityMembersTableFilterComposer,
      $$LocalCommunityMembersTableOrderingComposer,
      $$LocalCommunityMembersTableAnnotationComposer,
      $$LocalCommunityMembersTableCreateCompanionBuilder,
      $$LocalCommunityMembersTableUpdateCompanionBuilder,
      (
        LocalCommunityMember,
        BaseReferences<
          _$AppDatabase,
          $LocalCommunityMembersTable,
          LocalCommunityMember
        >,
      ),
      LocalCommunityMember,
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
  $$LocalFullMessagesTableTableManager get localFullMessages =>
      $$LocalFullMessagesTableTableManager(_db, _db.localFullMessages);
  $$LocalFullConversationsTableTableManager get localFullConversations =>
      $$LocalFullConversationsTableTableManager(
        _db,
        _db.localFullConversations,
      );
  $$LocalPendingMessagesTableTableManager get localPendingMessages =>
      $$LocalPendingMessagesTableTableManager(_db, _db.localPendingMessages);
  $$LocalCommunitiesTableTableManager get localCommunities =>
      $$LocalCommunitiesTableTableManager(_db, _db.localCommunities);
  $$LocalCommunityMembersTableTableManager get localCommunityMembers =>
      $$LocalCommunityMembersTableTableManager(_db, _db.localCommunityMembers);
}
