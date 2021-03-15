import 'package:bloc/bloc.dart';
import 'package:card_docker/enums/enums.dart';

class HomePageCubit extends Cubit<HomePageType> {
  HomePageCubit() : super(HomePageType.stats);

  void updatePage(int index) {
    final newPage = HomePageType.values[index];
    emit(newPage);
  }
}
