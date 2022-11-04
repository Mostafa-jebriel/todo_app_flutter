import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/all_widgt.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/state.dart';

class ArchivedTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:(context,state){
        var tasks=AppCubit.get(context).Atasks;
        return ConditionalBuilder(
          condition:  tasks.length>0,
          builder: (con)=>ListView.separated(
              itemBuilder: (c,i)=>ArchiveTaskItem(tasks[i],context),
              separatorBuilder: (c2,i2)=>Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[200],
              ),
              itemCount: tasks.length),
          fallback:  (con)=>EmptyTask(),
        );
      },
    );
  }
}
