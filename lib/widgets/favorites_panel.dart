import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../providers/pokemon_providers.dart';

/// Retractable panel shown at the bottom of EVERY screen
/// (inserted through MaterialApp.builder in main.dart).
class FavoritesPanel extends ConsumerWidget {
  const FavoritesPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = ref.watch(favoritesPanelExpandedProvider);
    final favorites = ref.watch(favoritePokemonProvider);
    final nicknames = ref.watch(nicknamesProvider);
    final scheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 8,
      color: scheme.primaryContainer,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () =>
                  ref.read(favoritesPanelExpandedProvider.notifier).toggle(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Favorites (${favorites.length})',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Icon(expanded ? Icons.expand_more : Icons.expand_less),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: expanded
                  ? SizedBox(
                      height: 64,
                      width: double.infinity,
                      child: favorites.isEmpty
                          ? const Center(
                              child: Text(
                                'No favorites yet. Tap a heart to add one!',
                              ),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              itemCount: favorites.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (_, i) {
                                final p = favorites[i];
                                return InputChip(
                                  avatar: CircleAvatar(
                                    backgroundImage: NetworkImage(p.imageUrl),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  label:
                                      Text(nicknames[p.id] ?? capitalize(p.name)),
                                  onDeleted: () => ref
                                      .read(favoritesProvider.notifier)
                                      .toggle(p.id),
                                );
                              },
                            ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}