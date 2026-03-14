import 'package:flutter/material.dart';
import '../widgets/navigation_layout.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {

  // Metric Card
  Widget metricCard(String title, String value, IconData icon, Color color) {

    return Container(

      width: 160,

      margin: const EdgeInsets.only(right: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.withOpacity(.15),
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Row(

        children: [

          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, color: color, size: 18),
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),

              Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    );
  }

  // Attendance Chart
  Widget attendanceChart() {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.withOpacity(.15),
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Attendance Overview",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          LinearProgressIndicator(
            value: 0.92,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 8),

          const Text("92% Attendance this month"),
        ],
      ),
    );
  }

  // Announcement Card
  Widget announcement(String title, String subtitle) {

    return Card(

      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(

        leading: const Icon(Icons.campaign),

        title: Text(title),

        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return NavigationLayout(

      body: Scaffold(

        body: SafeArea(

          child: ListView(

            padding: const EdgeInsets.all(16),

            children: [

              // HEADER
              Container(

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff5B67F2),
                      Color(0xff8E9CFF)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: const [

                    Text(
                      "Welcome Back 👋",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Ayesha khan",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Here is your dashboard overview",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Quick Metrics",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // HORIZONTAL METRIC CARDS
              SizedBox(

                height: 80,

                child: ListView(

                  scrollDirection: Axis.horizontal,

                  children: [

                    metricCard(
                        "Projects", "5", Icons.work, Colors.blue),

                    metricCard(
                        "Attendance", "92%", Icons.access_time, Colors.green),

                    metricCard(
                        "Leaves", "3", Icons.beach_access, Colors.orange),

                    metricCard(
                        "Messages", "8", Icons.mail, Colors.purple),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              attendanceChart(),

              const SizedBox(height: 20),

              const Text(
                "Announcements",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              announcement(
                  "Annual Meeting",
                  "Scheduled on 25 June 2026"),

              announcement(
                  "New HR Policy",
                  "Updated leave policy announced"),

              const SizedBox(height: 20),

              ElevatedButton.icon(

                icon: const Icon(Icons.send),

                label: const Text("Submit Leave Request"),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.leave);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}