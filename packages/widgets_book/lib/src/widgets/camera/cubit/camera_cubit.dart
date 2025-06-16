import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FileState {
  FileState({this.file});
  final XFile? file;
}

class CameraCubit extends Cubit<FileState> {
  CameraCubit() : super(FileState());

  void changeState(XFile? file) {
     emit(FileState(file: file));
  }
}
