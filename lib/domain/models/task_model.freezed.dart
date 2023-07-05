// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, duplicate_ignore
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  @JsonKey(name: 'id')
  String get uuid => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String get name => throw _privateConstructorUsedError;
  @IpmortanceConverter()
  Importance get importance => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  @EpochDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  @EpochDateTimeConverter()
  DateTime get changedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;
  @EpochDateTimeNullableConverter()
  DateTime? get deadline => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  String? get color =>
      throw _privateConstructorUsedError; // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  bool get deleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String uuid,
      @JsonKey(name: 'text') String name,
      @IpmortanceConverter() Importance importance,
      @JsonKey(name: 'created_at') @EpochDateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'changed_at') @EpochDateTimeConverter() DateTime changedAt,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @EpochDateTimeNullableConverter() DateTime? deadline,
      bool done,
      String? color,
      @JsonKey(ignore: true) bool deleted});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? importance = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? deleted = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$$_TaskModelCopyWith(
          _$_TaskModel value, $Res Function(_$_TaskModel) then) =
      __$$_TaskModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String uuid,
      @JsonKey(name: 'text') String name,
      @IpmortanceConverter() Importance importance,
      @JsonKey(name: 'created_at') @EpochDateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'changed_at') @EpochDateTimeConverter() DateTime changedAt,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @EpochDateTimeNullableConverter() DateTime? deadline,
      bool done,
      String? color,
      @JsonKey(ignore: true) bool deleted});
}

/// @nodoc
class __$$_TaskModelCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$_TaskModel>
    implements _$$_TaskModelCopyWith<$Res> {
  __$$_TaskModelCopyWithImpl(
      _$_TaskModel _value, $Res Function(_$_TaskModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? importance = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? lastUpdatedBy = null,
    Object? deadline = freezed,
    Object? done = null,
    Object? color = freezed,
    Object? deleted = null,
  }) {
    return _then(_$_TaskModel(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskModel implements _TaskModel {
  const _$_TaskModel(
      {@JsonKey(name: 'id')
          required this.uuid,
      @JsonKey(name: 'text')
          required this.name,
      @IpmortanceConverter()
          required this.importance,
      @JsonKey(name: 'created_at')
      @EpochDateTimeConverter()
          required this.createdAt,
      @JsonKey(name: 'changed_at')
      @EpochDateTimeConverter()
          required this.changedAt,
      @JsonKey(name: 'last_updated_by')
          required this.lastUpdatedBy,
      @EpochDateTimeNullableConverter()
          this.deadline,
      this.done = true,
      this.color,
      @JsonKey(ignore: true)
          this.deleted = false});

  factory _$_TaskModel.fromJson(Map<String, dynamic> json) =>
      _$$_TaskModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String uuid;
  @override
  @JsonKey(name: 'text')
  final String name;
  @override
  @IpmortanceConverter()
  final Importance importance;
  @override
  @JsonKey(name: 'created_at')
  @EpochDateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey(name: 'changed_at')
  @EpochDateTimeConverter()
  final DateTime changedAt;
  @override
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;
  @override
  @EpochDateTimeNullableConverter()
  final DateTime? deadline;
  @override
  @JsonKey()
  final bool done;
  @override
  final String? color;
// ignore: deprecated_member_use
  @override
  @JsonKey(ignore: true)
  final bool deleted;

  @override
  String toString() {
    return 'TaskModel(uuid: $uuid, name: $name, importance: $importance, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy, deadline: $deadline, done: $done, color: $color, deleted: $deleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskModel &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.deleted, deleted) || other.deleted == deleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, importance,
      createdAt, changedAt, lastUpdatedBy, deadline, done, color, deleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      __$$_TaskModelCopyWithImpl<_$_TaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskModelToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel(
      {@JsonKey(name: 'id')
          required final String uuid,
      @JsonKey(name: 'text')
          required final String name,
      @IpmortanceConverter()
          required final Importance importance,
      @JsonKey(name: 'created_at')
      @EpochDateTimeConverter()
          required final DateTime createdAt,
      @JsonKey(name: 'changed_at')
      @EpochDateTimeConverter()
          required final DateTime changedAt,
      @JsonKey(name: 'last_updated_by')
          required final String lastUpdatedBy,
      @EpochDateTimeNullableConverter()
          final DateTime? deadline,
      final bool done,
      final String? color,
      @JsonKey(ignore: true)
          final bool deleted}) = _$_TaskModel;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$_TaskModel.fromJson;

  @override
  @JsonKey(name: 'id')
  String get uuid;
  @override
  @JsonKey(name: 'text')
  String get name;
  @override
  @IpmortanceConverter()
  Importance get importance;
  @override
  @JsonKey(name: 'created_at')
  @EpochDateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(name: 'changed_at')
  @EpochDateTimeConverter()
  DateTime get changedAt;
  @override
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy;
  @override
  @EpochDateTimeNullableConverter()
  DateTime? get deadline;
  @override
  bool get done;
  @override
  String? get color;
  @override // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  bool get deleted;
  @override
  @JsonKey(ignore: true)
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}
