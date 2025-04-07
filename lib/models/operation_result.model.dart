class OperationResult<T> {
  bool success;
  T? data;
  String? message;
  bool? checkAuth;
  String? errorCodeString;

  OperationResult(
      {this.success = false,
      this.data,
      this.message,
      this.errorCodeString,
      this.checkAuth});
}
