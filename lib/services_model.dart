
import 'package:demo/JsonUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'services_model.g.dart';

List<ServicesModel> getServicesModelList(List<dynamic> list){
  List<ServicesModel> result = [];
  list.forEach((item){
    result.add(ServicesModel.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class ServicesModel{

  @JsonKey(name: 'service_name')
  String? serviceName;

  @JsonKey(name: 'service_desc')
  String? serviceDesc;

  @JsonKey(name: 'service_price')
  int? servicePrice;

  ServicesModel(this.serviceName, this.serviceDesc, this.servicePrice );

  factory ServicesModel.fromJson(Map<String, dynamic> srcJson) => _$ServicesModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);
}
