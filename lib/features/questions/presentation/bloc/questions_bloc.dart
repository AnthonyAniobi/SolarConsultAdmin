import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {
    on<QuestionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
