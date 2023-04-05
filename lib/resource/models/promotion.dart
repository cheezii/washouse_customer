// ignore_for_file: public_member_api_docs, sort_constructors_first
class PromotionModel {
  int id;
  String code;
  String expiredDate;
  String description;
  PromotionModel({
    required this.id,
    required this.code,
    required this.expiredDate,
    required this.description,
  });
}

List<PromotionModel> demoPromotionList = [
  PromotionModel(
    id: 1,
    code: 'TEST_DRCLEAN_FAIL',
    expiredDate: '2023-06-30',
    description: 'Sử dụng trong tháng 6',
  ),
  PromotionModel(
    id: 1,
    code: 'TEST_DRCLEAN_OK',
    expiredDate: '2023-04-25',
    description: 'Sử dụng đến hết ngày 20/4/2023',
  ),
  PromotionModel(
    id: 1,
    code: 'TEST_DRCLEAN_FAIL',
    expiredDate: '2023-04-02',
    description: 'Sử dụng cho khách hàng',
  )
];
