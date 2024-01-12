import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequest extends StatefulWidget {
  final Widget child;

  PermissionRequest({required this.child});

  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

class _PermissionRequestState extends State<PermissionRequest> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() async {
    // Request location permission
    print("Requesting location permission");
    await Permission.location.request();

    // Add more permissions to request here
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
