import 'package:flutter/foundation.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
  HttpLogger(logLevel: kReleaseMode ? LogLevel.NONE : LogLevel.BASIC),
]);