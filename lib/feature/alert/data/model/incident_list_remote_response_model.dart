class IncidentListRemoteResponseModel {
  IncidentListRemoteResponseModel({
    this.success,
    this.data,
    this.message,
  });

  IncidentListRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  bool? success;
  List<Data>? data;
  String? message;

  IncidentListRemoteResponseModel copyWith({
    bool? success,
    List<Data>? data,
    String? message,
  }) =>
      IncidentListRemoteResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.categoryId,
    this.titleEn,
    this.titleBn,
    this.tags,
    this.description,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    titleEn = json['title_en'];
    titleBn = json['title_bn'];
    tags = json['tags'];
    description = json['description'];
  }

  int? id;
  int? categoryId;
  String? titleEn;
  String? titleBn;
  String? tags;
  String? description;

  Data copyWith({
    int? id,
    int? categoryId,
    String? titleEn,
    String? titleBn,
    String? tags,
    String? description,
  }) =>
      Data(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        titleEn: titleEn ?? this.titleEn,
        titleBn: titleBn ?? this.titleBn,
        tags: tags ?? this.tags,
        description: description ?? this.description,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['title_en'] = titleEn;
    map['title_bn'] = titleBn;
    map['tags'] = tags;
    map['description'] = description;
    return map;
  }
}
