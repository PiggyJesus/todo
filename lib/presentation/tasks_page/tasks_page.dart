import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/presentation/add_page/add_page.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/tasks_page/widgets/my_sliver_appbar.dart';
import 'package:todo/presentation/tasks_page/widgets/my_sliver_list.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:todo/presentation/utils/my_icons.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

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
              MySLiverList(),
              // SliverToBoxAdapter(
              //   child: Container(height: 200, color: Colors.red) ,
              // )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddPage(-1)));
            },
            child: SvgPicture.asset(MyIcons.add, color: MyColors.white),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
