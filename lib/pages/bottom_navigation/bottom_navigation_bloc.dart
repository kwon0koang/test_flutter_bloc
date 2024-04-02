import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/common/enums.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/bottom_navigation/bottom_navigation_event.dart';
import 'package:test_flutter_bloc/pages/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final RandomUserClient _randomUserClient;

  BottomNavigationBloc({required RandomUserClient randomUserClient})
      : _randomUserClient = randomUserClient,
        super(
          const BottomNavigationState(menuType: BottomNavigationMenuType.home),
        ) {
    on<UpdateMenuType>((event, emit) async {
      emit(state.copyWith(menuType: event.menuType));
    });
  }
}
