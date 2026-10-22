import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pokemon.dart';
import '../providers/pokemon_providers.dart';

class DetailPage extends ConsumerStatefulWidget {
  final Pokemon pokemon;
  const DetailPage({super.key, required this.pokemon});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(nicknamesProvider)[widget.pokemon.id];
    _controller = TextEditingController(text: existing ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    ref
        .read(nicknamesProvider.notifier)
        .setNickname(widget.pokemon.id, _controller.text);
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Nickname saved')));
  }

  void _remove() {
    ref.read(nicknamesProvider.notifier).removeNickname(widget.pokemon.id);
    _controller.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Nickname removed')));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.pokemon;
    final nickname = ref.watch(nicknamesProvider.select((n) => n[p.id]));
    final isFav =
        ref.watch(favoritesProvider.select((f) => f.contains(p.id)));

    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(p.name)),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () => ref.read(favoritesProvider.notifier).toggle(p.id),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 220,
            child: Image.network(
              p.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.catching_pokemon, size: 96),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '#${p.id}  ${capitalize(p.name)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          if (nickname != null)
            Center(
              child: Text(
                'Nickname: $nickname',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              for (final t in p.types) Chip(label: Text(capitalize(t))),
            ],
          ),
          const Divider(height: 32),
          TextField(
            controller: _controller,
            maxLength: 20,
            decoration: const InputDecoration(
              labelText: 'Nickname',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: nickname == null ? null : _remove,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Remove'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
