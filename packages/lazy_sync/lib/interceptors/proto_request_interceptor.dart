import 'dart:typed_data';

import 'package:lazy_sync/interceptors/request_interceptor.dart';
import 'package:lazy_sync/models/sync_model.dart';

class ProtoRequestInterceptor<T extends SyncModel, V extends Uint8List>
    extends RequestInterceptor<T, V> {
  @override
  // TODO: implement contentHeaders
  Map<String, String> get contentHeaders => throw UnimplementedError();

  @override
  V getRequestBody(T data) {
    // TODO: implement getRequestBody
    throw UnimplementedError();
  }

  @override
  T readRequestBody(V data) {
    // TODO: implement readRequestBody
    throw UnimplementedError();
  }
}
