import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_cubit.dart' show HomeCubit;

class TaskCardController {
  Future<void> openContextMenu(
      BuildContext context,
      Offset tapPosition,
      int taskKey,
      ) async {
    final cubit = context.read<HomeCubit>();

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          tapPosition.dx, tapPosition.dy, tapPosition.dx, tapPosition.dy),
      items: const [
        PopupMenuItem(
          value: "delete",
          child: Row(
            children: [
              Icon(Icons.delete_outline_outlined,),
              SizedBox(width: 10),
              Text("Удалить"),
            ],
          ),
        ),
      ],
    );

    if (result == "delete") {
      cubit.deleteTask(taskKey);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Задача удалена"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
