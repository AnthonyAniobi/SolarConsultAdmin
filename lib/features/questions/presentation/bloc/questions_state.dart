part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();  

  @override
  List<Object> get props => [];
}
class QuestionsInitial extends QuestionsState {}
