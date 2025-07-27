import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class PermissionHelper {
  static Future<bool> getMicrophonePermission(BuildContext context) async {
    // Check current permission status
    PermissionStatus status = await Permission.microphone.status;

    if (status.isGranted) {
      return true;
    }

    // For iOS, we need to handle permission differently
    if (Platform.isIOS) {
      // Request permission
      status = await Permission.microphone.request();
      
      if (status.isDenied || status.isPermanentlyDenied) {
        // Show dialog if permission denied
        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Microphone Permission Required'),
                content: const Text(
                  'This app needs microphone access for voice input and speech-to-text functionality. Please grant microphone permission in settings to continue.',
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Open Settings'),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        return false;
      }
    } else {
      // For Android, use the standard approach
      status = await Permission.microphone.request();

      if (!status.isGranted) {
        // Show dialog if permission denied
        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Microphone Permission Required'),
                content: const Text(
                  'This feature needs microphone access to work. Please grant microphone permission in settings to continue.',
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Open Settings'),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        return false;
      }
    }

    return true;
  }
}
