import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final carouselDataProvider = StateProvider<List<Widget>>((ref) => [
      Card(
        color: Color.fromARGB(255, 220, 198, 133),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Card 1'),
        ),
      ),
      Card(
        color: Color.fromARGB(255, 220, 198, 133),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Card 2'),
        ),
      ),
    ]);
final currentPageIndexProvider = StateProvider<int>((ref) => 0);

class CustomCarousel extends ConsumerWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCards = ref.watch(carouselDataProvider);
    final pageController = PageController(viewportFraction: 0.8);
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    pageController.addListener(() {
      ref.read(currentPageIndexProvider.notifier).state =
          pageController.page!.round();
    });

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView(
            controller: pageController,
            children: currentCards,
            onPageChanged: (index) =>
                ref.read(currentPageIndexProvider.notifier).state = index++,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(currentCards.length, (index) {
              // Use List.generate for dynamic dots
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: AnimatedContainer(
                  // color: Color.fromARGB(255, 200, 159, 34),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color:
                        currentPageIndex == index ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  width: currentPageIndex == index ? 8.0 : 6.0,
                  height: currentPageIndex == index ? 8.0 : 6.0,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Example usage
class CarouselScreen extends ConsumerWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          context.go('/home');
        },
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Custom Carousel',
          style: TextStyle(color: Colors.amber[600]),
        ),
      ),
      body: Column(
        children: [
          const CustomCarousel(),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final carouselDataProvider = StateProvider<Widget>((ref) => const Text('Default Card'));
// final currentPageIndexProvider = StateProvider<int>((ref) => 0);

// class CustomCarousel extends ConsumerWidget {
//   const CustomCarousel({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentWidget = ref.watch(carouselDataProvider);
//     final pageController = PageController(viewportFraction: 0.8);
//     final currentPageIndex = ref.watch(currentPageIndexProvider);

//     pageController.addListener(() {
//       ref.read(currentPageIndexProvider.notifier).state =
//           pageController.page!.round();
//     });

//     return Stack(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.5,
//           child: PageView(
//             controller: pageController,
//             children: [currentWidget],
//             onPageChanged: (index) => ref.read(currentPageIndexProvider.notifier).state = index,
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [0, 1, 2] // Assuming 3 cards for now
//                 .asMap()
//                 .entries
//                 .map((entry) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   decoration: BoxDecoration(
//                     color: currentPageIndex == entry.key ? Colors.blue : Colors.grey,
//                     shape: BoxShape.circle,
//                   ),
//                   width: currentPageIndex == entry.key ? 8.0 : 6.0,
//                   height: currentPageIndex == entry.key ? 8.0 : 6.0,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Example usage
// class CarouselScreen extends ConsumerWidget {
//   const CarouselScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Carousel'),
//       ),
//       body: Column(
//         children: [
//           const CustomCarousel(),
//           ElevatedButton(
//             onPressed: () {
//               ref.read(carouselDataProvider.notifier).state = Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text('Updated Card Content'),
//                 ),
//               );
//             },
//             child: Text('Update Card'),
//           ),
//         ],
//       ),
//     );
//   }
// }
