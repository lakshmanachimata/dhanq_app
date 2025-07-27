import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> getMicrophonePermission(BuildContext context) async {
    try {
      // Check current permission status
      PermissionStatus status = await Permission.microphone.status;

      debugPrint('Initial microphone permission status: $status');

      // If already granted, return true
      if (status.isGranted) {
        debugPrint('Microphone permission already granted');
        return true;
      }

      // If permanently denied, show settings dialog
      if (status.isPermanentlyDenied) {
        debugPrint('Microphone permission permanently denied');
        if (context.mounted) {
          await _showPermissionSettingsDialog(context);
        }
        return false;
      }

      // For iOS, handle permission request more carefully
      if (Platform.isIOS) {
        debugPrint('Requesting microphone permission on iOS');

        // Request permission
        status = await Permission.microphone.request();
        debugPrint('iOS microphone permission result: $status');

        // Check the result
        if (status.isGranted) {
          debugPrint('iOS microphone permission granted');
          return true;
        } else if (status.isPermanentlyDenied) {
          debugPrint('iOS microphone permission denied');
          // Try one more time for iOS
          await Future.delayed(const Duration(milliseconds: 500));
          status = await Permission.microphone.request();
          debugPrint('iOS microphone permission retry result: $status');

          if (status.isGranted) {
            return true;
          } else {
            if (context.mounted) {
              await _showPermissionSettingsDialog(context);
            }
            return false;
          }
          return false;
        } else if (status.isDenied) {
          debugPrint('iOS microphone permission denied');
          // Try one more time for iOS
          await Future.delayed(const Duration(milliseconds: 500));
          status = await Permission.microphone.request();
          debugPrint('iOS microphone permission retry result: $status');

          if (status.isGranted) {
            return true;
          } else {
            if (context.mounted) {
              await _showPermissionSettingsDialog(context);
            }
            return false;
          }
        } else if (status.isPermanentlyDenied) {
          debugPrint('iOS microphone permission denied');
          // Try one more time for iOS
          await Future.delayed(const Duration(milliseconds: 500));
          status = await Permission.microphone.request();
          debugPrint('iOS microphone permission retry result: $status');

          if (status.isGranted) {
            return true;
          } else {
            if (context.mounted) {
              await _showPermissionSettingsDialog(context);
            }
            return false;
          }
        }
      } else {
        // For Android, use the standard approach
        debugPrint('Requesting microphone permission on Android');
        status = await Permission.microphone.request();
        debugPrint('Android microphone permission result: $status');

        if (!status.isGranted) {
          if (context.mounted) {
            await _showPermissionSettingsDialog(context);
          }
          return false;
        }
      }

      return status.isGranted;
    } catch (e) {
      debugPrint('Error requesting microphone permission: $e');
      if (context.mounted) {
        await _showPermissionSettingsDialog(context);
      }
      return false;
    }
  }

  static Future<void> _showPermissionSettingsDialog(
    BuildContext context,
  ) async {
    return showDialog(
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

  /// Check if microphone permission is available without requesting
  static Future<bool> isMicrophonePermissionGranted() async {
    try {
      PermissionStatus status = await Permission.microphone.status;
      return status.isGranted;
    } catch (e) {
      debugPrint('Error checking microphone permission: $e');
      return false;
    }
  }

  /// Reset microphone permission (useful for testing)
  static Future<void> resetMicrophonePermission() async {
    try {
      await Permission.microphone.request();
      debugPrint('Microphone permission reset requested');
    } catch (e) {
      debugPrint('Error resetting microphone permission: $e');
    }
  }
}
