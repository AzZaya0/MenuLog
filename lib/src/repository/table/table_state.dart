part of 'table_cubit.dart';

sealed class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

final class TableInitial extends TableState {}

final class TableLoading extends TableState {}

final class TableLoaded extends TableState {
  final List<TableModel> listOfTables;

  TableLoaded({required this.listOfTables});

  @override
  List<Object> get props => [listOfTables];
}
