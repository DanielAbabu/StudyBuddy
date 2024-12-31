import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NoteSummaryScreen extends StatelessWidget {
  final String noteContent;

  NoteSummaryScreen({
    required this.noteContent,
    });


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Make the screen scrollable
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Note Title Here',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Using MarkdownBody to parse and display the markdown content
            MarkdownBody(
              data: noteContent,

              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                h2: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                p: TextStyle(fontSize: 12),
                em: TextStyle(fontStyle: FontStyle.italic),
                // ul: TextStyle(fontSize: 16),  // Bullet points style
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   final String noteContent = '''
// # Space Science: An Overview

// Space science is a multidisciplinary field of study that focuses on exploring the universe beyond Earth. It encompasses various scientific disciplines, including astronomy, astrophysics, planetary science, and space exploration, all aimed at understanding the nature of space, celestial bodies, and the fundamental laws governing the cosmos. Space science combines theory, experimentation, observation, and the application of advanced technologies to study the origins, structure, evolution, and eventual fate of the universe.

// ## 1. **Astronomy**: The Study of Celestial Objects

// Astronomy is the oldest of the natural sciences, focusing on the study of celestial objects and phenomena that exist beyond Earth's atmosphere. This includes the observation of stars, planets, comets, asteroids, and galaxies. Astronomy is concerned with understanding the positions, movements, and properties of celestial bodies.

// - **Stars and Stellar Evolution**: Stars are massive, luminous spheres of gas that generate energy through nuclear fusion. They form from clouds of gas and dust and undergo various stages of life, including main sequence, red giant, supernova, and, depending on their mass, either a neutron star or black hole.

// - **Galaxies and the Universe**: Galaxies are vast collections of stars, gas, dust, and dark matter bound together by gravity. Our own galaxy, the Milky Way, contains billions of stars. Understanding the formation, distribution, and motion of galaxies has led to significant discoveries, such as the expansion of the universe.

// ## 2. **Astrophysics**: Understanding the Physics of Space

// Astrophysics applies the principles of physics to explain how astronomical objects and phenomena behave. This includes the study of forces like gravity, electromagnetism, and nuclear forces in space.

// - **Gravity**: One of the key aspects of astrophysics is the study of gravity. The gravitational pull of massive bodies like stars and black holes shapes the structure of the universe. Einstein's theory of general relativity revolutionized our understanding of gravity, showing that mass bends the fabric of spacetime itself.

// - **Black Holes**: Black holes are regions in space where gravitational forces are so intense that not even light can escape. They are formed from the remnants of massive stars that have collapsed under their own gravity. Studying black holes provides insights into the extreme conditions of space and time.

// ## 3. **Planetary Science**: The Study of Planets

// Planetary science focuses on the study of planets, moons, and other objects in our solar system and beyond. It involves studying the origin, composition, and characteristics of these celestial bodies.

// - **Planetary Formation**: Planets form from the remnants of gas and dust left over after the birth of stars. This process, known as accretion, can lead to the formation of rocky planets like Earth or gas giants like Jupiter.

// - **Moons and Rings**: Many planets in our solar system have natural satellites, or moons, that orbit them. Moons can be diverse, with some being icy bodies like Saturn’s moon Enceladus, while others, like Earth’s moon, play a critical role in shaping the conditions for life on their parent planets. Planetary rings, like those around Saturn, are made up of ice and rock particles and provide important clues about planetary formation.

// - **Exoplanets**: Planets that orbit stars outside our solar system are called exoplanets. The discovery of exoplanets has been one of the most exciting areas of space science. Some exoplanets lie in the habitable zone of their star, where conditions might support life as we know it.

// ## 4. **Space Exploration**: Pushing the Boundaries of Human Knowledge

// Space exploration refers to the use of space technologies to explore outer space, including sending spacecraft, satellites, and astronauts to distant places. This is one of the most exciting and active areas in space science.

// - **Robotic Missions**: Unmanned spacecraft like the Voyager probes, sent by NASA in the 1970s, have provided invaluable data on the outer solar system. These missions have expanded our knowledge of planets, moons, and the structure of space itself.

// - **Human Spaceflight**: Human spaceflight has allowed astronauts to directly study space and conduct experiments that cannot be done on Earth. The International Space Station (ISS), a joint venture between NASA, Roscosmos, ESA, JAXA, and CSA, serves as a laboratory for studying the effects of microgravity and space radiation on the human body and for testing technologies that may one day allow human exploration of Mars.

// - **Space Telescopes**: Instruments like the Hubble Space Telescope have revolutionized our understanding of the universe by allowing scientists to observe distant galaxies, stars, and planets in unprecedented detail. Space-based telescopes avoid the interference of Earth’s atmosphere and can capture a broader range of electromagnetic radiation, such as infrared and ultraviolet.

// ## 5. **Cosmology**: The Study of the Universe’s Origins and Structure

// Cosmology is a branch of astronomy that studies the large-scale properties of the universe as a whole. It seeks to understand the origin, evolution, and eventual fate of the universe.

// - **Big Bang Theory**: The prevailing theory of the universe's origin is the Big Bang Theory, which suggests that the universe began as an extremely hot, dense point approximately 13.8 billion years ago and has been expanding ever since. This expansion explains the observed redshift in light from distant galaxies, a phenomenon first observed by astronomer Edwin Hubble.

// - **Dark Matter and Dark Energy**: These are two mysterious components of the universe that have been hypothesized to account for the majority of the universe’s mass and energy. While we cannot observe dark matter directly, its presence is inferred from gravitational effects on visible matter. Dark energy is thought to be responsible for the accelerating expansion of the universe.

// - **The Fate of the Universe**: Cosmologists are also working to understand the ultimate fate of the universe. Theories include scenarios such as the "Big Freeze," in which the universe continues to expand and cool indefinitely, or the "Big Crunch," where gravity eventually causes the universe to collapse in on itself.

// ## 6. **The Search for Life Beyond Earth**

// One of the most intriguing aspects of space science is the search for extraterrestrial life. Scientists are searching for planets in the "habitable zone," the region around a star where conditions might be suitable for liquid water, a crucial ingredient for life as we know it.

// - **Astrobiology**: This field explores the potential for life beyond Earth by studying extreme environments on Earth where life can survive, such as deep-sea vents or acidic lakes. Understanding how life adapts to extreme conditions on Earth helps us make predictions about what life might look like on other planets.

// - **SETI (Search for Extraterrestrial Intelligence)**: SETI is an ongoing scientific effort to detect signs of intelligent alien civilizations by listening for radio signals from other stars. Although no conclusive evidence of extraterrestrial intelligence has been found yet, the search continues with advanced radio telescopes and observational techniques.

// ## Conclusion

// Space science continues to evolve and expand as technology advances and our understanding of the cosmos deepens. From the study of distant galaxies to the exploration of our own solar system, the field of space science provides valuable insights into the fundamental nature of the universe. As we continue to push the boundaries of space exploration, we may uncover even more profound mysteries that can transform our understanding of space and our place in it.
//   ''';
