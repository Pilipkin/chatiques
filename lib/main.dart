import 'dart:async';

import 'package:chatiques/app.dart';
import 'package:chatiques/common/services/locator.dart';
import 'package:chatiques/common/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await setupLocator();
    final storageService = locator<StorageService>();
    await storageService.init();
    runApp(const ChatiquesApp());
  }, (error, stackTrace) {
    // print(error);
  });
}
