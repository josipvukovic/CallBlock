import Foundation
import CallKit


//var brojac:Int = 1

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    var number:Int64 = 0
    var phoneNumbers: [CXCallDirectoryPhoneNumber] = [ 2539501212 ] //ascending!!
    var phoneNums = [String]() //array which recieves blocked numbers in String format



  override func beginRequest(with context: CXCallDirectoryExtensionContext) {
    context.delegate = self
    
    let defaults = UserDefaults.standard
    phoneNums = defaults.stringArray(forKey: "BlockedNumbersArray") ?? [String]()
    for phoneNumber in phoneNums{
        
        number = Int64(phoneNumber)!
        //in this step we transform string to int64 which is needed in our CXCallDirectoryPhoneNumber array
        phoneNumbers.append(number)
    }
    print(phoneNumbers) //for testing purposes

    
    do {
      try addBlockingPhoneNumbers(to: context)
    } catch {
      NSLog("Unable to add blocking phone numbers")
      let error = NSError(domain: "CallDirectoryHandler", code: 1, userInfo: nil)
      context.cancelRequest(withError: error)
      return
    }
    
    do {
      try addIdentificationPhoneNumbers(to: context)
    } catch {
      NSLog("Unable to add identification phone numbers")
      let error = NSError(domain: "CallDirectoryHandler", code: 2, userInfo: nil)
      context.cancelRequest(withError: error)
      return
    }
    
    context.completeRequest()
  }
  
  
  private func addBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) throws {

    if let userDefaults = UserDefaults(suiteName: "group.com.callblock") {
        let  value1 = userDefaults.string(forKey: "key1")
        number = Int64(value1!)!
        //print(number)
    }
    phoneNumbers.append(number)
    //phoneNumbers.insert(number, at: brojac)
    //brojac+=1
    phoneNumbers.sort() //phoneNumbers array must bi in ascending order

    
    for phoneNumber in phoneNumbers.sorted(by: <){
      context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
    }
    context.completeRequest()
  }
  
  
    func addIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) throws {

        let phoneNumbers2: [CXCallDirectoryPhoneNumber] = [ 4259501212 ]
        let labels = ["*WARNING* SUSPICIOUS CALL!"]
        
        for (phoneNumber, label) in zip(phoneNumbers2, labels) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }
    }
  
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
  
  func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
    print("An error occured when completing the request: \(error.localizedDescription)")
  }
  
}
