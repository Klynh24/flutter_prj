import 'package:flutter/material.dart';
import 'package:flutter01_login/main.dart';

class UserProfile {
  final String name;
  final String email;
  final String avatarUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}

class AccountScreen extends StatefulWidget {
  final UserProfile? user;

  const AccountScreen({super.key, this.user});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late UserProfile currentUser;

  @override
  void initState() {
    super.initState();
    currentUser =
        widget.user ??
        UserProfile(
          name: "Afsar Hossen",
          email: "Imshuvo97@gmail.com",
          avatarUrl: "assets/login_logo.png",
        );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Color(0xFF53B175);
    final Color lightGreenBg = Color(0xFFF2F3F2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: currentUser.avatarUrl.startsWith('http')
                              ? NetworkImage(currentUser.avatarUrl)
                                    as ImageProvider
                              : AssetImage(currentUser.avatarUrl),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        ),
                      ),
                      child: currentUser.avatarUrl.isEmpty
                          ? Icon(Icons.person, size: 40, color: Colors.grey)
                          : null,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                currentUser.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.edit_outlined,
                                color: primaryGreen,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentUser.email,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Divider(height: 1, color: Colors.grey[300]),

              _buildItem(Icons.shopping_bag_outlined, "Orders"),
              _buildItem(Icons.badge_outlined, "My Details"),
              _buildItem(Icons.location_on_outlined, "Delivery Address"),
              _buildItem(Icons.credit_card_outlined, "Payment Methods"),
              _buildItem(Icons.confirmation_number_outlined, "Promo Code"),
              _buildItem(Icons.notifications_none_outlined, "Notifications"),
              _buildItem(Icons.help_outline, "Help"),
              _buildItem(Icons.info_outline, "About"),

              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightGreenBg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout, color: primaryGreen),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.logout, color: Colors.transparent),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          leading: Icon(icon, color: Colors.black87, size: 28),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.black54,
          ),
          onTap: () {
            print("Clicked $title");
          },
        ),
        Divider(height: 1, color: Colors.grey[200], indent: 20, endIndent: 20),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.help_outline, size: 70, color: Colors.black87),
                SizedBox(height: 20),

                Text(
                  "Are you sure you want to\nLogout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6200EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "NO",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6200EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            "YES",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
