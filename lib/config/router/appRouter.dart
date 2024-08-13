
import 'package:go_router/go_router.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';
import 'package:radio_app/presentation/screens/radio_stations_screen.dart';
import 'package:radio_app/presentation/screens/station_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RadioStationsScreen(), 
    ),

    GoRoute(
      path: '/station',
      builder: (context, state) {
        final RadioStationsModel station = state.extra as RadioStationsModel;
        return StationScreen(station: station);
      },
    ),
  ]
);