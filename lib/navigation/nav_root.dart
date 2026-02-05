import 'package:flutter/material.dart';
import 'package:post_wagens/main.export.dart';
import 'package:post_wagens/navigation/sliding_icon_navbar.dart';

class NavigationRoot extends HookConsumerWidget {
  const NavigationRoot(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootPath = context.routeState.uri.pathSegments.first;

    final Map<RPath?, _NavDest> destinations = {
      RPaths.home: const _NavDest(icon: LIcon.house, text: 'Home'),
      RPaths.search: const _NavDest(icon: LIcon.store, text: 'Listing'),
      null: const _NavDest(icon: LIcon.squarePlus, text: 'Add', centered: true),
      RPaths.chat: const _NavDest(icon: LIcon.messageSquareMore, text: 'Chat'),
      RPaths.profile: const _NavDest(icon: LIcon.user, text: 'Profile'),
    };

    final getIndex = destinations.keys
        .map((e) => e?.name)
        .toList()
        .indexOf(rootPath);

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
        showOverlayAt: 2,
        overlayBuilder: (context) => const _CenterNavButtons(),
        onTap: (value) {
          index.value = value;
          destinations.keys.elementAt(value)?.go(context);
        },
      ),

      body: child,
    );
  }
}

class _CenterNavButtons extends StatelessWidget {
  const _CenterNavButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .end,
      children: [
        DecoContainer(
          height: 50,
          width: 200,
          // margin: Pads.only(bottom: context.padding.bottom + kBottomNavigationBarHeight + 14),
          color: context.colors.surfaceContainer,
          borderColor: context.colors.primary,
          borderWidth: 1.5,
          borderRadius: 999,
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.nPop();
                    RPaths.search.push(context);
                  },
                  child: const DecoContainer(
                    alignment: .center,
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: Insets.sm,
                      children: [Icon(LIcon.imagePlus, size: 18), Text('Post')],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.nPop();
                    RPaths.search.push(context);
                  },
                  child: const DecoContainer(
                    alignment: .center,
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: Insets.sm,
                      children: [
                        Icon(LIcon.shoppingBag, size: 18),
                        Text('Listing'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.nPop(),
          child: Container(
            color: Colors.transparent,
            height: context.padding.bottom + kBottomNavigationBarHeight + 14,
          ),
        ),
      ],
    );
  }
}

class _NavDest {
  const _NavDest({
    required this.text,
    required this.icon,
    this.centered = false,
  });

  final String text;
  final IconData icon;
  final bool centered;
}
