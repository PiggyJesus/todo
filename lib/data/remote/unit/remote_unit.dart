import 'package:todo/data/remote/servise/remote_service.dart';
import 'package:todo/data/remote/servise/revision_service.dart';
import 'package:todo/domain/models/response.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/utils/my_exceptions.dart';

class RemoteUnit {
  final RemoteService _remoteServise = RemoteService();

  Future<MyResponse<List<TaskModel>>> getAll() async {
    return _handleExxeptions(() async {
      final response = await _remoteServise.getAll();

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['list'];
        final mappedData =
            data.map((json) => TaskModel.fromJson(json)).toList();
        final int revision = response.data['revision'];

        return MyResponse(
          status: response.statusCode!,
          data: mappedData,
          revision: revision,
        );
      }
      return MyResponse(status: response.statusCode!);
    });
  }

  Future<MyResponse<bool>> postAll(List<TaskModel> tasks) async {
    return _handleExxeptions(() async {
      final data = tasks.map((e) => e.toJson()).toList();

      final response = await _remoteServise.patch({'list': data});

      if (response.statusCode == 200) {
        final revision = response.data['revision'];
        RevisionService.set(revision);

        return MyResponse(
          status: response.statusCode!,
          data: true,
          revision: revision,
        );
      }
      return MyResponse(status: response.statusCode!);
    });
  }

  Future<MyResponse<bool>> insert(TaskModel task) async {
    return _handleExxeptions(() async {
      final data = <String, dynamic>{'element': task.toJson()};
      final response = await _remoteServise.post(data);

      if (response.statusCode == 200) {
        final revision = response.data['revision'];
        RevisionService.set(revision);
        return MyResponse(
          status: response.statusCode!,
          data: true,
          revision: revision,
        );
      }
      return MyResponse(status: response.statusCode!);
    });
  }

  Future<MyResponse<bool>> update(TaskModel task) async {
    return _handleExxeptions(() async {
      final data = <String, dynamic>{'element': task.toJson()};
      final response = await _remoteServise.put(task.uuid, data);

      if (response.statusCode == 200) {
        final revision = response.data['revision'];
        RevisionService.set(revision);
        return MyResponse(
          status: response.statusCode!,
          data: true,
          revision: revision,
        );
      }
      return MyResponse(status: response.statusCode!);
    });
  }

  Future<MyResponse<bool>> delete(String uuid) async {
    return _handleExxeptions(() async {
      final response = await _remoteServise.delete(uuid);

      if (response.statusCode == 200) {
        final revision = response.data['revision'];
        RevisionService.set(revision);
        return MyResponse(
          status: response.statusCode!,
          data: true,
          revision: revision,
        );
      }
      return MyResponse(status: response.statusCode!);
    });
  }

  Future<MyResponse<T>> _handleExxeptions<T>(
    Future<MyResponse<T>> Function() func,
  ) async {
    try {
      return await func();
    } on NoInternetException catch (_) {
      return MyResponse(status: 503);
    } on ResponseException catch (_) {
      return MyResponse(status: 400);
    } catch (_) {
      return MyResponse(status: 500);
    }
  }
}
