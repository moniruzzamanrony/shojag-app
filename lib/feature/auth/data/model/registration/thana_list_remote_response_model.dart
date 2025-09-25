class ThanaListRemoteResponseModel {
  ThanaListRemoteResponseModel({
    this.success,
    this.message,
    this.thana,
  });

  ThanaListRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['thana'] != null) {
      thana = [];
      json['thana'].forEach((v) {
        thana?.add(Thana.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<Thana>? thana;

  ThanaListRemoteResponseModel copyWith({
    bool? success,
    String? message,
    List<Thana>? thana,
  }) =>
      ThanaListRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        thana: thana ?? this.thana,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (thana != null) {
      map['thana'] = thana?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Thana {
  Thana({
    this.id,
    this.name,
  });

  Thana.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num? id;
  String? name;

  Thana copyWith({
    num? id,
    String? name,
  }) =>
      Thana(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
