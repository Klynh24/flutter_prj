import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_cubit.dart';
import 'login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.shopping_bag_outlined, 'text': 'Orders'},
    {'icon': Icons.person_outline, 'text': 'My Details'},
    {'icon': Icons.location_on_outlined, 'text': 'Delivery Address'},
    {'icon': Icons.credit_card, 'text': 'Payment Methods'},
    {'icon': Icons.confirmation_number_outlined, 'text': 'Promo Cord'},
    {'icon': Icons.notifications_none, 'text': 'Notifecations'},
    {'icon': Icons.help_outline, 'text': 'Help'},
    {'icon': Icons.info_outline, 'text': 'About'},
  ];

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Icon(
                  Icons.question_mark,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Are you sure you want to\nLogout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6200EE), // Màu tím đậm
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "NO",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Nút YES
                  SizedBox(
                    width: 100,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6200EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();

                        context.read<AuthCubit>().logout();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "YES",
                        style: TextStyle(
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 65,
                      width: 65,
                      color: Colors.grey.shade200,
                      child: Image.asset(
                        'assets/images/user_avatar.png',
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Text(
                                  state.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.green.shade700,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return Text(
                              state.email,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(thickness: 1, color: Color(0xFFE2E2E2)),
            Column(
              children: menuItems.map((item) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 2,
                      ),
                      leading: Icon(
                        item['icon'],
                        color: Colors.black87,
                        size: 28,
                      ),
                      title: Text(
                        item['text'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.black87,
                      ),
                      onTap: () {},
                    ),
                    const Divider(thickness: 1, color: Color(0xFFE2E2E2)),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  _showLogoutDialog(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F2),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(width: 25),
                      Icon(Icons.logout, color: Color(0xFF53B175)),
                      Expanded(
                        child: Text(
                          "Log Out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF53B175),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: 45),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
