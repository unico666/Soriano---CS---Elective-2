import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonListNotifier extends AsyncNotifier<List<Pokemon>> {
  @override
  Future<List<Pokemon>> build() => _request();

  Future<void> fetch() async {
    state = const AsyncLoading<List<Pokemon>>().copyWithPrevious(state);
    state = await AsyncValue.guard(_request);
  }

  Future<List<Pokemon>> _request() async {
    final listRes = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));
    if (listRes.statusCode != 200) {
      throw Exception('Server error (${listRes.statusCode})');
    }
    final results = jsonDecode(listRes.body)['results'] as List;

    return Future.wait(results.map((r) async {
      final res = await http.get(Uri.parse(r['url'] as String));
      if (res.statusCode != 200) {
        throw Exception('Failed to load ${r['name']} (${res.statusCode})');
      }
      return Pokemon.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    }));
  }
}

final pokemonListProvider =
    AsyncNotifierProvider<PokemonListNotifier, List<Pokemon>>(
  PokemonListNotifier.new,
);

class NicknamesNotifier extends Notifier<Map<int, String>> {
  @override
  Map<int, String> build() => {};

  void setNickname(int id, String nickname) {
    final value = nickname.trim();
    if (value.isEmpty) {
      removeNickname(id);
      return;
    }
    state = {...state, id: value};
  }

  void removeNickname(int id) {
    final copy = {...state};
    copy.remove(id);
    state = copy;
  }
}

final nicknamesProvider =
    NotifierProvider<NicknamesNotifier, Map<int, String>>(
  NicknamesNotifier.new,
);

class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => <int>{};

  void toggle(int id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, Set<int>>(FavoritesNotifier.new);

class PanelExpandedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

final favoritesPanelExpandedProvider =
    NotifierProvider<PanelExpandedNotifier, bool>(PanelExpandedNotifier.new);

final favoritePokemonProvider = Provider<List<Pokemon>>((ref) {
  final all = ref.watch(pokemonListProvider).valueOrNull ?? [];
  final favs = ref.watch(favoritesProvider);
  return all.where((p) => favs.contains(p.id)).toList();
});

class TypeFilterNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String type) => state = type;
  void clear() => state = null;
}

final typeFilterProvider =
    NotifierProvider<TypeFilterNotifier, String?>(TypeFilterNotifier.new);

final availableTypesProvider = Provider<List<String>>((ref) {
  final all = ref.watch(pokemonListProvider).valueOrNull ?? [];
  final types = <String>{for (final p in all) ...p.types};
  return types.toList()..sort();
});

final filteredPokemonProvider = Provider<List<Pokemon>>((ref) {
  final all = ref.watch(pokemonListProvider).valueOrNull ?? [];
  final type = ref.watch(typeFilterProvider);
  if (type == null) return all;
  return all.where((p) => p.types.contains(type)).toList();
});