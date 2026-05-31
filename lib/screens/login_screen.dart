import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  // Tasarım renk paleti
  final Color primaryGreen = const Color(0xFF06412D);
  final Color lightGreen = const Color(0xFF10B981);

  Future<void> _login() async {
    setState(() => _isLoading = true);
    // Backend testi için basit simülasyon, burayı kendi ApiService'ine bağla
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka Plan Alt Gradient/Dalga Efekti (Görseldeki alt kısım)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    lightGreen.withOpacity(0.2),
                    lightGreen.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Logo ve Başlık
                  Image.network(
                    'https://i.imgur.com/your_logo_here.png',
                    height: 100,
                    errorBuilder:
                        (c, e, s) => Icon(
                          Icons.insert_chart_rounded,
                          size: 100,
                          color: lightGreen,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Finansio",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Text(
                    "Finansını Yönet, Geleceğini Büyüt.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // E-posta Input
                  _buildTextField(
                    controller: _emailController,
                    hint: "E-posta adresiniz",
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),

                  // Şifre Input
                  _buildTextField(
                    controller: _passwordController,
                    hint: "Şifreniz",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  // Şifremi Unuttum
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Şifremi Unuttum?",
                        style: TextStyle(
                          color: primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Giriş Yap Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                "Giriş Yap",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text("veya", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),

                  // Sosyal Giriş Butonları
                  _socialButton(
                    "Google ile Devam Et",
                    "https://img.icons8.com/color/48/google-logo.png",
                  ),
                  const SizedBox(height: 12),
                  _socialButton(
                    "Apple ile Devam Et",
                    "https://img.icons8.com/ios-filled/50/apple-logo.png",
                  ),

                  const SizedBox(height: 32),

                  // Kayıt Ol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hesabın yok mu? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            color: lightGreen,
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
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _socialButton(String text, String iconUrl) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(iconUrl, height: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
