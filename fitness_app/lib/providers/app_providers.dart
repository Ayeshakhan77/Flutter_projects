import 'package:flutter/foundation.dart';
import '../models/app_models.dart';
import 'dart:math';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isDarkMode = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isDarkMode => _isDarkMode;

  List<User> _users = [];

  Future<bool> signUp(String name, String email, String password) async {
    // Check if user already exists
    if (_users.any((user) => user.email == email)) {
      return false;
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
    );
    _users.add(user);
    _currentUser = user;
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    final user = _users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => null as User,
    );
    
    if (user != null) {
      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void signOut() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateUser(String name, String email, String? password) {
    if (_currentUser != null) {
      _currentUser!.name = name;
      _currentUser!.email = email;
      if (password != null && password.isNotEmpty) {
        _currentUser!.password = password;
      }
      notifyListeners();
    }
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  bool resetPassword(String email) {
    return _users.any((user) => user.email == email);
  }
}

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;
  List<Workout> get todaysWorkouts => _workouts.where((w) => 
    w.date.year == DateTime.now().year &&
    w.date.month == DateTime.now().month &&
    w.date.day == DateTime.now().day
  ).toList();

  int get totalCaloriesBurned => _workouts.fold(0, (sum, w) => sum + w.caloriesBurned);
  int get totalWorkouts => _workouts.length;
  int get weeklyWorkouts => _workouts.where((w) => 
    w.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))
  ).length;

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void updateWorkout(String id, Workout updatedWorkout) {
    final index = _workouts.indexWhere((w) => w.id == id);
    if (index != -1) {
      _workouts[index] = updatedWorkout;
      notifyListeners();
    }
  }

  void deleteWorkout(String id) {
    _workouts.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  List<Workout> getWeeklyWorkouts() {
    return _workouts.where((w) => 
      w.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();
  }
}

class MealProvider extends ChangeNotifier {
  List<Meal> _meals = [];

  List<Meal> get meals => _meals;
  List<Meal> get todaysMeals => _meals.where((m) => 
    m.date.year == DateTime.now().year &&
    m.date.month == DateTime.now().month &&
    m.date.day == DateTime.now().day
  ).toList();

  int get totalCaloriesConsumed => _meals.fold(0, (sum, m) => sum + m.calories);
  int get totalMeals => _meals.length;

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void updateMeal(String id, Meal updatedMeal) {
    final index = _meals.indexWhere((m) => m.id == id);
    if (index != -1) {
      _meals[index] = updatedMeal;
      notifyListeners();
    }
  }

  void deleteMeal(String id) {
    _meals.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  List<Meal> getWeeklyMeals() {
    return _meals.where((m) => 
      m.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))
    ).toList();
  }
}

class StatsProvider extends ChangeNotifier {
  FitnessStats _stats = FitnessStats();

  FitnessStats get stats => _stats;

  void updateSteps(int steps) {
    _stats.steps = steps;
    notifyListeners();
  }

  void updateWeight(double weight) {
    _stats.weight = weight;
    notifyListeners();
  }

  void updateCaloriesBurned(int calories) {
    _stats.caloriesBurned = calories;
    notifyListeners();
  }

  void updateCaloriesConsumed(int calories) {
    _stats.caloriesConsumed = calories;
    notifyListeners();
  }

  Map<DateTime, int> getWeeklySteps() {
    final Map<DateTime, int> weeklySteps = {};
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      weeklySteps[date] = Random().nextInt(8000) + 2000; // Mock data
    }
    return weeklySteps;
  }

  Map<DateTime, int> getWeeklyCalories() {
    final Map<DateTime, int> weeklyCalories = {};
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      weeklyCalories[date] = Random().nextInt(500) + 200; // Mock data
    }
    return weeklyCalories;
  }
}

class ChatbotProvider extends ChangeNotifier {
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void addMessage(String text, bool isUser) {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: isUser,
      timestamp: DateTime.now(),
    );
    _messages.add(message);
    notifyListeners();
    
    if (!isUser) return;
    
    // Auto-response for demo
    Future.delayed(const Duration(milliseconds: 500), () {
      _getBotResponse(text);
    });
  }

  void _getBotResponse(String userMessage) {
    String response;
    final lowerMsg = userMessage.toLowerCase();
    
    if (lowerMsg.contains('hello') || lowerMsg.contains('hi')) {
      response = "Hello! I'm your fitness coach. How can I help you today? 💪";
    } else if (lowerMsg.contains('workout') || lowerMsg.contains('exercise')) {
      response = "Great! Remember to warm up for 5-10 minutes before any workout. Try mixing cardio with strength training for best results! 🏋️‍♂️";
    } else if (lowerMsg.contains('meal') || lowerMsg.contains('food') || lowerMsg.contains('diet')) {
      response = "Nutrition tip: Eat protein with every meal, stay hydrated, and include colorful vegetables in your diet! 🥗";
    } else if (lowerMsg.contains('motivation') || lowerMsg.contains('motivate')) {
      response = "You're doing amazing! Every small step counts. Keep pushing forward! 🌟";
    } else if (lowerMsg.contains('weight') || lowerMsg.contains('lose')) {
      response = "Consistency is key! Combine regular exercise with a balanced diet. Aim for 0.5-1kg loss per week for sustainable results. ⚖️";
    } else if (lowerMsg.contains('sleep')) {
      response = "Quality sleep is crucial for recovery. Aim for 7-9 hours per night! 😴";
    } else {
      response = "Thanks for your message! Remember to stay consistent with your fitness goals. Track your workouts and meals daily for best results! 🎯";
    }
    
    addMessage(response, false);
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}