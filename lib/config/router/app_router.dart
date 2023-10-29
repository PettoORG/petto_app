import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/screens/home/home_views.dart';
import 'package:petto_app/UI/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
    path: '/',
    name: HomeViews.name,
    builder: (context, state) => const HomeViews(),
    routes: [
      GoRoute(
        path: 'user-profile',
        name: UserProfileScreen.name,
        builder: (context, state) => const UserProfileScreen(),
      )
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
  )
]);
