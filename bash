import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ShopBrowserApp());
}

class Product {
  final String name;
  final double price;
  final String description;
  final Color accent;
  final String imageUrl;

  const Product({
    required this.name,
    required this.price,
    required this.description,
    required this.accent,
    required this.imageUrl,
  });
}

const products = [
  Product(
    name: 'Carrier Inverter Split AC',
    price: 32999,
    description:
        'Energy-efficient inverter air conditioner designed for comfortable cooling and everyday home use.',
    accent: Color(0xFF2F80ED),
    imageUrl:
        'https://images.unsplash.com/photo-1718203862467-c33159fdc504?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Kolin Window Type AC',
    price: 18499,
    description:
        'A compact window-type air conditioner suitable for bedrooms, small offices, and other small spaces.',
    accent: Color(0xFF17A2B8),
    imageUrl:
        'https://images.unsplash.com/photo-1667983453881-4992fe86ab1b?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Condura Inverter AC',
    price: 29999,
    description:
        'Modern inverter air conditioner that provides efficient cooling while helping reduce energy consumption.',
    accent: Color(0xFF5B6EE1),
    imageUrl:
        'https://images.unsplash.com/photo-1757219525975-03b5984bc6e8?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Panasonic Premium AC',
    price: 35999,
    description:
        'Premium air conditioner with reliable cooling performance and a clean modern design.',
    accent: Color(0xFF00B8D9),
    imageUrl:
        'https://images.unsplash.com/photo-1759772238012-9d5ad59ae637?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'LG Dual Inverter AC',
    price: 38499,
    description:
        'Dual inverter air conditioner designed for fast cooling, quiet operation, and energy efficiency.',
    accent: Color(0xFF4C6FFF),
    imageUrl:
        'https://images.unsplash.com/photo-1665826254141-bfa10685e002?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Samsung Smart Split AC',
    price: 42999,
    description:
        'Smart split-type air conditioner with a modern design for comfortable home cooling.',
    accent: Color(0xFF0EA5E9),
    imageUrl:
        'https://images.unsplash.com/photo-1636409305041-3bd4fe738236?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Daikin Inverter AC',
    price: 40999,
    description:
        'High-performance inverter air conditioner known for durable build quality and consistent cooling.',
    accent: Color(0xFF1E88E5),
    imageUrl:
        'https://images.unsplash.com/photo-1762341123870-d706f257a12e?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'Sharp Split Type AC',
    price: 27999,
    description:
        'Reliable split-type air conditioner with straightforward controls, great for everyday household cooling.',
    accent: Color(0xFF29ABE2),
    imageUrl:
        'https://images.unsplash.com/photo-1698479603408-1a66a6d9e80f?w=800&q=80&auto=format&fit=crop',
  ),
  Product(
    name: 'TCL Smart Inverter AC',
    price: 25999,
    description:
        'Budget-friendly smart inverter air conditioner offering solid cooling power for the price.',
    accent: Color(0xFF3F8EFC),
    imageUrl:
        'https://images.unsplash.com/photo-1694675879520-ff32d348fb7f?w=800&q=80&auto=format&fit=crop',
  ),
];

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get subtotal => product.price * quantity;
}

class ShopBrowserApp extends StatefulWidget {
  const ShopBrowserApp({super.key});

  @override
  State<ShopBrowserApp> createState() => _ShopBrowserAppState();
}

class _ShopBrowserAppState extends State<ShopBrowserApp> {
  bool isDarkMode = false;
  final List<CartItem> cartItems = [];

  void toggleTheme() {
    setState(() => isDarkMode = !isDarkMode);
  }

  void addToCart(Product product) {
    setState(() {
      final existingItem = cartItems.where(
        (item) => item.product.name == product.name,
      );

      if (existingItem.isNotEmpty) {
        existingItem.first.quantity++;
      } else {
        cartItems.add(CartItem(product: product));
      }
    });
  }

