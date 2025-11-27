class MySingleton {
  // Private constructor to prevent external instantiation.
  MySingleton._privateConstructor() {
    print('called _privateConstructor');
  }

  // The single instance of the class, initialized eagerly.
  static final MySingleton _instance = MySingleton._privateConstructor();

  // Factory constructor to provide access to the singleton instance.
  factory MySingleton() {
    print('called factory MySingleton');
    return _instance;
  }

  // Add your methods and properties here.
  String data = "I am a unique instance.";

  void doSomething() {
    print("Singleton is performing an action.");
  }
}

void main() {
  print('before call mysingleton');
  MySingleton().doSomething();
  MySingleton().doSomething();
}
