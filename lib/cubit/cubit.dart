import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/archived_task/archivedtask.dart';
import 'package:todo_app/Modules/done_task/donetask.dart';
import 'package:todo_app/Modules/new_task/newtask.dart';
import 'package:todo_app/cubit/state.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(con)=> BlocProvider.of(con);
  int index = 0;
  Database? db;
  List<Map> Ntasks=[];
  List<Map> Dtasks=[];
  List<Map> Atasks=[];
  bool isbottomshet = false;
  IconData fabicon = Icons.edit;
  List<Widget> Screen = [
    NewTask(),
    DoneTask(),
    ArchivedTask(),
  ];
  bool Mode=false;
  void changeMode(){
    Mode = !Mode;
    emit(AppMode());

  }
  void changeIndex(int i){
    index=i;
    emit(AppChangeBNBS());
  }

  void changeBottomSheet({required bool isshow, required IconData icon,}){
    isbottomshet=isshow;
    fabicon=icon;

    emit(AppChangeBottomSheetState());
  }

  void createDB() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        //id int title text date text time text status text

        print('db created');
        database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error in table${error.toString()}');
        });
      },
      onOpen: (database) {
        print('db Open');
        getData(database);
      },
    ).then((value){
      db=value;
      emit(AppCreateDBState());
    });
  }

  insertData({required String title,required String time,required String date}) {
    db!.transaction((txn) async {
      txn.rawInsert('INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date","$time","new")')
          .then((value) {
        print("$value INSERT done");
        emit(AppInsertDBState());
        getData(db);
      }).catchError((e) {
        print('error in INSERT ${e.toString()}');
      });
    });
  }

  void updateDate({required String status,required int id}) async{
    db!.rawUpdate(
      'UPDATE Tasks set status = ? WHERE id = ?',
      ['$status',id],
    ).then((value){
      getData(db);
      emit(AppUpdateDBState());
    });


  }

  void deleteDate({required int id}){
    db!.rawDelete('DELETE FROM  Tasks WHERE id = ?',
        [id]).then((value) {
      getData(db);
      emit(AppDeleteDBState());
    });
  }

  void getData(db)  {
    Ntasks =[];
    Dtasks =[];
    Atasks =[];
    emit(AppGetLoadingDBState());
    db.rawQuery('SELECT  * FROM Tasks').then((value){
      value.forEach((element) {
        if(element['status']=='new'){
          Ntasks.add(element);
        }
        else if(element['status']=='done'){
          Dtasks.add(element);
        }
        else {
          Atasks.add(element);
        }
      });
      emit(AppGetDBState());
    });
  }
}