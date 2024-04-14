// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_log/src/model/table_model.dart';

part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  final FirebaseFirestore firestore;
  TableCubit(
    this.firestore,
  ) : super(TableInitial());

  Future createTables(int tableNumber) async {
    await firestore
        .collection('tables')
        .doc()
        .set({'tableNumber': tableNumber});
  }

  Future<List<TableModel>> getTables() async {
    emit(TableLoading());

    var data = await firestore.collection('tables').get();

    // Extract data from documents and convert to list of maps
    var tableData = data.docs.map((e) => e.data()).toList();

    // Encode the list of maps to JSON
    var jsonData = jsonEncode(tableData);

    // Pass the JSON string to tableModelFromJson
    var model = tableModelFromJson(jsonData);
    emit(TableLoaded(listOfTables: model));
    return model;
  }
}
