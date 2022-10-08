import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_result.freezed.dart';

@freezed
class OrdersResult<T> with _$OrdersResult<T> {
  factory OrdersResult.success(T data) = Success;
  factory OrdersResult.error(String massage) = Error;
}
