import 'package:go_router/go_router.dart';
import '../data/pet.dart';
import '../ui/home_page.dart';
import '../ui/details_page.dart';
import '../ui/history_page.dart';
import '../ui/splash_screen.dart';

class AppRouter {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) =>  HomePage()),
      //GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/details',
        builder: (context, state) => DetailsPage(pet: state.extra as Pet),
      ),
      GoRoute(path: '/history', builder: (context, state) =>  HistoryPage()),
    ],
  );
}
