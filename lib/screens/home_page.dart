import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pokemon_providers.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/type_filter_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pokemonListProvider);
    final filtered = ref.watch(filteredPokemonProvider);
    final selectedType = ref.watch(typeFilterProvider);
    final notifier = ref.read(pokemonListProvider.notifier);

    Widget body;
    if (!async.hasValue) {
      if (async.hasError) {
        body = Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  'Could not load Pokémon.\n${async.error}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: notifier.fetch,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try again'),
                ),
              ],
            ),
          ),
        );
      } else {
        body = const Center(child: CircularProgressIndicator());
      }
    } else {
      body = RefreshIndicator(
        onRefresh: notifier.fetch,
        child: filtered.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No Pokémon found for this filter.')),
                ],
              )
            : GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filtered.length,
                itemBuilder: (_, i) => PokemonCard(pokemon: filtered[i]),
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        actions: [
          if (selectedType != null)
            IconButton(
              tooltip: 'Clear filter',
              icon: const Icon(Icons.filter_alt_off),
              onPressed: () => ref.read(typeFilterProvider.notifier).clear(),
            ),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: notifier.fetch,
          ),
        ],
      ),
      body: Column(
        children: [
          const TypeFilterBar(),
          if (async.isLoading && async.hasValue)
            const LinearProgressIndicator(),
          Expanded(child: body),
        ],
      ),
    );
  }
}