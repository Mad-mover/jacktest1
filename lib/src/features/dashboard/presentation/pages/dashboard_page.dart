import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  final Widget child;

  const DashboardPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: MediaQuery.of(context).size.width >= 800,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store_outlined),
                selectedIcon: Icon(Icons.store),
                label: Text('Branches'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart),
                label: Text('Purchases'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.swap_horiz_outlined),
                selectedIcon: Icon(Icons.swap_horiz),
                label: Text('Transfers'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: Text('History'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outlined),
                selectedIcon: Icon(Icons.people),
                label: Text('Suppliers'),
              ),
            ],
            selectedIndex: _getSelectedIndex(context),
            onDestinationSelected: (index) {
              if (index == 0) context.go('/');
              if (index == 1) context.go('/products');
              if (index == 2) context.go('/branches');
              if (index == 3) context.go('/purchases');
              if (index == 4) context.go('/transfer-center');
              if (index == 5) context.go('/transfer-history');
              if (index == 6) context.go('/suppliers');
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/products')) return 1;
    if (location.startsWith('/branches')) return 2;
    if (location.startsWith('/purchases')) return 3;
    if (location.startsWith('/transfer-center')) return 4;
    if (location.startsWith('/transfer-history')) return 5;
    if (location.startsWith('/suppliers')) return 6;
    return 0;
  }
}
