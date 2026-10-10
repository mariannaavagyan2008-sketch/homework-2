import 'package:dart_homework_4/dart_homework_4.dart' as dart_homework_4;

Future<void> main(List<String> arguments) async{
  //1 hesht
  List<String> cucak = ["Kat","Smetan","Hac","Dzu"];
  cucak.add("Jem"); //avelacnuma verjum
  cucak.insert(2, "Hyut"); //avelacnuma konkret indexum elementy
  cucak.removeAt(4);//heracnel apranq yst indexi
  cucak[0]="Ershik";//poxel konkret indexov element
  String firstelem= cucak.first; //arajin element
  String lastelem=cucak.last; //verjin element
  print(firstelem);
  print(lastelem);
  bool isempty=cucak.isEmpty;//stuguma ardyoq cucaky datarka 
  print(isempty);
  print(cucak);
  //2 hesht
  Book book = Book("Tunelic 13 kilometr heravorutyan vra","Ruben Yesayan",300);
  print(book.getInfo());
  //3 hesht
  var f1=await delayedValue(5); //spasenq minchev arjeq veradardzni
  print(f1);
  var f2 =await sumValues(4,5);
  print(f2);

  //1 mijin
  List<Vehicle> myVehicles = [
    Car(8.0),       
    Motorcycle(3.5), 
  ];
  double distance = 200;
  double result = totalConsumption(myVehicles, distance);
  print("Anhrajesht yndhanur vareliqy ($distance km-i hamar): $result litr");
  //2 mijin
  List<Product> productList = [
    Product('Xndzor', 'Mirg', 500),
    Product('Banana', 'Mirg', 700),
    Product('Hac', 'Hacabulkeghen', 300),
    Product('Kat', 'Katnamterq', 450),
    Product('Panir', 'Katnamterq', 1200),
  ];
  Map<String, double> ardyunq = totalByCategory(productList);
  print(ardyunq);
  //3 mijin
  int number1 = await safeGetNumber(10);
  int number2 = await safeGetNumber(-3);
  print(number1);
  print(number2);
  //1 bard
  Payment card = CardPayment();
  Payment cash = CashPayment();
  Payment crypto = CryptoPayment();
  double amount = 1000.0;
  print("Qartov vcharvac: ${calculateTotal(card, amount)}");
  print("Cash vcharvac: ${calculateTotal(cash, amount)}");
  print("Criptoyov vcharvac: ${calculateTotal(crypto, amount)}");
  //2 bard
  print(findPair([1,2,5,6,8,9], 3));
  //3 bard
  print('Starting...');
  List<String> output = await runTasks(); //spasi minchev 3n el kverjacnen u lcni listi mej
  print('Ready');
  for (var task in output) {
    print(task);
  }
}






//2 hesht
class Book{
  String title;
  String author;
  int pages;

  Book(this.title, this.author, this.pages);

  String getInfo(){
    return "$title by $author, Pages $pages";
  }
}
//3 hesht
Future<int> delayedValue(int value) async{
  await Future.delayed(Duration(milliseconds: 100));
  return value;
}
Future<int> sumValues(int a, int b) async{
  int num1 = await delayedValue(a);
  int num2 = await delayedValue(b);
   
  return num1+num2;
}
//1 mijin
abstract class Vehicle{
  double fuelConsumption();
}
class Car extends Vehicle{
  double litersPer100Km;
  Car(this.litersPer100Km);
  @override
  double fuelConsumption(){
    return litersPer100Km;
  }
}
class Motorcycle extends Vehicle{
  double litersPer100Km;
  Motorcycle(this.litersPer100Km);
  @override
  double fuelConsumption(){
    return litersPer100Km;
  }
  
}
double totalConsumption(List<Vehicle> vehicles, double distance){
  double totallitres=0;

  for(var vehicles in vehicles){
    double litres = (vehicles.fuelConsumption()*distance)/100;
    totallitres+=litres;
  }
  return totallitres;
}

//2 mijin
class Product {
String name;
String category;
double price;
Product(this.name,this.category,this.price);
}
Map<String, double> totalByCategory(List<Product> products){
  Map<String,double> totals={};

  for(var product in products){
    //stugum enq ardyoq es kategorian ka map-um
    if(totals.containsKey(product.category)){ 
      //ete ka vercnum enq ayd kategoriyai hin gumarn u gumarum nor apranqi giny
      totals[product.category]=totals[product.category]!+product.price;
    }
    else{
      //ete chka ughaki grum enq gumary vorpes skzbnakan
      totals[product.category] = product.price;
    }
  }
  return totals;
}
//3 mijin
Future<int> getNumber(int value) async{
  if(value>0){
    await Future.delayed(Duration(milliseconds: 100));
    return value;
  }
  else{
    throw Exception('Value must be greater than 0');
  }
}
Future<int> safeGetNumber(int value) async{
  try{
     return await getNumber(value);
  }
  catch (e) {
     return 0;
  }
}

//1 bard
abstract class Payment{
  double calculateFee(double amount);
}
class CardPayment extends Payment{
   @override
   double calculateFee(double amount){
    return amount*0.02; //2%
  }
}
class CashPayment extends Payment {
  @override
  double calculateFee(double amount) {
    return 0.0; //0%
  }
}
class CryptoPayment extends Payment {
  @override
  double calculateFee(double amount) {
    return amount * 0.05; //5%
  }
}
double calculateTotal(Payment payment, double amount) {
  return amount+payment.calculateFee(amount);
}
//2 bard
List<int> findPair(List<int> numbers, int target){
  Map<int,int> number={};

  for(int i=0;i<numbers.length;i++){
    int currentnum=numbers[i];

    int numberp=target-currentnum;
    if(number.containsKey(numberp)){
      return [number[numberp]!,i];
    }
    number[currentnum]=i;
  }
  return [];
}
//3 bard
Future<String> runTask(String name, int milliseconds) async{
  await Future.delayed(Duration(milliseconds: milliseconds));
  return "Task $name completed";
}
Future<List<String>> runTasks() async{
   List<String> results = await Future.wait([ //Future.wait gorcarkum e bolory miajamanak bayc hertakanutyuny pahelov
    runTask('A', 100),
    runTask('B', 50),
    runTask('C', 150),
  ]);

  return results;
}