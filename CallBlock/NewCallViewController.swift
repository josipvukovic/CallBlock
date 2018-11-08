import UIKit
import CallKit

var blockedNumbers = [String]()


class NewCallViewController: UIViewController {
    @IBOutlet weak var instruction: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .lightContent
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            instruction.isHidden = true

        } else {
            decoyBlockedNumber()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        let defaults = UserDefaults.standard
        blockedNumbers = defaults.stringArray(forKey: "BlockedNumbersArray") ?? [String]()
        //Here we add value to blockedNumbers array from User defaults in case this is not the first time we run the app, because blockedNumbers array will lose data when we close app, so the moment before reloading extension when we enter new number to block, we want to save old data + new data to key "BlockedNumbersArray"
        

    }
  
  var handle: String? {
    return handleTextField.text
  }
  
  var incoming: Bool {
    return incomingSegmentedControl.selectedSegmentIndex == 0
  }
  
    
    @IBOutlet weak var inputNumber: UITextField!
    let defaults = UserDefaults.standard
    
    
    
    @IBAction func inputDone(_ sender: Any) {
        if inputNumber.text!.isEmpty {
            // textfield is empty
            
            let alert = UIAlertController(title: "Error", message: "You must enter a number.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Success", message: "Number \""+inputNumber.text!+"\" is now successfully blocked from calling you!", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            if let userDefaults = UserDefaults(suiteName: "group.com.callblock") {
                userDefaults.set(inputNumber.text as AnyObject, forKey: "key1")
                print(inputNumber)
                blockedNumbers.append(inputNumber.text!)
                defaults.set(blockedNumbers, forKey: "BlockedNumbersArray")
                
                userDefaults.synchronize()
                
                CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier:
                    "com.jv.callblock.CallBlockDirectory", completionHandler: { (error) -> Void in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                })
            }
            
           inputNumber.text = ""
            
        }

    }
    
    func decoyBlockedNumber(){
    //in this function we add some data(non-existent phone number) to blocking list because we cannot enable Extension in Settings->Phone until it recieves some kind of data so we do this instead of troubling user through this process
        if let userDefaults = UserDefaults(suiteName: "group.com.callblock") {
            userDefaults.set("1" as AnyObject, forKey: "key1")
            blockedNumbers.append("1")
            defaults.set(blockedNumbers, forKey: "BlockedNumbersArray")
            
            userDefaults.synchronize()
            
            CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier:
                "com.jv.callblock.CallBlockDirectory", completionHandler: { (error) -> Void in
                    if let error = error {
                        print(error.localizedDescription)
                    }
            })
        }
    
    }
  
  @IBOutlet private var handleTextField: UITextField!
  @IBOutlet private var videoSwitch: UISwitch!
  @IBOutlet private var incomingSegmentedControl: UISegmentedControl!

  @IBAction private func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

