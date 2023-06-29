import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:todo/presentation/utils/my_icons.dart';
import 'package:todo/presentation/utils/my_text_styles.dart';

class MySliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;

  MySliverAppbarDelegate({required this.context});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return LayoutBuilder(builder: (context, constrains) {
      final size = constrains.maxHeight;
      final animationFactor = (size - minExtent) / (maxExtent - minExtent);
      return Container(
        height: size,
        decoration: BoxDecoration(
          color: MyColors.primary,
          boxShadow: [
            if (shrinkOffset > maxExtent - minExtent)
              const BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                offset: Offset(0, 1),
              ),
          ],
        ),
        child: BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
          final tasksBloc = BlocProvider.of<TasksBloc>(context);

          return Stack(children: [
            Positioned(
              bottom: 16 + 28 * animationFactor,
              left: 16 + 44 * animationFactor,
              child: Text(
                'Мои дела',
                style: MyTextStyles.lagreTitle
                    .copyWith(fontSize: 20 + 12 * animationFactor),
              ),
            ),
            Positioned(
              bottom: 16 + 2 * animationFactor,
              left: 60 + 120 * (1 - animationFactor),
              child: Text(
                'Выполнено — ${tasksBloc.doneCount}',
                style: MyTextStyles.body.copyWith(
                  color:
                      MyColors.labelTertiary.withOpacity(0.3 * animationFactor),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: SizedBox(
                width: 40,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => tasksBloc.add(TaskVisibleChangeEvent()),
                  child: SvgPicture.asset(
                    tasksBloc.visible
                        ? MyIcons.visibility
                        : MyIcons.visibilityOff,
                    color: MyColors.blue,
                  ),
                ),
              ),
            ),
          ]);
        }),
      );
    });
  }

  @override
  double get maxExtent => 150 + MediaQuery.of(context).padding.top;

  @override
  double get minExtent => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
