import 'package:flutter/material.dart';
import 'package:kidsmathapp/story_content.dart';

class StoryMenuPage extends StatelessWidget {
  const StoryMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stories = [
      {
        'title': 'Shape Fun',
        'image': 'assets/images/story1.png',
        'content':
        'Alexander was a curious little boy who loved to explore. One morning, while playing, he noticed his ball was round. "Mommy, my ball is a circle!" he exclaimed.Mommy smiled. "Can you find more shapes?"Excited, Alexander looked around. The clock was a circle, the window was a square, and his toy block had four equal sides too! Outside, he spotted a house with a triangle roof.Turning his shape hunt into an adventure, Alexander found triangles in pizza slices, rectangles in the fridge door, and even a cone in his birthday hat!"Mommy! Shapes are everywhere!" he cheered.That night, as he drifted to sleep, he dreamed of magical lands filled with circles, squares, and triangles—his adventure was just beginning! ✨🔺🔵🟦'
      },
      {
        'title': 'White Magic',
        'image': 'assets/images/story2.png',
        'content': 'Emily, a cheerful little baby, woke up to a world covered in soft, sparkling snow. Her eyes widened with excitement as she reached out to touch the frosty window."Dada! Snow!" she giggled.Wrapped in her fluffy coat and tiny boots, Emily waddled outside. She stretched out her hands, feeling the cold flakes melt on her fingers. She clapped her hands, and a puff of snow flew into the air like magic.She made tiny footprints, chased falling snowflakes, and giggled as Daddy rolled a big snowball. Soon, they built a jolly snowman with a carrot nose and a scarf just like hers As the sun set, Mommy wrapped her in a warm blanket. "Did you have fun, my little snow angel?"Emily yawned, nodding happily. As she closed her eyes, she dreamed of dancing snowflakes and magical winter wonderlands. ❄️✨'
      },
      {
        'title': 'Ten Little Dreamers',
        'image': 'assets/images/story3.png',
        'content': 'Ten tiny babies lay snug in their cribs, their eyes fluttering as they drifted into dreamland. One dreamed of soaring through the sky like a little bird, flapping her tiny wings. Another imagined swimming deep in the ocean, giggling as a friendly dolphin swirled around him.One baby rode a rocket to the stars, waving at the moon, while another explored a jungle, swinging from vine to vine with a playful monkey. A brave little dreamer sailed a pirate ship, and another danced in a field of glowing fireflies.From castles in the clouds to magical lands filled with candy trees, each baby had an adventure of their own.As the sun peeked through the window, the ten little dreamers stretched and yawned, their hearts still full of wonder. The night’s adventures would live on—until the next dream began. ✨💤'
      },
      {
        'title': 'The Little Talker',
        'image': 'assets/images/story4.png',
        'content': 'Baby Mia was learning to talk! She watched Mommy with bright, curious eyes and tried her best to say, "Mama.""Ma... Ma..." she babbled, clapping her tiny hands.Mommy smiled. "You’re so close, sweetheart!"Mia giggled and pointed at the cat. "M-m-mewo!"Daddy laughed. "Almost, Mia! Try again!"Mia took a deep breath, scrunched her nose, and finally said, "Mama!"Mommy scooped her up, showering her with kisses. "You did it, my little talker!"Mia giggled proudly—her first word was just the beginning of many more to come! 💕👶✨'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Story Telling',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryContentPage(
                      title: story['title']!,
                      image: story['image']!,
                      content: story['content']!,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        story['image']!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        story['title']!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
