import 'package:get/get.dart';


import '../modules/pages/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/pages/edit_profile/views/edit_profile_view.dart';
import '../modules/admin_navigation/bindings/admin_navigation_binding.dart';
import '../modules/admin_navigation/views/admin_navigation_view.dart';
import '../modules/navigation/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/navigation/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/pages/auth/login/bindings/login_binding.dart';
import '../modules/pages/auth/login/views/login_view.dart';
import '../modules/pages/auth/register/bindings/register_binding.dart';
import '../modules/pages/auth/register/views/register_view.dart';
import '../modules/pages/dashboard/bindings/dashboard_binding.dart';
import '../modules/pages/dashboard/views/dashboard_view.dart';
import '../modules/pages/detail-movie/bindings/detail_movie_binding.dart';
import '../modules/pages/detail-movie/views/detail_movie_view.dart';
import '../modules/pages/home/bindings/home_binding.dart';
import '../modules/pages/home/views/home_view.dart';
import '../modules/pages/notification/bindings/notification_binding.dart';
import '../modules/pages/notification/views/notification_view.dart';
import '../modules/pages/order_history/bindings/order_history_binding.dart';
import '../modules/pages/order_history/views/order_history_view.dart';
import '../modules/pages/profile/bindings/profile_binding.dart';
import '../modules/pages/profile/views/profile_view.dart';
import '../modules/pages/reservation/bindings/reservation_binding.dart';
import '../modules/pages/reservation/views/reservation_view.dart';
import '../modules/pages/scan_ticket/bindings/scan_ticket_binding.dart';
import '../modules/pages/scan_ticket/views/scan_ticket_view.dart';
import '../modules/pages/splash/bindings/pages_splash_binding.dart';
import '../modules/pages/splash/views/pages_splash_view.dart';
import '../modules/pages/ticket/bindings/ticket_binding.dart';
import '../modules/pages/ticket/views/ticket_view.dart';
import '../modules/pages/total_income/bindings/total_income_binding.dart';
import '../modules/pages/total_income/views/total_income_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MOVIE,
      page: () => const DetailMovieView(),
      binding: DetailMovieBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => const BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RESERVATION,
      page: () => const ReservationView(),
      binding: ReservationBinding(),
    ),
    GetPage(
      name: _Paths.TICKET,
      page: () => const TicketView(),
      binding: TicketBinding(),
    ),
        GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      name: _Paths.TOTAL_INCOME,
      page: () => const TotalIncomeView(),
      binding: TotalIncomeBinding(),
    ),
     GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_TICKET,
      page: () => const ScanTicketView(),
      binding: ScanTicketBinding(),
    ),
    GetPage(
      name: _Paths.PAGES_SPLASH,
      page: () => const PagesSplashView(),
      binding: PagesSplashBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_NAVIGATION,
      page: () => const AdminNavigationView(),
      binding: AdminNavigationBinding(),
    ),

  ];
}
