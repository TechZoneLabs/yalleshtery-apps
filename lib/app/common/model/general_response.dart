class GerenalResponse {
  final bool success;
  final String msg;

  GerenalResponse({
    required this.success,
    required this.msg,
  });
  factory GerenalResponse.fromJson(Map<String, dynamic> map) => GerenalResponse(
        success: map['success'],
        msg: map.containsKey('message') ? map['message'] : '',
      );
}
