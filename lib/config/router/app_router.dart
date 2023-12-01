import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:petto_app/domain/entities/pettip.dart';

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
        path: 'notifications-settings',
        builder: (context, state) => const NotificationSettingScreen(),
      ),
      GoRoute(
        name: SuportScreen.name,
        path: 'suport',
        builder: (context, state) => const SuportScreen(),
      ),
      GoRoute(
        name: PettipsScreen.name,
        path: 'pettips',
        builder: (context, state) {
          Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
          Pettip? pettip = extraData['pettip'] as Pettip?;
          return PettipsScreen(pettip: pettip!);
        },
      ),
      GoRoute(
        name: AccountScreen.name,
        path: 'account',
        builder: (context, state) => const AccountScreen(),
        routes: [
          GoRoute(
            name: ChangePasswordScreen.name,
            path: 'change-password',
            builder: (context, state) => const ChangePasswordScreen(),
          )
        ],
      ),
      GoRoute(
        name: NotificationsScreen.name,
        path: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(name: TCScreen.name, path: 'tc', builder: (context, state) => const TCScreen(), routes: [
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
      ]),
    ],
  ),
  GoRoute(
      path: '/pet-register',
      name: PetRegisterScreen.name,
      builder: (context, state) => const PetRegisterScreen(),
      routes: [
        GoRoute(
          path: 'pet-info-register',
          name: PetInfoRegisterScreen.name,
          builder: (context, state) => const PetInfoRegisterScreen(),
        )
      ]),
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
