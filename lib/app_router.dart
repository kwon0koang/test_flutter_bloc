import 'package:auto_route/auto_route.dart';
import 'package:test_flutter_bloc/app_router.gr.dart';

export 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: MainRoute.page),
    AutoRoute(page: CounterRoute.page),
    AutoRoute(page: CubitCounterRoute.page),
    AutoRoute(page: LeftRightBarsRoute.page),
    AutoRoute(page: ChartRoute.page),
  ];
}
