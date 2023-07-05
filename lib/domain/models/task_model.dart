// ignore_for_file: invalid_annotation_target

import 'package:todo/domain/models/importance.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@Freezed()
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @JsonKey(name: 'id') required String uuid,
    required String name,
    required Importance importance,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'changed_at') required DateTime changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
    DateTime? deadline,
    @Default(true) bool done,
    String? color,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
