part of 'core_bloc.dart';

abstract class CoreState extends Equatable {
  const CoreState();  

  @override
  List<Object> get props => [];
}
class CoreInitial extends CoreState {}
