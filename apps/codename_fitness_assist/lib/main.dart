import 'package:flutter/material.dart';
import 'package:core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Initializing:...");
  final config = await MyAppCore.getConfig(
    dbName: "database.db",
    clearDatabase: true,
  );
  debugPrint("Initialized");
  runApp(MyAppCore(config: config));
}
