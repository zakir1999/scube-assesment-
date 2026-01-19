import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/details/presentation/pages/details_page.dart';
import '../../features/splash/presentation/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/', // Start at Root (Splash)
  routes: [
    // Splash Route
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    // Login Route
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    // Dashboard Route
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    // Details Route
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsPage(),
    ),
  ],
);