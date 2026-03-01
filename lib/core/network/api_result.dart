sealed class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  const Success(this.data);
  final T data;
}

class Error<T> extends ApiResult<T> {
  const Error(this.message, {this.code});
  final String message;
  final int? code;
}

class Loading<T> extends ApiResult<T> {
  const Loading();
}
