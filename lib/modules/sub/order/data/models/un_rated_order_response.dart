class UnRatedOrderResponse {
  final bool success;
  final String data;

  UnRatedOrderResponse({required this.success, required this.data});
  factory UnRatedOrderResponse.fromJson(Map<String, dynamic> map) =>
      UnRatedOrderResponse(
        success: map['success'],
        data: map['data'] ?? '',
      );
}
