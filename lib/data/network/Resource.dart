class Resource<T> {
  Status status;

  T data;

  String message;

  bool loading;

  Resource.loading(this.loading) : status = Status.LOADING;

  Resource.success(this.data) : status = Status.SUCCESS;

  Resource.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, SUCCESS, ERROR }
