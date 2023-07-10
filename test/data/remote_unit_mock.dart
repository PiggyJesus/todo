import 'package:mockito/mockito.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/domain/models/response.dart';
import 'package:todo/domain/models/task_model.dart';

class RemoteUnitMock extends Mock implements RemoteUnit {
  List<TaskModel> data = [];

  @override
  Future<MyResponse<List<TaskModel>>> getAll() async {
    return MyResponse(
      status: 200,
      data: data,
    );
  }

  @override
  Future<MyResponse<bool>> postAll(List<TaskModel> tasks) async {
    data = tasks;
    return MyResponse(
      status: 200,
      data: true,
    );
  }

  @override
  Future<MyResponse<TaskModel>> getTask(String uuid) async {
    try {
      return MyResponse(
        status: 200,
        data: data.firstWhere((element) => element.uuid == uuid),
      );
    } catch (_) {
      return MyResponse(
        status: 400,
      );
    }
  }

  @override
  Future<MyResponse<bool>> insert(TaskModel task) async {
    int id = data.indexWhere((element) => element.uuid == task.uuid);
    if (id == -1) {
      data.add(task);
    } else {
      data[id] = task;
    }
    return MyResponse(status: 200, data: true);
  }

  @override
  Future<MyResponse<bool>> update(TaskModel task) async {
    int id = data.indexWhere((element) => element.uuid == task.uuid);

    if (id == -1) {
      return MyResponse(status: 400, data: false);
    }
    data[id] = task;
    return MyResponse(status: 200, data: true);
  }

  @override
  Future<MyResponse<bool>> delete(String uuid) async {
    int id = data.indexWhere((element) => element.uuid == uuid);

    if (id == -1) {
      return MyResponse(status: 400, data: false);
    }
    data.removeAt(id);
    return MyResponse(status: 200, data: true);
  }
}
