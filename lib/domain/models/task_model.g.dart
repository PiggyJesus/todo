// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      uuid: json['id'] as String,
      name: json['name'] as String,
      importance: $enumDecode(_$ImportanceEnumMap, json['importance']),
      createdAt: DateTime.parse(json['created_at'] as String),
      changedAt: DateTime.parse(json['changed_at'] as String),
      lastUpdatedBy: json['last_updated_by'] as String,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      done: json['done'] as bool? ?? true,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'name': instance.name,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'created_at': instance.createdAt.toIso8601String(),
      'changed_at': instance.changedAt.toIso8601String(),
      'last_updated_by': instance.lastUpdatedBy,
      'deadline': instance.deadline?.toIso8601String(),
      'done': instance.done,
      'color': instance.color,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.common: 'common',
  Importance.high: 'high',
};
