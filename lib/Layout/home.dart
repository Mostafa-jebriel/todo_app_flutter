import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/archived_task/archivedtask.dart';
import 'package:todo_app/Modules/done_task/donetask.dart';
import 'package:todo_app/Modules/new_task/newtask.dart';
import 'package:todo_app/components/all_widgt.dart';
import 'package:todo_app/components/v_shard.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/state.dart';


class Home extends StatelessWidget  {

  var n = TextEditingController();
  var t = TextEditingController();
  var d = TextEditingController();

  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext c) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext cc,AppStates s){
          if(s is AppInsertDBState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext cc,AppStates s){
          AppCubit cubit=AppCubit.get(cc);
          return   Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                "Todo App",
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition:  s is! AppGetLoadingDBState,
              builder: (con)=>cubit.Screen[cubit.index],
              fallback:  (con)=>EmptyTask(),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabicon),
              onPressed: () {
                if (cubit.isbottomshet) {
                  cubit.insertData(title:n.text, time: t.text, date: d.text);
                }
                else {
                  cubit.changeBottomSheet(isshow: true, icon: Icons.add);
                  scaffoldkey.currentState!.showBottomSheet((context) => AddBottomSheet(),
                    elevation: 20,
                  ).closed.then((value) {
                    cubit.changeBottomSheet(isshow: false, icon: Icons.edit);
                  });
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.index,
              onTap: (i) {
                cubit.changeIndex(i);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }



  Widget AddBottomSheet() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          TextForm(
            c: n,
            type: TextInputType.text,
            lable: 'Title',
            icon: Icons.title,
            // validate: (v){
            //   if(v!.isEmpty){
            //     return "Email is empty";
            //   }
            //   return null;
            // },
          ),
          SizedBox(
            height: 10,
          ),
          TextForm(
              c: t,
              type: TextInputType.datetime,
              lable: 'Time',
              icon: Icons.watch_later_outlined,
              ontab: () {
               // showTimePicker(context: context, initialTime: TimeOfDay.now());
              }
            // validate: (v){
            //   if(v!.isEmpty){
            //     return "Email is empty";
            //   }
            //   return null;
            // },
          ),
          SizedBox(
            height: 10,
          ),
          TextForm(
            c: d,
            type: TextInputType.datetime,
            lable: 'Date',
            icon: Icons.date_range,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

