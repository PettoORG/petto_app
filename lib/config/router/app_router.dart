import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/auth', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        name: PetProfileScreen.name,
        path: 'pet-profile',
        builder: (context, state) => const PetProfileScreen(),
      ),
      GoRoute(
          name: NotificationSettingScreen.name,
          path: 'notifications-settings',
          builder: (context, state) => const NotificationSettingScreen()),
      GoRoute(
        name: AccountScreen.name,
        path: 'account',
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        name: NotificationsScreen.name,
        path: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
    ],
  ),
  GoRoute(
    path: '/pet-register',
    name: PetRegisterScreen.name,
    builder: (context, state) => const PetRegisterScreen(),
  ),
  GoRoute(
    path: '/onboarding',
    name: OnboardingScreen.name,
    builder: (context, state) => const OnboardingScreen(),
  ),
  GoRoute(
    path: '/splash',
    name: SplashScreen.name,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/offline',
    name: OfflineScreen.name,
    builder: (context, state) => const OfflineScreen(),
  ),
  GoRoute(
    path: '/auth',
    name: AuthScreen.name,
    builder: (context, state) => const AuthScreen(),
  ),
]);
