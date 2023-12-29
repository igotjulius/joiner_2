import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/cra_controller.dart';
import 'package:joiner_1/models/cra_user_model.dart';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/utils/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';
import 'pages/cra/car/cra_car_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final authState = AuthController();
  await authState.initializePersistedState();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(
          value: authState,
        ),
        ChangeNotifierProxyProvider<AuthController, Auth?>(
          create: (_) => null,
          update: (_, auth, user) => auth.userTypeController,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // For caching user data
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('app is paused');
      await context.read<AuthController>().userTypeController?.cacheUser();
      print('done caching');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var user = context.select<AuthController, User?>(
        (value) => value.userTypeController?.profile);
    return MaterialApp.router(
      title: 'Joiner 1',
      theme: lightTheme(context),
      routerConfig: GoRouter(
        initialLocation: '/login',
        debugLogDiagnostics: true,
        errorBuilder: (context, state) {
          print('${state.error} ${state.fullPath}');
          return LoginPageWidget();
        },
        routes: context
            .select<AuthController, List<GoRoute>>((value) => value.routes),
        redirect: (context, state) {
          bool loggingIn = user != null && state.matchedLocation == '/login';
          bool loggingOut = user == null && state.matchedLocation == '/account';
          if (loggingIn) {
            if (user?.verification == null ||
                user?.verification!['createdAt'] != null) {
              user = null;
              return '/verification';
            }
            return user is CraUserModel ? '/cars' : '/lobby';
          }
          if (loggingOut) return '/login';
          return null;
          // return appState.redirectState(state);
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// The widget accountable for bottom navigation bar.
class _NavBarPageState extends State<NavBarPage>
    with SingleTickerProviderStateMixin {
  String _currentPageName = 'Login';
  late Widget? _currentPage;
  late final AnimationController _controller = AnimationController.unbounded(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, value, child) {
        return value.userTypeController is CraController
            ? craDashboard()
            : userDashboard();
      },
    );
  }

  Widget userDashboard() {
    // final tabs = {
    //   'MainDashboard': LobbiesWidget(),
    //   'CarRentals': RentalsWidget(),
    //   'Friends': FriendsWidget(),
    //   'Account': AccountWidget(),
    // };
    final tabs = [
      LobbiesWidget(),
      RentalsWidget(),
      FriendsWidget(),
      AccountWidget(),
    ];
    // final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: AlwaysStoppedAnimation(Offset(-_controller.value, 0)),
              child: tabs[_controller.value.toInt()],
            );
          },
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Colors.transparent,
        child: Card(
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: GNav(
              selectedIndex: _controller.value.toInt(),
              onTabChange: (i) {
                //   setState(() {
                //   _currentPage = null;
                //   _currentPageName = tabs.keys.toList()[i];
                // });
                setState(() {
                  // _controller.value = 1;
                  _controller.animateTo(i.toDouble());
                });
              },
              color: Colors.grey,
              activeColor: Theme.of(context).primaryColor,
              tabBackgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              padding: EdgeInsetsDirectional.all(10),
              gap: 8,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              duration: Duration(milliseconds: 500),
              haptic: false,
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
              tabs: [
                GButton(
                  icon: Icons.meeting_room_rounded,
                  text: 'Lobby',
                ),
                GButton(
                  icon: Icons.directions_car,
                  text: 'Rentals',
                ),
                GButton(
                  icon: Icons.people_alt_outlined,
                  text: 'Friends',
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: 'Account',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget craDashboard() {
    final tabs = {
      'Cars': CraCarWidget(),
      'CraRentals': RentalsWidget(),
      'Account': AccountWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: SafeArea(child: _currentPage ?? tabs[_currentPageName]!),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: const Offset(
                0.0,
                -1.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          color: Colors.grey,
          activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          padding: EdgeInsetsDirectional.all(10),
          gap: 8,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          duration: Duration(milliseconds: 500),
          haptic: false,
          tabMargin: EdgeInsets.all(10),
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
          tabs: [
            GButton(
              icon: Icons.directions_car,
              text: 'Cars',
              iconSize: 24.0,
            ),
            GButton(
              icon: Icons.receipt_rounded,
              text: 'Rentals',
              iconSize: 24.0,
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
              iconSize: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
