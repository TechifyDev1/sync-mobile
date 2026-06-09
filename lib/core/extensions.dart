extension StringTruncate on String {
  String truncate(int maxChar) {
    if (length <= maxChar) return this;
    return '${substring(0, maxChar)}...';
  }
}
