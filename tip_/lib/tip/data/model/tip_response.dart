// lib/tip/data/models/tip_response.dart
class TipResponse {
  final String link;

  TipResponse({required this.link});

  factory TipResponse.fromJson(Map<String, dynamic> json) {
    return TipResponse(
      link: json['link'] ?? '',
    );
  }
}
