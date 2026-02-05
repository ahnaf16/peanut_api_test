import 'package:flutter/material.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/navigation/sliding_icon_navbar.dart';

class NavigationRoot extends HookConsumerWidget {
  const NavigationRoot(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootPath = context.routeState.uri.pathSegments.first;

    final Map<RPath, _NavDest> destinations = {
      RPaths.dash: const _NavDest(icon: LIcon.house, text: 'Dashboard'),
      RPaths.promotions: const _NavDest(icon: LIcon.folderKanban, text: 'Promotions'),
      RPaths.profile: const _NavDest(icon: LIcon.user, text: 'Profile'),
    };

    final getIndex = destinations.keys.map((e) => e.name).toList().indexOf(rootPath);

    final index = useState(0);

    useEffect(() {
      index.value = getIndex;
      return null;
    }, [rootPath]);

    return Scaffold(
      bottomNavigationBar: SlidingIconNavbar(
        icons: destinations.values.map((e) => e.icon).toList(),
        labels: destinations.values.map((e) => e.text).toList(),
        currentIndex: index.value,
        onTap: (value) {
          index.value = value;
          destinations.keys.elementAt(value).go(context);
        },
      ),

      body: child,
    );
  }
}

class _NavDest {
  const _NavDest({required this.text, required this.icon});

  final String text;
  final IconData icon;
}