  void increaseQuantity(CartItem item) {
    setState(() => item.quantity++);
  }

  void decreaseQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        cartItems.remove(item);
      }
    });
  }

  double get cartTotal {
    double total = 0;
    for (final item in cartItems) {
      total += item.subtotal;
    }
    return total;
  }

  int get cartCount {
    int count = 0;
    for (final item in cartItems) {
      count += item.quantity;
    }
    return count;
  }

  void clearCart() {
    setState(() => cartItems.clear());
  }

  static const _lightBg = Color(0xFFF1F6FC);
  static const _lightCard = Color(0xFFFFFFFF);
  static const _darkBg = Color(0xFF15202B);
  static const _darkCard = Color(0xFF1E2C3A);
  static const _brandBlue = Color(0xFF3B82C4);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mainet Aircon Shop',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brandBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: _lightBg,
        cardTheme: CardThemeData(
          elevation: 3,
          margin: EdgeInsets.zero,
          color: _lightCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _lightBg,
          foregroundColor: Color(0xFF1B2A38),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brandBlue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: _darkBg,
        cardTheme: CardThemeData(
          elevation: 3,
          margin: EdgeInsets.zero,
          color: _darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkBg,
          foregroundColor: Color(0xFFEAF2FB),
          elevation: 0,
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(cartCount: cartCount),
          ),
          GoRoute(
            path: '/details',
            builder: (context, state) {
              final product = state.extra as Product;
              return ProductDetailPage(
                product: product,
                onAddToCart: addToCart,
              );
            },
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => CartPage(
              cartItems: cartItems,
              cartTotal: cartTotal,
              onIncrease: increaseQuantity,
              onDecrease: decreaseQuantity,
              onCheckout: () {
                if (cartItems.isNotEmpty) {
                  context.push('/checkout');
                }
              },
            ),
          ),
          GoRoute(
            path: '/checkout',
            builder: (context, state) => CheckoutPage(
              cartItems: cartItems,
              cartTotal: cartTotal,
              onDone: () {
                clearCart();
                context.go('/');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final Color accent;
  final double width;
  final double height;
  final double borderRadius;
  final bool detailed;

  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.accent,
    required this.width,
    required this.height,
    this.borderRadius = 16,
    this.detailed = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: accent,
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                            (progress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [accent.withOpacity(0.16), Colors.transparent],
            ),
          ),
          child: Center(
            child: AirconIllustration(
              accent: accent,
              size: width * 0.8,
              detailed: detailed,
            ),
          ),
        ),
      ),
    );
  }
}

class AirconIllustration extends StatelessWidget {
  final Color accent;
  final double size;
  final bool detailed;

  const AirconIllustration({
    super.key,
    required this.accent,
    this.size = 120,
    this.detailed = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.72,
      child: CustomPaint(
        painter: _AirconPainter(accent: accent, detailed: detailed),
      ),
    );
  }
}

class _AirconPainter extends CustomPainter {
  final Color accent;
  final bool detailed;

  _AirconPainter({required this.accent, required this.detailed});

