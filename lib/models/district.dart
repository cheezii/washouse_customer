// ignore_for_file: public_member_api_docs, sort_constructors_first

class District {
  final String districtId;
  final String districtName;
  District(
    this.districtId,
    this.districtName,
  );

  // District.fromJson(Map<String, dynamic> json)
  //     : districtId = json['district_id'],
  //       districtName = json['district_name'];

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['district_id'] = this.districtId;
  //   data['district_name'] = this.districtName;
  //   return data;
  // }
}
