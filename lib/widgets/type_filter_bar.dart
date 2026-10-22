import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../providers/pokemon_providers.dart';

class TypeFilterBar extends ConsumerWidget {
  const TypeFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(availableTypesProvider);
    final selected = ref.watch(typeFilterProvider);
    if (types.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        children: [
          // "All" chip = clear filter
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ChoiceChip(
              label: const Text('All'),
              selected: selected == null,
              onSelected: (_) => ref.read(typeFilterProvider.notifier).clear(),
            ),
          ),
          for (final t in types)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ChoiceChip(
                label: Text(capitalize(t)),
                selected: selected == t,
                onSelected: (isOn) {
                  final n = ref.read(typeFilterProvider.notifier);
                  isOn ? n.select(t) : n.clear();
                },
              ),
            ),
        ],
      ),
    );
  }
}