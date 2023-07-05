// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      uuid: json['id'] as String,
      name: json['text'] as String,
      importance:
          const IpmortanceConverter().fromJson(json['importance'] as String),
      createdAt:
          const EpochDateTimeConverter().fromJson(json['created_at'] as int),
      changedAt:
          const EpochDateTimeConverter().fromJson(json['changed_at'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
      deadline: const EpochDateTimeNullableConverter()
          .fromJson(json['deadline'] as int?),
      done: json['done'] as bool? ?? true,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.uuid,
      'text': instance.name,
      'importance': const IpmortanceConverter().toJson(instance.importance),
      'created_at': const EpochDateTimeConverter().toJson(instance.createdAt),
      'changed_at': const EpochDateTimeConverter().toJson(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
      'deadline':
          const EpochDateTimeNullableConverter().toJson(instance.deadline),
      'done': instance.done,
      'color': instance.color,
    };
