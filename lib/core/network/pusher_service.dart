/*
import 'dart:developer';

import 'package:app/core/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  PusherService._();

  static final PusherChannelsFlutter _pusher =
      PusherChannelsFlutter.getInstance();

  static final _instance = PusherService._();

  static PusherService get instance => _instance;

  Future<PusherChannel?> subscribe(String channelName,
      {ValueChanged? onEvent}) async {
    if (_pusher.channels.containsKey(channelName)) {
      print('channel found');
      return _pusher.getChannel(channelName);
    } else {
      print('channel not found');
    }

    try {
      log('subscribing to $channelName');
      return await _pusher.subscribe(
          channelName: channelName,
          // onEvent: (e) {
          //   if (e is PusherEvent) {
          //     //log('$channelName :  on ${e.userId} ${e.eventName}  sdf event ${e.runtimeType} ${e.data} ${e.data}');
          //     print('on channerl event ${e.data}');
          //   }
          // },
          onEvent: onEvent,
          onSubscriptionSucceeded: (e) {
            print('sub started $channelName $e');
            //onSubscriptionSucceeded(e);
            print('sub emd');
          },
          onSubscriptionError: (e) {
            print('$channelName : onSubscriptionError ${e.data}');
          },
          onSubscriptionCount: (e) {
            print('$channelName : onSubscriptionCount ${e.data}');
          },
          onMemberAdded: (e) {
            print('$channelName : onMemberAdded ${e.data}');
          },
          onMemberRemoved: (e) {
            print('$channelName : onMemberRemoved ${e.data}');
          });
    } catch (e) {
      log('error pusher $e');
    }
    return null;
  }

  Future<void> unsubscribe(String channelName) async {
    if (!_pusher.channels.containsKey(channelName)) return;
    return await _pusher.unsubscribe(channelName: channelName);
  }

  // Future<void> trigger(
  //     {required String channelName,
  //     required String eventName,
  //     dynamic data}) async {
  //   return await _pusher.trigger(PusherEvent(
  //       channelName: channelName, eventName: eventName, data: data));
  // }

  Future<void> connect() async {
    return await _pusher.connect();
  }

  Future<void> disconnect() async {
    return await _pusher.disconnect();
  }

  Future<void> initialize() async {
    try {
      await _pusher.init(
        apiKey: AppConstants.pusherAPIKey,
        cluster: AppConstants.pusherClusterKey,
        // onEvent: onEvent,
        // onError: onError,
        // onConnectionStateChange: onConnectionStateChange,
        // onSubscriptionSucceeded: onSubscriptionSucceeded,
        // onSubscriptionError: onSubscriptionError,
        // onSubscriptionCount: onSubscriptionCount,
        // onMemberAdded: onMemberAdded,
        // onMemberRemoved: onMemberRemoved,
      );
    } catch (e) {
      print(e);
    }
  }

  onEvent(PusherEvent event) {
    print('on event');
  }

  onError(String message, int? code, dynamic error) {
    print(error);
  }

  onConnectionStateChange(String oldState, String newState) {
    print(oldState);
    print(newState);
  }

  onSubscriptionSucceeded(String channelName, dynamic data) {
    print('Subscribed to $channelName');
    print('Subscribed data $data');
  }

  onSubscriptionError(String channelName, dynamic error) {
    print('subscription $channelName error: $error');
  }

  onSubscriptionCount(String channelName, int count) {
    print('Subscription count for $channelName: $count');
  }

  onMemberAdded(String channelName, PusherMember member) {
    print('Member added: ${member.userInfo}');
  }

  onMemberRemoved(String channelName, PusherMember member) {
    print('Member removed: ${member.userInfo}');
  }
}
*/
