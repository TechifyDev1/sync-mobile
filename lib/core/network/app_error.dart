class AppError implements Exception {
  final String title;
  final String message;
  final int status;
  final String timeStamp;

  AppError({
    required this.title,
    required this.message,
    required this.status,
    required this.timeStamp,
  });

  factory AppError.fromJson(Map<String, dynamic> json) {
    return AppError(
      title: json["title"],
      message: json["message"],
      status: json["status"],
      timeStamp: json["timeStamp"],
    );
  }

  @override
  String toString() {
    return 'AppError(Title: $title, Status: $status, Message: $message, timestamp: $timeStamp)';
  }
}
