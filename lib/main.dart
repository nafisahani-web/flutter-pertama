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
      title: 'Nafisahani App',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _slideAnimation = Tween(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [

                  // HEADER
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dashboard Nafisahani",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.notifications, color: Colors.white),
                      ],
                    ),
                  ),

                  // CARD SALDO
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Saldo", style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text(
                          "Rp 1.000.000",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CONTENT PUTIH
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Halo, Nafisahani 👋",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // MENU
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildMenu(Icons.send, "Kirim"),
                              buildMenu(Icons.add_card, "Top Up"),
                              buildMenu(Icons.history, "Riwayat"),
                              buildMenu(Icons.more_horiz, "Lainnya"),
                            ],
                          ),

                          const SizedBox(height: 30),

                          const Text(
                            "Aktivitas Terakhir",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          buildActivity("Transfer ke Budi", "- Rp 50.000"),
                          buildActivity("Top Up", "+ Rp 200.000"),
                          buildActivity("Bayar Makan", "- Rp 30.000"),

                          const Spacer(),

                          // BUTTON ANIMASI
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() => _scale = 0.95);
                            },
                            onTapUp: (_) {
                              setState(() => _scale = 1.0);
                              showMessage("Aksi berhasil, Nafisahani!");
                            },
                            onTapCancel: () {
                              setState(() => _scale = 1.0);
                            },
                            child: AnimatedScale(
                              scale: _scale,
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu(IconData icon, String label) {
    return GestureDetector(
      onTap: () => showMessage("$label dipilih"),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget buildActivity(String title, String amount) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.monetization_on, color: Colors.blue),
      title: Text(title),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}