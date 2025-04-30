class CityResponseModel {
  final bool status;
  final String msg;
  final List<CityListModel> data;

  CityResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CityResponseModel.fromJson(Map<String, dynamic> json) {
    return CityResponseModel(
      status: json['status'],
      msg: json['msg'],
      data: List<CityListModel>.from(json['data'].map((item) => CityListModel.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class CityListModel {
  final int id;
  final String? name;

  CityListModel({
    required this.id,
    this.name,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) {
    return CityListModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
