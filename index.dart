import 'dart:convert';
import 'dart:io';

// Define an interface
abstract class Animal {
  String speak();
}

// Define a base class that implements the interface
class Dog implements Animal {
  @override
  String speak() => 'Woof!';
}

// Define a subclass that overrides a method
class Cat implements Animal {
  @override
  String speak() => 'Meow!';
}

// Define a class that reads data from a file and initializes an instance
class PetStore {
  List<Animal> animals = [];

  PetStore(String filename) {
    String jsonString = File(filename).readAsStringSync();
    List<dynamic> data = jsonDecode(jsonString)['animals'];
    for (Map<String, dynamic> animalData in data) {
      if (animalData['type'] == 'dog') {
        animals.add(Dog());
      } else if (animalData['type'] == 'cat') {
        animals.add(Cat());
      }
    }
  }

  List<Animal> getAnimals() {
    return animals;
  }
}

// Demonstrate the use of a loop
void main() {
  PetStore petStore = PetStore('animals.json');
  List<Animal> animals = petStore.getAnimals();
  for (Animal animal in animals) {
    print(animal.speak());
  }
}