  void _drawSpark(Canvas canvas, Offset center, double radius, Paint paint) {
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius * 0.7, center.dy - radius * 0.7),
      Offset(center.dx + radius * 0.7, center.dy + radius * 0.7),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius * 0.7, center.dy + radius * 0.7),
      Offset(center.dx + radius * 0.7, center.dy - radius * 0.7),
      paint,
    );
  }

  RRect _bodyShape(Size size) {
    final bodyRect = Rect.fromLTWH(
      size.width * 0.22,
      size.height * 0.16,
      size.width * 0.74,
      size.height * 0.66,
    );
    return RRect.fromRectAndRadius(
      bodyRect,
      Radius.circular(size.height * 0.26),
    );
  }

  void _drawShadow(Canvas canvas, Size size, RRect body) {
    if (!detailed) return;
    final shadowOffset = Offset(0, size.height * 0.045);
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.14);
    canvas.drawRRect(body.shift(shadowOffset), shadowPaint);
  }

  void _drawMountBar(Canvas canvas, Size size) {
    if (!detailed) return;
    final mountBarPaint = Paint()
      ..color = accent.withOpacity(0.18)
      ..strokeWidth = size.height * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.34, size.height * 0.10),
      Offset(size.width * 0.86, size.height * 0.10),
      mountBarPaint,
    );
  }

  void _drawBody(Canvas canvas, RRect body) {
    final bodyRect = body.outerRect;

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Color(0xFFE7ECF3)],
      ).createShader(bodyRect);
    canvas.drawRRect(body, fillPaint);

    final outlinePaint = Paint()
      ..color = accent.withOpacity(0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = bodyRect.width * 0.014;
    canvas.drawRRect(body, outlinePaint);
  }

  void _drawGlossHighlight(Canvas canvas, Size size, RRect body) {
    if (!detailed) return;
    final highlightPaint = Paint()..color = Colors.white.withOpacity(0.55);
    canvas.drawOval(
      Rect.fromLTWH(
        body.left + size.width * 0.05,
        body.top + size.height * 0.06,
        size.width * 0.22,
        size.height * 0.10,
      ),
      highlightPaint,
    );
  }

  void _drawControlPanel(Canvas canvas, Size size) {
    final panelRect = Rect.fromLTWH(
      size.width * 0.72,
      size.height * 0.24,
      size.width * 0.18,
      size.height * 0.13,
    );

    final panelPaint = Paint()..color = const Color(0xFF223047);
    canvas.drawRRect(
      RRect.fromRectAndRadius(panelRect, Radius.circular(size.height * 0.04)),
      panelPaint,
    );

    final indicatorPaint = Paint()..color = accent;
    canvas.drawCircle(panelRect.center, size.height * 0.03, indicatorPaint);
  }

  void _drawVents(Canvas canvas, Size size) {
    final ventPaint = Paint()
      ..color = accent
      ..strokeWidth = size.height * 0.065
      ..strokeCap = StrokeCap.round;

    final ventYPositions = [
      size.height * 0.58,
      size.height * 0.69,
      size.height * 0.80,
    ];
    final ventLengthFractions = [0.58, 0.46, 0.34];

    for (var i = 0; i < ventYPositions.length; i++) {
      canvas.drawLine(
        Offset(size.width * 0.30, ventYPositions[i]),
        Offset(size.width * (0.30 + ventLengthFractions[i]), ventYPositions[i]),
        ventPaint,
      );
    }
  }

  void _drawBreezeLines(Canvas canvas, Size size) {
    final strongBreezePaint = Paint()
      ..color = accent.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.016
      ..strokeCap = StrokeCap.round;

    final strongBreezePath = Path()
      ..moveTo(size.width * 0.28, size.height * 0.50)
      ..quadraticBezierTo(
        size.width * 0.12,
        size.height * 0.44,
        size.width * 0.08,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.04,
        size.height * 0.64,
        size.width * 0.12,
        size.height * 0.68,
      );
    canvas.drawPath(strongBreezePath, strongBreezePaint);

    final faintBreezePaint = Paint()
      ..color = accent.withOpacity(0.32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.014
      ..strokeCap = StrokeCap.round;

    final faintBreezePath = Path()
      ..moveTo(size.width * 0.28, size.height * 0.70)
      ..quadraticBezierTo(
        size.width * 0.14,
        size.height * 0.66,
        size.width * 0.10,
        size.height * 0.78,
      )
      ..quadraticBezierTo(
        size.width * 0.06,
        size.height * 0.86,
        size.width * 0.14,
        size.height * 0.90,
      );
    canvas.drawPath(faintBreezePath, faintBreezePaint);
  }

  void _drawCoolSparkle(Canvas canvas, Size size) {
    final sparkPaint = Paint()
      ..color = accent.withOpacity(0.6)
      ..strokeWidth = size.width * 0.013
      ..strokeCap = StrokeCap.round;
    _drawSpark(
      canvas,
      Offset(size.width * 0.06, size.height * 0.36),
      size.height * 0.055,
      sparkPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final body = _bodyShape(size);

    _drawShadow(canvas, size, body);
    _drawMountBar(canvas, size);
    _drawBody(canvas, body);
    _drawGlossHighlight(canvas, size, body);
    _drawControlPanel(canvas, size);
    _drawVents(canvas, size);
    _drawBreezeLines(canvas, size);
    _drawCoolSparkle(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _AirconPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.detailed != detailed;
  }
}

class HomePage extends StatelessWidget {
  final int cartCount;

  const HomePage({super.key, required this.cartCount});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AirconIllustration(
              accent: scheme.primary,
              size: 34,
              detailed: true,
            ),
            const SizedBox(width: 10),
            const Text(
              'Mainet Aircon Shop',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final appState = context
                  .findAncestorStateOfType<_ShopBrowserAppState>();
              appState?.toggleTheme();
            },
          ),
          Stack(
            children: [
              IconButton(
                tooltip: 'Shopping Cart',
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.push('/cart'),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1E2C3A), const Color(0xFF15202B)]
                      : [const Color(0xFFDCEBFB), const Color(0xFFF3F8FE)],
                ),
              ),
              child: Row(
                children: [
                  AirconIllustration(
                    accent: scheme.primary,
                    size: 92,
                    detailed: true,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Beat the Heat',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Shop cool, comfortable air conditioners for every room in your home.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Featured Air Conditioners',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Pick the right unit and cool your space today.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth < 600 ? 2 : 3;
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/details', extra: product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ProductImage(
                    imageUrl: product.imageUrl,
                    accent: product.accent,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    borderRadius: 0,
                    detailed: true,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₱${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: product.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: product.accent,
                      ),
                      onPressed: () {
                        final appState = context
                            .findAncestorStateOfType<_ShopBrowserAppState>();
                        appState?.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Air Conditioner Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(
                  imageUrl: product.imageUrl,
                  accent: product.accent,
                  width: double.infinity,
                  height: 300,
                  borderRadius: 20,
                  detailed: true,
                ),
                const SizedBox(height: 20),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '₱${product.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: product.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  product.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: product.accent,
                    ),
                    onPressed: () {
                      onAddToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product added to cart')),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => context.push('/cart'),
                    child: const Text('View Cart'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double cartTotal;
  final Function(CartItem) onIncrease;
  final Function(CartItem) onDecrease;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.cartTotal,
    required this.onIncrease,
    required this.onDecrease,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80),
                  SizedBox(height: 15),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Add an air conditioner to get started.'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ProductImage(
                                imageUrl: item.product.imageUrl,
                                accent: item.product.accent,
                                width: 90,
                                height: 90,
                                borderRadius: 14,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '₱${item.product.price.toStringAsFixed(0)}',
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => onDecrease(item),
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => onIncrease(item),
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '₱${item.subtotal.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₱${cartTotal.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: onCheckout,
                          child: const Text('Proceed to Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double cartTotal;
  final VoidCallback onDone;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.cartTotal,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.check_circle_outline, size: 90),
            const SizedBox(height: 15),
            const Text(
              'Order Confirmed!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Thank you for purchasing from Mainet Aircon Shop.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: ProductImage(
                        imageUrl: item.product.imageUrl,
                        accent: item.product.accent,
                        width: 48,
                        height: 48,
                        borderRadius: 10,
                      ),
                      title: Text(item.product.name),
                      subtitle: Text(
                        '${item.quantity} × ₱${item.product.price.toStringAsFixed(0)}',
                      ),
                      trailing: Text(
                        '₱${item.subtotal.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₱${cartTotal.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onDone,
                child: const Text('Back to Shop'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

