class StatusList {
  final String id;
  final String name;
  final String? profileImageUrl;
  final bool isViewed;
  final DateTime time;
  StatusList({
    required this.id,
    required this.name,
    this.profileImageUrl,
    required this.isViewed,
    required this.time,
  });
}
