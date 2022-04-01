import 'package:demo/settingpage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'advisor_model.dart';
part 'orderModel.g.dart';

List<orderModel> getorderModelList(List<dynamic> list){
  List<orderModel> result = [];
  list.forEach((item){
    result.add(orderModel.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class orderModel extends Object {

  @JsonKey(name: 'order_id')
  String orderId;

  @JsonKey(name: 'advisor_id')
  String advisorId;

  @JsonKey(name: 'situation')
  String situation;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'question')
  String question;

  @JsonKey(name: 'price')
  int price;

  @JsonKey(name: 'advisor')
  AdvisorModel advisor;

  orderModel(this.orderId,this.advisorId,this.situation,this.type,this.question,this.price,this.advisor);

  factory orderModel.fromJson(Map<String, dynamic> srcJson) => _$orderModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$orderModelToJson(this);
}



