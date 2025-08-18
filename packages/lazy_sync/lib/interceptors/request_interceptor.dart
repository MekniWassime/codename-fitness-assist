import 'package:lazy_sync/models/sync_model.dart';

abstract class RequestInterceptor<T extends SyncModel, V> {
  Map<String, String> get contentHeaders;

  V getRequestBody(T data);

  T readRequestBody(V data);
}
