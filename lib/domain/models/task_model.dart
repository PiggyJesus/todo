// ignore_for_file: invalid_annotation_target

import 'package:todo/domain/models/importance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@Freezed()
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @JsonKey(name: 'id') required String uuid,
    @JsonKey(name: 'text') required String name,
    @IpmortanceConverter() required Importance importance,
    @JsonKey(name: 'created_at')
    @EpochDateTimeConverter()
    required DateTime createdAt,
    @JsonKey(name: 'changed_at')
    @EpochDateTimeConverter()
    required DateTime changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
    @EpochDateTimeNullableConverter() DateTime? deadline,
    @Default(false) bool done,
    String? color,
    // ignore: deprecated_member_use
    @Default(false) @JsonKey(ignore: true) bool deleted,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

class EpochDateTimeNullableConverter implements JsonConverter<DateTime?, int?> {
  const EpochDateTimeNullableConverter();

  @override
  DateTime? fromJson(int? json) =>
      json == null ? null : DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}

class IpmortanceConverter implements JsonConverter<Importance, String> {
  const IpmortanceConverter();

  @override
  Importance fromJson(String json) {
    switch (json) {
      case 'low':
        return Importance.low;
      case 'important':
        return Importance.high;
      default:
        return Importance.common;
    }
  }

  @override
  String toJson(Importance object) {
    switch (object) {
      case Importance.low:
        return 'low';
      case Importance.high:
        return 'important';
      default:
        return 'basic';
    }
  }
}
