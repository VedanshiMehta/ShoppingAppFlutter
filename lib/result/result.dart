class Result {
  const Result(
    this.list, {
    required this.message,
    required this.isValid,
  });
  final String message;
  final bool isValid;
  final Map<String, dynamic> list;
}
