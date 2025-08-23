import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_model.dart';

abstract class SyncEntity<T extends SyncModel, V> {
  /// Slug used for the local database and remote sync engine
  String get slug;

  /// Interceptor used to hook and serialize/deserialize the
  RequestInterceptor<T, V> get requestInterceptor;

  /// Used when saving the model to local database
  Map<String, dynamic> toMap(T data);

  /// Used when reading from the local database
  T fromMap(Map<String, dynamic> row);

  /// Used when serializing data to send to the sync engine
  V serialize(T data);

  /// Used when deserializing data recieved from the sync engine
  T deserialize(V data);

  /// List of the local database fields
  /// they will be joined and added to the CREATE IF NOT EXISTS statement
  List<String> get sqliteFields;

  late final createIfNotExistsQuery =
      "CREATE TABLE IF NOT EXISTS $slug (${sqliteFields.join(",")})";

  late final dropIfExistsQuery = "DROP TABLE IF EXISTS $slug";

  // Equality Override //

  @override
  bool operator ==(Object other) {
    if (other is! SyncEntity) return false;
    return slug == other.slug;
  }

  @override
  int get hashCode => Object.hash(slug, this);
}
