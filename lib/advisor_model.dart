import 'package:demo/services_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'advisor_model.g.dart';

List<AdvisorModel> getAdvisorModelList(List<dynamic> list){
  List<AdvisorModel> result = [];
  list.forEach((item) {
    result.add(AdvisorModel.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class AdvisorModel{

  @JsonKey(name: 'advisor_id')
  String? advisorId;

  @JsonKey(name: 'advisor_name')
  String? advisorName;

  @JsonKey(name: 'advisor_avatar')
  String? advisorAvatar;

  @JsonKey(name: 'advisor_desc')
  String? advisorDesc;

  @JsonKey(name: 'services')
  List<ServicesModel>? services;

  AdvisorModel(this.advisorId, this.advisorName, this.advisorAvatar, this.advisorDesc, this.services);

  factory AdvisorModel.fromJson(Map<String, dynamic> srcJson) => _$AdvisorModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$AdvisorModelToJson(this);

}