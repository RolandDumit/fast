import 'dart:io';

class HttpProxy extends HttpOverrides {
  String? host;
  String? port;

  HttpProxy._(this.host, this.port);

  static create({required String host, required String port}) {
    final proxy = HttpProxy._(host, port);
    HttpOverrides.global = proxy;
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return true;
    };
    return client;
  }

  @override
  String findProxyFromEnvironment(Uri url, Map<String, String>? environment) {
    if (host == null) {
      return super.findProxyFromEnvironment(url, environment);
    }

    environment ??= {};

    if (port != null) {
      environment['http_proxy'] = '$host:$port';
      environment['https_proxy'] = '$host:$port';
    } else {
      environment['http_proxy'] = '$host:8888';
      environment['https_proxy'] = '$host:8888';
    }

    return super.findProxyFromEnvironment(url, environment);
  }
}
