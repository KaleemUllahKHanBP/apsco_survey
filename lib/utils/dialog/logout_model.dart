class LogoutResponse {
  final bool status;
  final String msg;
  final List<dynamic> data;

  LogoutResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      status: json['status'],
      msg: json['msg'],
      data: json['data'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'data': data,
    };
  }
}
class LogoutRequest {
  final String username;
  final String tokenId;

  LogoutRequest({
    required this.username,
    required this.tokenId,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'token_id': tokenId,
    };
  }
}
