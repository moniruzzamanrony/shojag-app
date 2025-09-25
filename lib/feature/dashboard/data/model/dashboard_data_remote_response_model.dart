import 'package:app/feature/alert/data/model/list/alert_list_remote_response_model.dart';

class DashboardDataRemoteResponseModel {
  DashboardDataRemoteResponseModel({
    this.success,
    this.message,
    this.activeList,
    this.closeList,
    this.respondedList,
    this.myList,
  });

  DashboardDataRemoteResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['active_list'] != null) {
      activeList = [];
      json['active_list'].forEach((v) {
        activeList?.add(Data.fromJson(v));
      });
    }
    if (json['close_list'] != null) {
      closeList = [];
      json['close_list'].forEach((v) {
        closeList?.add(Data.fromJson(v));
      });
    }
    if (json['responded_list'] != null) {
      respondedList = [];
      json['responded_list'].forEach((v) {
        respondedList?.add(Data.fromJson(v));
      });
    }
    if (json['my_list'] != null) {
      myList = [];
      json['my_list'].forEach((v) {
        myList?.add(Data.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<Data>? activeList;
  List<Data>? closeList;
  List<Data>? respondedList;
  List<Data>? myList;

  DashboardDataRemoteResponseModel copyWith({
    bool? success,
    String? message,
    List<Data>? activeList,
    List<Data>? closeList,
    List<Data>? respondedList,
    List<Data>? myList,
  }) =>
      DashboardDataRemoteResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        activeList: activeList ?? this.activeList,
        closeList: closeList ?? this.closeList,
        respondedList: respondedList ?? this.respondedList,
        myList: myList ?? this.myList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (activeList != null) {
      map['active_list'] = activeList?.map((v) => v.toJson()).toList();
    }
    if (closeList != null) {
      map['close_list'] = closeList?.map((v) => v.toJson()).toList();
    }
    if (respondedList != null) {
      map['responded_list'] = respondedList?.map((v) => v.toJson()).toList();
    }
    if (myList != null) {
      map['my_list'] = myList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
