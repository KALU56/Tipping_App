import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/auth/presentation/screens/pass.dart';
import '../../../../core/assets/assets.dart';


class Taskugas extends StatefulWidget {
  const Taskugas({super.key});

  @override
  State<Taskugas> createState() => _TaskugasState();
}

class _TaskugasState extends State<Taskugas> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Team Up For Success',
      'desc': 'Team Up For Success Team Up For Success Team Up For Success Team Up For Success Team Up For Success ',
      'image': Assets.image2,
    },
    {
      'title': 'User-Friendly at its Core',
      'desc': 'Team Up For Success Team Up For Success Team Up For Success Team Up For Success vvTeam Up For Success .',
      'image': Assets.image3,
    },
    {
      'title': 'Easy Task Creation',
      'desc': 'Team Up For Success Team Up For Success vvvTeam Up For Success Team Up For Success .',
      'image': Assets.image4,
    },
  ];

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Go to Pass page when onboarding finishes
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pass()),
      );
    }
  }

  void _skip() {
    // Skip directly to Pass page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Pass()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// App header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.tag),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Tasktugas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 22, 126, 1),
                ),
              ),
            ],
          ),

          /// Onboarding pages
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                final item = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(item['image']!, height: 300),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          /// Indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _currentIndex == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Colors.purple
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          /// Title + description
          Column(
            children: [
              Text(
                onboardingData[_currentIndex]['title']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                onboardingData[_currentIndex]['desc']!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Next or Continue button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _nextPage,
              child: Text(
                _currentIndex == onboardingData.length - 1 ? 'Continue' : 'Next',
              ),
            ),
          ),

          /// Skip button
          TextButton(
            onPressed: _skip,
            child: Text(
              'Skip',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}