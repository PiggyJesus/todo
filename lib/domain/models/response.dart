class MyResponse<T> {
  final int status;
  final T? data;

  MyResponse({required this.status, this.data});
}
