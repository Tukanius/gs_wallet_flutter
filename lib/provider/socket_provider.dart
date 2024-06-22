import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  IO.Socket? socket;
  String url = 'https://dev-gs.zto.mn';
  bool isConnected = false;

  initSocket(String myToken) {
    socket = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']).setQuery({
        'token': myToken,
      }).build(),
    );
    socket!.on('connect', (_) {
      isConnected = false;
      print('Socket Connected');
      notifyListeners();
    });
    socket!.on('disconnect', (_) {
      isConnected = false;
      print('Socket Disconnected');
      notifyListeners();
    });
  }

  sendStep(num amount, num latitude, num longitude) async {
    print('===Check socket===');
    print(socket!.connected);
    print(isConnected);
    print('===Check socket===');
    if (socket!.connected) {
      socket!.emit('action', {
        'type': 'walk',
        'payload': {
          'amount': amount,
          'latitude': latitude,
          'longitude': longitude,
        }
      });
      print('===SOCKET SENT===');
    } else {
      print('Socket not connected');
    }
  }
}
