class MyResponse<T> {
  final int status;
  final T? data;
  final int? revision;

  MyResponse({required this.status, this.data, this.revision});
}
