import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RequestPermissionController{
  final Permission _locationPermision;
  RequestPermissionController(this._locationPermision);

  final _streamController = StreamController<PermissionStatus>.broadcast();

  Stream<PermissionStatus> get onStatusChanged => _streamController.stream;

  request() async {
    final status = await _locationPermision.request();
    _notify(status);
    
  }

  void _notify(PermissionStatus status){
    if(_streamController.isClosed && _streamController.hasListener){
      _streamController.sink.add(status);
    }
  }

  void dispose(){
    _streamController.close();
  }





}