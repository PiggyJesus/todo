import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/pages/tasks_page/widgets/my_sliver_appbar.dart';
import 'package:todo/presentation/pages/tasks_page/widgets/my_sliver_list.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_icons.dart';

class TasksPage extends StatefulWidget {
  final void Function() onTapNewTask;
  final void Function(String selectedTaskId) onTapEditTask;
  const TasksPage({
    required this.onTapNewTask,
    required this.onTapEditTask,
    super.key,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: MyColors.primary,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: MySliverAppbarDelegate(
                  context: context,
                ),
              ),
              // ignore: prefer_const_constructors
              MySLiverList(onTapEditTask: widget.onTapEditTask,),
              // SliverToBoxAdapter(
              //   child: Container(height: 200, color: Colors.red) ,
              // )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: widget.onTapNewTask,
            child: SvgPicture.asset(MyIcons.add, color: MyColors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
