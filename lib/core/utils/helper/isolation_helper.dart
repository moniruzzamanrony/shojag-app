//this file is used to register the isolate
import 'dart:isolate';
import 'dart:ui';

const String backgroundLocationIsolateName = "BackgroundLocationIsolate";

ReceivePort locationIsolatePort = ReceivePort();

@pragma('vm:entry-point')
void registerLocationIsolate() {
  IsolateNameServer.registerPortWithName(
      locationIsolatePort.sendPort, backgroundLocationIsolateName);
  locationIsolatePort.listen((data) {
    //print('location isolate data $data');
  });
}

@pragma('vm:entry-point')
void locationIsolateCallback(dynamic data) {
  final sendPort =
      IsolateNameServer.lookupPortByName(backgroundLocationIsolateName);
  sendPort?.send(data);
}

void disposeLocationIsolate() {
  IsolateNameServer.removePortNameMapping(backgroundLocationIsolateName);
  locationIsolatePort.close();
}