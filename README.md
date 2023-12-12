<h1 align=center>Merhaba, Ben Hüseyin BAKAR</h1> 

<h2 align=center>Online Food Delivery App</h2> 

Merhaba, Online yemek sipariş uygulamasında, Alamofire generic servis aracılığı ile ilgili modeli transfer ettim . Proje'de genel olarak MVVM Mimarisi ve Dependency Injection ve Delegate pattern kullandım. Nib ile ilgili ekranları tasarladım. Görüşmek Üzere.. 

* Technologies
+ MVVM Architecture ✅
+ Dependency Injection ✅
+ Protocol Oriented Programming ✅
+ Delegate Pattern ✅
+ Nib ✅
+ Cocoapods ✅
+ Kingfisher ✅ 
+ Alamofire ✅
+ Lottie ✅
+ CoreData ✅
  
* Demo
  
[https://github.com/hbakar/OnlineFoodDeliveryApp/blob/main/bootcamp-ios.mp4](https://github.com/hbakar/OnlineFoodDeliveryApp/assets/7202681/4fa342cd-f7ef-4024-ab45-8f7707c93df7)


* API

Ex: http://kasimadalan.pe.hu/yemekler

```` swift
final class ServiceManager {
    static let shared = ServiceManager()
    
    private init() { }
    
    func fetchRequest<T: Decodable>(urlString: String, completion: @escaping(Result<T, AFError>) ->()) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: urlString)))
            return }
        
        AF.request(url,encoding: JSONEncoding.default).validate().responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
````
