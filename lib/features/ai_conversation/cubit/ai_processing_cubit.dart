import 'package:flutter_bloc/flutter_bloc.dart';

class AiResponseProcessingCubit extends Cubit<String> {
  AiResponseProcessingCubit() : super('');

  void addWord(String word) {
    emit(state + word);
  }

  void reset() {
    emit('');
  }
}
