import 'package:flutter/material.dart';

// Gunakan file app_constants.dart yang sudah dibuat
// ignore: unused_import
import 'config/app_constants.dart';

void main() {
  runApp(const NexoraApp());
}

class NexoraApp extends StatelessWidget {
  const NexoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEXORA',
      theme: _buildTheme(),
      home: const SplashScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        primary: const Color(0xFF6C63FF),
        secondary: const Color(0xFF00D4FF),
        tertiary: const Color(0xFFFFB800),
        surface: const Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFF),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFF8FAFF),
        titleTextStyle: TextStyle(
          color: Color(0xFF1A1A2E),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Color(0xFF1A1A2E)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF6C757D)),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
    );
  }
}

// ==================== SPLASH SCREEN ====================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan animasi scale dan fade
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Title dengan fade animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    "NEXORA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tagline dengan fade animation bertahap
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    "Explore • Learn • Grow",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Loading indicator
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withValues(alpha: 0.8),
                      ),
                      strokeWidth: 3,
                    ),
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

// ==================== LOGIN SCREEN ====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFF), Color(0xFFE8F0FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Ilustrasi / Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    "NEXORA",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    "Platform Pembelajaran AI untuk Anak",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6C757D),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Input dengan Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: "Email Anak",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Input dengan Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: Icon(Icons.visibility_off_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MoodLearningPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sign up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== MOOD LEARNING PAGE ====================
class MoodLearningPage extends StatefulWidget {
  const MoodLearningPage({super.key});

  @override
  State<MoodLearningPage> createState() => _MoodLearningPageState();
}

class _MoodLearningPageState extends State<MoodLearningPage>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mood Learning"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Step Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: index <= currentStep
                          ? const LinearGradient(
                              colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                            )
                          : null,
                      color: index > currentStep
                          ? const Color(0xFFE0E0E0)
                          : null,
                      boxShadow: index <= currentStep
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF6C63FF,
                                ).withValues(alpha: 0.3),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: index <= currentStep
                              ? Colors.white
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Face Scan Icon dengan animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 40),

              // Title
              const Text(
                "Mood Terdeteksi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Happy & Ready To Learn 😊",
                style: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
              ),
              const SizedBox(height: 32),

              // Progress Bar dengan animation
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: _progressAnimation.value,
                          minHeight: 12,
                          backgroundColor: const Color(0xFFE0E0E0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${(_progressAnimation.value * 100).toStringAsFixed(0)}% Complete",
                        style: const TextStyle(
                          color: Color(0xFF6C757D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Avatar Preview Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Avatar Generated",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00D4FF), Color(0xFF6C63FF)],
                          ),
                        ),
                        child: const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Explorer Mode",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C757D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentStep < 3) {
                        currentStep++;
                        _progressController.reset();
                        _progressController.forward();
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainPage()),
                        );
                      }
                    });
                  },
                  child: Text(
                    currentStep < 3 ? "Lanjut" : "Masuk ke Dashboard",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== MAIN PAGE (dengan Bottom Navigation) ====================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    NexflixPage(),
    NexWorldPage(),
    NexCardPage(),
    ProfilePage(),
  ];

  final List<String> pageLabels = [
    "Dashboard",
    "NexFlix",
    "NexWorld",
    "NexCard",
    "Profil",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNexBotPanel(),
        label: const Text("NexBot"),
        icon: const Icon(Icons.smart_toy),
        backgroundColor: const Color(0xFF6C63FF),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        backgroundColor: Colors.white,
        elevation: 8,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outlined),
            selectedIcon: Icon(Icons.play_circle_filled),
            label: "NexFlix",
          ),
          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: "NexWorld",
          ),
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style),
            label: "NexCard",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  void _showNexBotPanel() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFF), Color(0xFFE8F0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header dengan avatar
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                        ),
                      ),
                      child: const Icon(Icons.smart_toy, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "NexBot AI",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Assistant Pembelajaran Anda",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6C757D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Greeting
                const Text(
                  "Halo Explorer 👋",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Berdasarkan Mood Learning Anda hari ini, berikut rekomendasi pembelajaran yang cocok:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C757D),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Recommendations
                _buildRecommendationCard(
                  "📚 Pecahan Matematika",
                  "Pelajaran dasar tentang pecahan",
                  const Color(0xFF6C63FF),
                ),
                const SizedBox(height: 12),
                _buildRecommendationCard(
                  "🎯 Quiz Interaktif",
                  "Uji pemahaman dengan soal seru",
                  const Color(0xFF00D4FF),
                ),
                const SizedBox(height: 12),
                _buildRecommendationCard(
                  "🚀 Challenge Harian",
                  "Taklukkan challenge dan raih XP",
                  const Color(0xFFFFB800),
                ),
                const SizedBox(height: 24),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Mulai Belajar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String subtitle, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: color,
            size: 16,
          ),
        ),
      ),
    );
  }
}

