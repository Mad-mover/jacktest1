import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/branches/presentation/pages/branches_page.dart';
import '../../features/inventory/presentation/pages/inventory_history_page.dart';
import '../../features/inventory/presentation/pages/transfer_center_page.dart';
import '../../features/inventory/presentation/pages/transfer_history_page.dart';
import '../../features/purchases/presentation/pages/purchases_page.dart';
import '../../features/purchases/presentation/pages/suppliers_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardPage(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Center(child: Text('Welcome to Dashboard')),
            ),
          ),
          GoRoute(
            path: '/products',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProductsPage()),
          ),
          GoRoute(
            path: '/branches',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: BranchesPage()),
          ),
          GoRoute(
            path: '/inventory-history',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: InventoryHistoryPage()),
          ),
          GoRoute(
            path: '/transfer-center',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TransferCenterPage()),
          ),
          GoRoute(
            path: '/transfer-history',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TransferHistoryPage()),
          ),
          GoRoute(
            path: '/purchases',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: PurchasesPage()),
          ),
          GoRoute(
            path: '/suppliers',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SuppliersPage()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.orange),
            const SizedBox(height: 16),
            Text('Route not found: ${state.uri.path}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
