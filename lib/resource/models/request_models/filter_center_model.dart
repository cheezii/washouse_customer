class FilterCenterRequest {
  int? page;
  int? pageSize;
  String? sort;
  String? budgetRange;
  String? categoryServices;
  String? additions;
  String? searchString;
  bool? hasDelivery;
  bool? hasOnlinePayment;
  double? currentUserLatitude;
  double? currentUserLongitude;

  FilterCenterRequest(
      {this.page,
      this.pageSize,
      this.sort,
      this.budgetRange,
      this.categoryServices,
      this.additions,
      this.searchString,
      this.hasDelivery,
      this.hasOnlinePayment,
      this.currentUserLatitude,
      this.currentUserLongitude});

  FilterCenterRequest.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    sort = json['sort'];
    budgetRange = json['budgetRange'];
    categoryServices = json['categoryServices'];
    additions = json['Additions'];
    searchString = json['searchString'];
    hasDelivery = json['hasDelivery'];
    hasOnlinePayment = json['hasOnlinePayment'];
    currentUserLatitude = json['currentUserLatitude'];
    currentUserLongitude = json['currentUserLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['sort'] = this.sort;
    data['budgetRange'] = this.budgetRange;
    data['categoryServices'] = this.categoryServices;
    data['Additions'] = this.additions;
    data['searchString'] = this.searchString;
    data['hasDelivery'] = this.hasDelivery;
    data['hasOnlinePayment'] = this.hasOnlinePayment;
    data['currentUserLatitude'] = this.currentUserLatitude;
    data['currentUserLongitude'] = this.currentUserLongitude;
    return data;
  }
}
