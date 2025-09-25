class SendRequestRemotePostModel {
  final int senderId;
  final int receiverId;

  const SendRequestRemotePostModel({
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
    };
  }

  factory SendRequestRemotePostModel.fromMap(Map<String, dynamic> map) {
    return SendRequestRemotePostModel(
      senderId: map['sender_id'] as int,
      receiverId: map['receiver_id'] as int,
    );
  }
}
