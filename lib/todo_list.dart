import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(fontFamily: 'Sans-serif', useMaterial3: true),
      home: const OnboardingScreen(),
    );
  }
}

// --- 1. GET STARTED PAGE ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Placeholder for the illustration
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.task_alt,
                  size: 100,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "To-Do List",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Maecenas vehicula ligula mauris, sed efficitur tortor tincidunt vitae. Suspendisse mattis viverra purus.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskDashboard(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 55),
                  // SHAPE ERROR FIX EKHANE:
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. TASKS DASHBOARD PAGE ---
class TaskDashboard extends StatelessWidget {
  const TaskDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tasks",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Create your categorised task boards.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),

            _buildCategoryCard(
              "Inspiration",
              Colors.red[50]!,
              Colors.red[200]!,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TravelPlanScreen()),
                );
              },
              child: _buildCategoryCard(
                "Travel Plans",
                Colors.blue[50]!,
                Colors.blue[200]!,
              ),
            ),
            // --- 4. TRAVEL PLAN PAGE --- 
            class TravelPlanScreen extends StatefulWidget {
              const TravelPlanScreen({super.key});

              @override
              State<TravelPlanScreen> createState() => _TravelPlanScreenState();
            }

            class _TravelPlanScreenState extends State<TravelPlanScreen> {
              final TextEditingController _controller = TextEditingController();
              final List<_TravelPlace> _places = [
                _TravelPlace("Museum"),
                _TravelPlace("Park"),
                _TravelPlace("Cafe"),
                _TravelPlace("Library"),
              ];

              @override
              void dispose() {
                _controller.dispose();
                super.dispose();
              }

              @override
              Widget build(BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Travel Plans"),
                    backgroundColor: Colors.blue[50],
                    foregroundColor: Colors.blueAccent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.blueAccent),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Where will you go today?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  hintText: "Add a place...",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                final text = _controller.text.trim();
                                if (text.isNotEmpty) {
                                  setState(() {
                                    _places.add(_TravelPlace(text));
                                    _controller.clear();
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.separated(
                            itemCount: _places.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final place = _places[index];
                              return ListTile(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                tileColor: place.done ? Colors.blue[100] : Colors.blue[50],
                                leading: Checkbox(
                                  value: place.done,
                                  onChanged: (val) {
                                    setState(() {
                                      place.done = val ?? false;
                                    });
                                  },
                                  activeColor: Colors.blueAccent,
                                ),
                                title: Text(
                                  place.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: place.done ? TextDecoration.lineThrough : null,
                                    color: place.done ? Colors.blueAccent.withOpacity(0.5) : Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: place.done
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      )
                                    : null,
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

            class _TravelPlace {
              final String name;
              bool done;
              _TravelPlace(this.name, {this.done = false});
            }
            _buildCategoryCard("Work", Colors.yellow[50]!, Colors.yellow[200]!),

            // Interactive Groceries Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroceryDetailScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFA8E6CF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Groceries",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Text(
                      "3 of 9 Tasks",
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    _todoMiniRow("Avocados", false),
                    _todoMiniRow("Onions", false),
                    _todoMiniRow("Tomatoes", true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_filled, color: Colors.blueAccent),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCategoryCard(String title, Color bg, Color textCol) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(color: textCol, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _todoMiniRow(String text, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_box_outline_blank,
            size: 18,
            color: Colors.green.withOpacity(0.6),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.green[800],
              decoration: isDone ? TextDecoration.lineThrough : null,
              decorationColor: Colors.green[800],
            ),
          ),
        ],
      ),
    );
  }
}

// --- 3. GROCERIES DETAIL PAGE ---
class GroceryDetailScreen extends StatelessWidget {
  const GroceryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Avocados",
      "Onions",
      "Tomatoes",
      "Green Leaves",
      "Bread",
      "Vegetable Oil",
      "Mushrooms",
      "Brown Sugar",
      "BBQ Sauce",
      "Cheese",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Groceries",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Text("3 of 10 Tasks", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // Some items marked as completed based on your image
                  bool isStriked =
                      items[index] == "Tomatoes" ||
                      items[index] == "Green Leaves" ||
                      items[index] == "Mushrooms";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.green[300],
                        ),
                        const SizedBox(width: 15),
                        Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 16,
                            decoration: isStriked
                                ? TextDecoration.lineThrough
                                : null,
                            color: isStriked
                                ? Colors.green.withOpacity(0.5)
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.edit_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ""),
        ],
      ),
    );
  }
}
