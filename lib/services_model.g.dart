// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    ServicesModel(
      json['service_name'] as String?,
      json['service_desc'] as String?,
      json['service_price'] as int?,
    );

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'service_desc': instance.serviceDesc,
      'service_price': instance.servicePrice,
    };
