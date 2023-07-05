import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo/data/remote/servise/revision_service.dart';
import 'package:todo/core/utils/my_exceptions.dart';
import 'package:todo/core/utils/my_strings.dart';

class RemoteService {
  Dio? _dio;

  Dio get _getDio {
    _dio ??= Dio(
      BaseOptions(baseUrl: MyStrings.baseUrl, headers: {
        "Authorization": "Bearer ${MyStrings.bearerKey}",
      }),
    )..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['X-Last-Known-Revision'] =
              await RevisionService.get();
          handler.next(options);
        },
      ));
    return _dio!;
  }

  Future<Response> getAll() async {
    return _tryRequest(() => _getDio.get("/list/"));
  }

  Future<Response> post(Map<String, dynamic> data) async {
    print("post $data");
    return _tryRequest(() => _getDio.post("/list/", data: data));
  }

  Future<Response> put(String uuid, Map<String, dynamic> data) async {
    return _tryRequest<Response>(() => _getDio.put("/list/$uuid", data: data));
  }

  Future<Response> delete(String uuid) async {
    return _tryRequest(() => _getDio.delete("/list/$uuid"));
  }

  Future<Response> patch(Map<String, dynamic> data) async {
    return  _tryRequest<Response>(() => _getDio.patch("/list/", data: data));
  }

  Future<T> _tryRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (dioException) {
      switch (dioException.type) {
        case DioExceptionType.connectionTimeout ||
              DioExceptionType.sendTimeout ||
              DioExceptionType.receiveTimeout ||
              DioExceptionType.cancel ||
              DioExceptionType.connectionError:
          throw NoInternetException();
        case DioExceptionType.badResponse:
          throw ResponseException('bad response');
        default:
          if (dioException.error is SocketException) {
            throw NoInternetException();
          }
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetException();
    } catch (_) {
      throw NoInternetException();
    }
  }
}
