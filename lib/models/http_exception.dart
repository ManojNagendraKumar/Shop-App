class HttpException with Exception {
  String? message;

  HttpException(this.message);

  @override
  String toString() {
    return message!;
  }
}