// ==================== DASHBOARD PAGE ====================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan avatar dan level
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "👋 Selamat Datang!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Restu Hendra",
                    style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
                  ),
                ],
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Level & XP Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Level 5",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Explorer",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Total XP",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Text(
                  "1250 / 1500",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: 1250 / 1500,
                    minHeight: 8,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Learning Paths
          const Text(
            "Materi Pembelajaran",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 16),

          _buildMaterialCard(
            "📚 Pecahan Matematika",
            "Pelajaran singkat 2 menit",
            "45%",
            const Color(0xFF6C63FF),
          ),
          const SizedBox(height: 12),
          _buildMaterialCard(
            "🌍 Tata Surya",
            "Video pembelajaran interaktif",
            "75%",
            const Color(0xFF00D4FF),
          ),
          const SizedBox(height: 12),
          _buildMaterialCard(
            "🎯 Quiz Dasar",
            "Uji kemampuan Anda",
            "0%",
            const Color(0xFFFFB800),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialCard(
    String title,
    String subtitle,
    String progress,
    Color color,
  ) {
    double progressValue = double.parse(progress.replaceAll('%', '')) / 100;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6C757D),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    progress,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 6,
                backgroundColor: color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== NEXFLIX PAGE ====================
class NexflixPage extends StatelessWidget {
  const NexflixPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> materials = [
      {"title": "Pecahan Matematika", "duration": "2 min", "rating": "4.8"},
      {"title": "Tata Surya", "duration": "5 min", "rating": "4.9"},
      {"title": "Photosynthesis", "duration": "3 min", "rating": "4.7"},
      {"title": "Sejarah Indonesia", "duration": "4 min", "rating": "4.6"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("NexFlix Edu")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎬 Konten Pembelajaran",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Pilih dan tonton materi pembelajaran favorit Anda",
              style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: materials.length,
                itemBuilder: (context, index) {
                  final item = materials[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildNexflixCard(
                      item["title"]!,
                      item["duration"]!,
                      item["rating"]!,
                      index,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "📺 Tren Saat Ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),
            _buildTrendingCard("🔥 Pecahan Matematika", "30k views"),
            const SizedBox(height: 12),
            _buildTrendingCard("⭐ Quiz Seru", "25k views"),
            const SizedBox(height: 12),
            _buildTrendingCard("🚀 Challenge Harian", "18k views"),
          ],
        ),
      ),
    );
  }

  Widget _buildNexflixCard(
    String title,
    String duration,
    String rating,
    int index,
  ) {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFF00D4FF),
      const Color(0xFFFFB800),
      const Color(0xFF4CAF50),
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [colors[index], colors[index].withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: colors[index].withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingCard(String title, String views) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          views,
          style: const TextStyle(
            color: Color(0xFF6C63FF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

// ==================== NEXWORLD PAGE ====================
class NexWorldPage extends StatelessWidget {
  const NexWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> worlds = [
      {
        "name": "MathLand",
        "icon": Icons.calculate,
        "progress": 75,
        "difficulty": "Medium",
        "color": const Color(0xFF6C63FF),
      },
      {
        "name": "ScienceVerse",
        "icon": Icons.science,
        "progress": 45,
        "difficulty": "Hard",
        "color": const Color(0xFF00D4FF),
      },
      {
        "name": "Language Kingdom",
        "icon": Icons.language,
        "progress": 60,
        "difficulty": "Medium",
        "color": const Color(0xFFFFB800),
      },
      {
        "name": "Creativity Island",
        "icon": Icons.palette,
        "progress": 30,
        "difficulty": "Easy",
        "color": const Color(0xFF4CAF50),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("NexWorld")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🌍 Jelajahi Dunia Pembelajaran",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Pilih dunia dan mulai petualangan belajar Anda",
              style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(worlds.length, (index) {
                final world = worlds[index];
                return _buildWorldCard(
                  world["name"] as String,
                  world["icon"] as IconData,
                  world["progress"] as int,
                  world["difficulty"] as String,
                  world["color"] as Color,
                );
              }),
            ),
            const SizedBox(height: 32),
            const Text(
              "🎯 Misi Aktif",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 16),
            _buildMissionCard(
              "Selesaikan 3 soal pecahan",
              "2/3",
              const Color(0xFF6C63FF),
              true,
            ),
            const SizedBox(height: 12),
            _buildMissionCard(
              "Kumpulkan 100 XP",
              "75/100",
              const Color(0xFF00D4FF),
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldCard(
    String name,
    IconData icon,
    int progress,
    String difficulty,
    Color color,
  ) {
    final difficultyColor = difficulty == "Easy"
        ? Colors.green
        : difficulty == "Medium"
        ? Colors.orange
        : Colors.red;

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: difficultyColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: difficultyColor),
                        ),
                        child: Text(
                          difficulty,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: difficultyColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Center(
                          child: Text(
                            "$progress%",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionCard(
    String title,
    String progress,
    Color color,
    bool completed,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    progress,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed ? color : color.withValues(alpha: 0.1),
              ),
              child: Icon(
                completed ? Icons.check : Icons.flag_outlined,
                color: completed ? Colors.white : color,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== NEXCARD PAGE ====================
class NexCardPage extends StatelessWidget {
  const NexCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      {"name": "🔥 Fire Master", "rarity": "Epic", "xp": 150},
      {"name": "🌍 Explorer", "rarity": "Rare", "xp": 100},
      {"name": "⭐ Quiz Champion", "rarity": "Legendary", "xp": 250},
      {"name": "🚀 Fast Learner", "rarity": "Epic", "xp": 150},
      {"name": "💎 Gem Collector", "rarity": "Rare", "xp": 100},
      {"name": "👑 King of Knowledge", "rarity": "Legendary", "xp": 250},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("NexCard")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🃏 Koleksi Kartu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Kumpulkan kartu langka dan legendary",
              style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(cards.length, (index) {
                final card = cards[index];
                return _buildNexCard(
                  card["name"] as String,
                  card["rarity"] as String,
                  int.parse(card["xp"]!.toString()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNexCard(String name, String rarity, int xp) {
    final rarityGradient = _getRarityGradient(rarity);
    final rarityColor = _getRarityColor(rarity);

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: rarityGradient,
            boxShadow: [
              BoxShadow(
                color: rarityColor.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 32),
              ),
              Column(
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      rarity,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "+$xp XP",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.favorite, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient _getRarityGradient(String rarity) {
    switch (rarity) {
      case "Common":
        return const LinearGradient(
          colors: [Color(0xFF95989A), Color(0xFFB0B3B5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "Rare":
        return const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF6BA3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "Epic":
        return const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFB088FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "Legendary":
        return const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFED4E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return const Color(0xFF95989A);
      case "Rare":
        return const Color(0xFF4A90E2);
      case "Epic":
        return const Color(0xFF8B5CF6);
      case "Legendary":
        return const Color(0xFFFFD700);
      default:
        return const Color(0xFF6C63FF);
    }
  }
}

// ==================== ACHIEVEMENT PAGE ====================
class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        "name": "🏆 First Step",
        "description": "Selesaikan pelajaran pertama",
        "locked": false,
      },
      {
        "name": "📚 Book Lover",
        "description": "Selesaikan 10 pelajaran",
        "locked": false,
      },
      {
        "name": "⚡ Speed Learner",
        "description": "Selesaikan 5 kuis dalam sehari",
        "locked": true,
      },
      {
        "name": "🌟 Star Collector",
        "description": "Kumpulkan 100 bintang",
        "locked": false,
      },
      {
        "name": "🎯 Perfect Score",
        "description": "Dapatkan 100% di sebuah kuis",
        "locked": true,
      },
      {
        "name": "🚀 Rocket Master",
        "description": "Raih 1000 XP",
        "locked": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Achievement")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🏅 Pencapaian Anda",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Raih achievement dan unlock badge eksklusif",
              style: TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
            ),
            const SizedBox(height: 24),

            // Trophy Showcase
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFED4E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Achievement",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "4 / 6",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFF1A1A2E),
                    size: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Filter Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Unlocked", "Locked"].map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(filter),
                      selected: selectedFilter == filter,
                      onSelected: (selected) {
                        setState(() => selectedFilter = filter);
                      },
                      selectedColor: const Color(0xFF6C63FF),
                      backgroundColor: const Color(0xFFE0E0E0),
                      labelStyle: TextStyle(
                        color: selectedFilter == filter
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Achievement Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(achievements.length, (index) {
                final achievement = achievements[index];
                final locked = achievement["locked"] as bool;

                if (selectedFilter == "Unlocked" && locked) {
                  return const SizedBox.shrink();
                } else if (selectedFilter == "Locked" && !locked) {
                  return const SizedBox.shrink();
                }

                return _buildAchievementCard(
                  achievement["name"] as String,
                  achievement["description"] as String,
                  locked,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(String name, String description, bool locked) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: locked ? Colors.grey[300] : Colors.white,
          border: Border.all(
            color: locked ? Colors.grey : const Color(0xFF6C63FF),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: locked
                        ? Colors.grey
                        : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  ),
                ),
                Text(name.split(" ")[0], style: const TextStyle(fontSize: 32)),
                if (locked)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Color(0xFF6C757D)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PROFILE PAGE ====================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // Avatar dengan border gradient
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 50),
          ),
          const SizedBox(height: 20),

          // Name
          const Text(
            "Restu Hendra",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),

          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Level 5 Explorer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("1250", "Total XP", const Color(0xFF6C63FF)),
                    _buildStatItem("4", "Achievement", const Color(0xFF00D4FF)),
                    _buildStatItem("8", "NexCard", const Color(0xFFFFB800)),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  "Learning Progress",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: 0.68,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFE0E0E0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF6C63FF),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "68% Completed",
                  style: TextStyle(fontSize: 12, color: Color(0xFF6C757D)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Menu Items
          _buildProfileMenuItem(
            Icons.edit,
            "Edit Profil",
            const Color(0xFF6C63FF),
            () {},
          ),
          const SizedBox(height: 12),
          _buildProfileMenuItem(
            Icons.settings,
            "Pengaturan",
            const Color(0xFF00D4FF),
            () {},
          ),
          const SizedBox(height: 12),
          _buildProfileMenuItem(
            Icons.info,
            "Tentang NEXORA",
            const Color(0xFFFFB800),
            () {},
          ),
          const SizedBox(height: 12),
          _buildProfileMenuItem(Icons.logout, "Logout", Colors.red, () {}),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF6C757D)),
        ),
      ],
    );
  }

  Widget _buildProfileMenuItem(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 24),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
