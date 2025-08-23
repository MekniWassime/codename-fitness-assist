import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_options.freezed.dart';

@freezed
abstract class QueryOptions with _$QueryOptions {
  const QueryOptions._();

  const factory QueryOptions({
    String? where,
    List<Object?>? whereArgs,
    int? limit,
    int? offset,
    String? orderBy,
    bool? distinct,
  }) = _QueryOptions;

  /// Append a where condition to the end of the current where clause
  /// `operator` will be used when appending the new condition to the old clause
  QueryOptions addWhereCondition(
    String condition, {
    Object? arg,
    String operator = "AND",
  }) {
    assert(
      condition.contains("?") && arg != null,
      "arg must only be provided if the condition accepts ? placeholer arguments",
    );
    String newWhere;
    List<Object?>? newArgs;
    if (where != null) {
      newWhere = "$where $operator $condition";
    } else {
      newWhere = condition;
    }
    if (arg != null) {
      newArgs = [...(whereArgs ?? []), arg];
    } else {
      newArgs = whereArgs;
    }
    return copyWith(where: newWhere, whereArgs: newArgs);
  }

  /// Sets orderBy if its not provided
  QueryOptions setOrderByIfNull(String orderBy) =>
      copyWith(orderBy: this.orderBy ?? orderBy);
}
