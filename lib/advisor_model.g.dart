// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvisorModel _$AdvisorModelFromJson(Map<String, dynamic> json) => AdvisorModel(
      json['advisor_id'] as String?,
      json['advisor_name'] as String?,
      json['advisor_avatar'] as String?,
      json['advisor_desc'] as String?,
      (json['services'] as List<dynamic>?)
          ?.map((e) => ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvisorModelToJson(AdvisorModel instance) =>
    <String, dynamic>{
      'advisor_id': instance.advisorId,
      'advisor_name': instance.advisorName,
      'advisor_avatar': instance.advisorAvatar,
      'advisor_desc': instance.advisorDesc,
      'services': instance.services,
    };
