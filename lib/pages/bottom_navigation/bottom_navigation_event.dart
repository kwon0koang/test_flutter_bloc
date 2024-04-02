import 'package:test_flutter_bloc/common/enums.dart';

abstract class BottomNavigationEvent {}

class UpdateMenuType extends BottomNavigationEvent {
  UpdateMenuType({required this.menuType});
  final BottomNavigationMenuType menuType;
}
