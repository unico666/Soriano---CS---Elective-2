import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    'Dashboard',
    'Settings',
    'About',
    'Logout',
  ];

  final List<IconData> menuIcons = [
    Icons.dashboard,
    Icons.settings,
    Icons.info,
    Icons.logout,
  ];

  final List<String> labels = [
    'Total Sales',
    'New Orders',
    'Visitors',
    'Conversion',
  ];

  final List<String> values = [
    '\$12,480',
    '164',
    '3,204',
    '4.8%',
  ];

  final List<String> activities = [
    'Recent Activity #1',
    'Recent Activity #2',
    'Recent Activity #3',
    'Recent Activity #4',
    'Recent Activity #5',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        if (width >= 1024) {
          return desktopLayout();
        } else if (width >= 600) {
          return tabletLayout();
        } else {
          return mobileLayout();
        }
      },
    );
  }

  // ---------------- MOBILE ----------------

  Widget mobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 50,
              ),
            ),

            for (int i = 0; i < menuItems.length; i++)
              ListTile(
                leading: Icon(menuIcons[i]),
                title: Text(menuItems[i]),
                selected: selectedIndex == i,
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                  });

                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),

      body: dashboardBody(2),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex > 2 ? 0 : selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }

  // ---------------- TABLET ----------------

  Widget tabletLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 50,
              ),
            ),

            for (int i = 0; i < menuItems.length; i++)
              ListTile(
                leading: Icon(menuIcons[i]),
                title: Text(menuItems[i]),
                selected: selectedIndex == i,
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                  });

                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),

      body: dashboardBody(4),
    );
  }

  // ---------------- DESKTOP ----------------

  Widget desktopLayout() {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [

            // Sidebar
            Container(
              width: 220,
              color: Colors.grey[200],

              child: Column(
                children: [

                  const SizedBox(height: 30),

                  const Icon(
                    Icons.favorite,
                    size: 50,
                  ),

                  const SizedBox(height: 30),

                  for (int i = 0; i < menuItems.length; i++)
                    ListTile(
                      leading: Icon(menuIcons[i]),
                      title: Text(menuItems[i]),
                      selected: selectedIndex == i,

                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                    ),
                ],
              ),
            ),

            // Dashboard
            Expanded(
              flex: 3,
              child: dashboardBody(4),
            ),

            // Quick Actions
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('New Report'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- DASHBOARD BODY ----------------

  Widget dashboardBody(int columns) {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: [

        // Statistic cards
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: labels.length,

          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),

          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(
                    values[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    labels[index],
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // Recent activities
        for (String activity in activities)
          Container(
            height: 64,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            alignment: Alignment.centerLeft,

            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),

            child: Text(activity),
          ),
      ],
    );
  }
}
