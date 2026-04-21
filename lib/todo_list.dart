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
      theme: ThemeData(
        fontFamily: 'Sans-serif',
        useMaterial3: true, // Modern UI er jonno
      ),
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
                child: const Icon(Icons.task_alt_rounded, size: 100, color: Colors.blueAccent),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskDashboard()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 55),
                  // RoundedRectangleBorder correctly applied
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18)),
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: Colors.black))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tasks", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text("Create your categorised task boards.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            
            _buildCategoryCard("Inspiration", Colors.red[50]!, Colors.red[200]!),
            _buildCategoryCard("Travel Plans", Colors.blue[50]!, Colors.blue[200]!),
            _buildCategoryCard("Work", Colors.yellow[50]!, Colors.yellow[200]!),
            
            // Interactive Groceries Card
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GroceryDetailScreen()));
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
                    const Text("Groceries", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                    const Text("3 of 9 Tasks", style: TextStyle(color: Colors.green)),
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
            IconButton(icon: const Icon(Icons.home_filled, color: Colors.blueAccent), onPressed: () {}),
            IconButton(icon: const Icon(Icons.calendar_month_outlined), onPressed: () {}),
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
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
      child: Text(title, style: TextStyle(color: textCol, fontWeight: FontWeight.bold)),
    );
  }

  Widget _todoMiniRow(String text, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank, size: 18, color: Colors.green.withOpacity(0.6)),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(
            color: Colors.green[800], 
            decoration: isDone ? TextDecoration.lineThrough : null,
          )),
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
      "Avocados", "Onions", "Tomatoes", "Green Leaves", 
      "Bread", "Vegetable Oil", "Mushrooms", "Brown Sugar", 
      "BBQ Sauce", "Cheese"
    ];
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 20), 
          onPressed: () => Navigator.pop(context)
        ),
        actions: [IconButton(icon: const Icon(Icons.save_outlined, color: Colors.grey), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Groceries", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
            const Text("3 of 10 Tasks", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  bool isStriked = items[index] == "Tomatoes" || 
                                   items[index] == "Green Leaves" || 
                                   items[index] == "Mushrooms";
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_box_outline_blank, color: Colors.green[300]),
                        const SizedBox(width: 15),
                        Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 16,
                            decoration: isStriked ? TextDecoration.lineThrough : null,
                            color: isStriked ? Colors.green.withOpacity(0.5) : Colors.black87,
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
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.edit_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ""),
        ],
      ),
    );
  }
}