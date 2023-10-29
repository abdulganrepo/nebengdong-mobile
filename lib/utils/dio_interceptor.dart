import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nebengdong/utils/logger.dart';

class DioLogingIntercepotrs extends InterceptorsWrapper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.f('REQUEST[${options.method}] => PATH: ${options.path}');
    log.f('REQUEST[${options.method}] => PATH URI: ${options.uri}');
    log.f('REQUEST[${options.method}] => HEADER: ${options.headers}');
    log.f('REQUEST[${options.method}] => DATA: ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.f(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    log.f(
      'RESPONSE[${response.data}] => PATH: ${response.requestOptions.path}',
    );

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log.f(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    return super.onError(err, handler);
  }
}
