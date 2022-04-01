// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

orderModel _$orderModelFromJson(Map<String, dynamic> json) => orderModel(
      json['order_id'] as String,
      json['advisor_id'] as String,
      json['situation'] as String,
      json['type'] as String,
      json['question'] as String,
      json['price'] as int,
      AdvisorModel.fromJson(json['advisor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$orderModelToJson(orderModel instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'advisor_id': instance.advisorId,
      'situation': instance.situation,
      'type': instance.type,
      'question': instance.question,
      'price': instance.price,
      'advisor': instance.advisor,
    };
