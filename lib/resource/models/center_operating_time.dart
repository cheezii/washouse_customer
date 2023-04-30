import 'package:washouse_customer/resource/models/center.dart';

class CenterOperatingTime {
  List<int>? monthOff;
  List<CenterOperatingHours>? operatingTimes;

  CenterOperatingTime({this.monthOff, this.operatingTimes});

  CenterOperatingTime.fromJson(Map<String, dynamic> json) {
    print(json['monthOff']);
    if (json['monthOff'] != null) {
      monthOff = json['monthOff'].cast<int>();
    }
    if (json['operatingTimes'] != null) {
      operatingTimes = <CenterOperatingHours>[];
      json['operatingTimes'].forEach((v) {
        operatingTimes!.add(new CenterOperatingHours.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['monthOff'] = this.monthOff;
  //   if (this.operatingTimes != null) {
  //     data['operatingTimes'] =
  //         this.operatingTimes!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
