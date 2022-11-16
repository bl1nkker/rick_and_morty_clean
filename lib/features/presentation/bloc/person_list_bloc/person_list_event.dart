import 'package:equatable/equatable.dart';

abstract class PersonListEvent extends Equatable {
  const PersonListEvent();

  @override
  List<Object?> get props => [];
}

class PersonList extends PersonListEvent {
  final int page;

  const PersonList(this.page);
}
