import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home/pet-register', routes: [
  GoRoute(
    path: '/home',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        path: 'pet-register',
        name: PetRegisterScreen.name,
        builder: (context, state) => const PetRegisterScreen(),
      ),
    ],
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
