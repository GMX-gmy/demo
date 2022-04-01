class TestUtil {

  static TestUtil? instance;

  String name = '';

  static getInstance() {
    if(instance == null) {
      instance = TestUtil();
    }
  }

  updateName(String name1){
    name = name1;
    print('TestUtil name--------$name');
  }


}
