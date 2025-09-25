/*
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(int userId) {
    print('connecting to socket.IO server');
    try {
      socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true
      });
    } catch (e) {
      print('socket exception $e');
    } finally {
      print('socket connection : ${socket.connected}');
    }

    socket.onConnect((_) {
      print('connected to socket.IO server');
      registerUser(userId);
    });

    socket.onDisconnect((_) {
      print('disconnected from socket.IO server');
    });

    socket.on('locationUpdate', (data) {
      // handle the incomeing locaiton update data
      print('received location update');
      print(data);
    });
  }

  void sendLocationUpdate(
      double latitude, double longitude, int recipentId, int userId) {
    final locationData = {
      'recipientId': recipentId,
      'location': {
        'id': userId,
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }
    };
    socket.emit('locationUpdate', locationData);
  }

  void registerUser(int userId) {
    socket.emit('register', userId); // Emit register event with user ID
  }

  bool isConnected() {
    return socket.connected;
  }

  void disconnect() {
    socket.disconnect();
  }
}
*/
