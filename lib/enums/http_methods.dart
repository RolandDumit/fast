enum HttpMethods {
  get,
  post,
  put,
  delete,
  patch,
}

extension HttpMethodsExtension on HttpMethods {
  String get value {
    switch (this) {
      case HttpMethods.get:
        return 'GET';
      case HttpMethods.post:
        return 'POST';
      case HttpMethods.put:
        return 'PUT';
      case HttpMethods.delete:
        return 'DELETE';
      case HttpMethods.patch:
        return 'PATCH';
    }
  }
}
