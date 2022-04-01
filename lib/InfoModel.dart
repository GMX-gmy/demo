import 'package:json_annotation/json_annotation.dart';
part 'InfoModel.g.dart';

List<InfoModel> getInfoModelList(List<dynamic> list) {
  List<InfoModel> result = [];
  list.forEach((element) {
    InfoModel model = transJsonToModel(element);
    result.add(model);
  });
  return result;
}

InfoModel transJsonToModel(dynamic dict) {
  InfoModel model = InfoModel.fromJson(dict);
  return model;
}

@JsonSerializable()
class InfoModel extends Object{
  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'intro')
  String intro;

  InfoModel(this.image, this.id, this.intro);
  factory InfoModel.fromJson(Map<String, dynamic> srcJson) => _$InfoModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}