import 'package:lazy_sync/main/sync_client.dart';
import 'package:sqflite/sqflite.dart';

class AppConfig {
  final Database database;
  final SyncClient syncClient;
  AppConfig({required this.syncClient, required this.database});
}
