abstract class SyncModel {
  DateTime get timestamp;
}

abstract class SyncModelWithQualifier extends SyncModel {
  String get id;
}
