import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
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
        path: 'notification',
        builder: (context, state) => const NotificationSettingScreen(),
      ),
      GoRoute(
        name: TCScreen.name,
        path: 'tc',
        builder: (context, state) => const TCScreen(),
        routes: [
          GoRoute(
            name: TermsAndCondicionsView.name,
            path: 'terms',
            builder: (context, state) => const TermsAndCondicionsView(),
          ),
          GoRoute(
            name: PrivacyPoliciesView.name,
            path: 'privacy',
            builder: (context, state) => const PrivacyPoliciesView(),
          )
        ]
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
