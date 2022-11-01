//
//  ViewController.swift
//  FaceRecognize
//
//  Created by Berke Topcu on 2.11.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        //bir LA Context oluşturduk. Kullanıcıdan parmak izini veya yüz tanıma işlemleri için kamerasını kullanmak amacıyla
        let authContext = LAContext()
        var error : NSError?
        //&error olarak aşağıda bulunan fonksiyona verdiğimiz "&" , 've' anlamına gelmekle beraber referans göstermek için.
        //Oluşturduğumuz LAContext ile kullanıcının hangi yetkikendirme işlemini kontrol etmek istediğimizi, ve yanlış yetkilendirme durumunda hangi hatayı (error) döneceğimizi belirttik.
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //evalutePolicy fonksiyonu girilen bilgileri doğrulamak için. Bu fonksiyon bizden kullanıcının nesini doğrulamamızı istediğimizi, bunu neden istediğimizi, doğruluk veya yanlışlık durumunda olacakları istiyor.
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (succes, error) in
                if succes == true {
                    //Main Thread'de olmadığımız için yüz tanıma işlemlerini yapmamız hata ile sonuçlandığından bunu dispatchqueue içerisinde belirtmemiz gerekiyor ki main thread problemi ortadan kalksın
                    //Succesfull Auth
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
                        print("giriş yapıldı")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorLabel.text = "Unauthorized"
                        print("hatalı parmak izi")
                    }
                }
            }
        }
    }
    
}

