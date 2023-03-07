// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:washouse_customer/models/district.dart';

class Ward {
  String wardId;
  String wardName;
  String districtId;
  Ward({
    required this.wardId,
    required this.wardName,
    required this.districtId,
  });

  // Ward.fromJson(Map<String, dynamic> json)
  //     : districtId = json['district_id'],
  //       wardId = json['ward_id'],
  //       wardName = json['ward_name'];

  // Map<String, dynamic> toJson() =>
  //     {'district_id': districtId, 'ward_id': wardId, 'ward_name': wardName};
}
