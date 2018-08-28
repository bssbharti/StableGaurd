//
//  ServerManager.swift
//  UtilityDemoSwift3
//
//  Created by Jitendra Kumar on 23/12/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

import UIKit
import CFNetwork
import Alamofire
import MobileCoreServices
import Kingfisher
typealias ServerSuccessCallBack = (_ json:JSON)->Void
typealias ServerFailureCallBack=(_ error:Error?)->Void
typealias ServerProgressCallBack = (_ progress:Double?) -> Void
typealias ServerNetworkConnectionCallBck = (_ reachable:Bool) -> Void
typealias ServerSessionFailureCallBck = (_ json:JSON) -> Void
class ServerManager: NSObject {
    var jkHud:JKProgressHUD!
    override init() {
        super.init()
    }
    
    class var shared:ServerManager{
        
        struct  Singlton{
            
            static let instance = ServerManager()
            
        }
        
        return Singlton.instance
    }
    //MARK:- documentsDirectoryURL -
    lazy var documentsDirectoryURL : URL = {
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documents
    }()
    //MARK:- backgroundManager -
    private lazy var backgroundManager: Alamofire.SessionManager = {
        let bundleIdentifier = Bundle.main.bundleIdentifier
        let configure  = URLSessionConfiguration.background(withIdentifier: bundleIdentifier! + ".background")
        // configure.timeoutIntervalForRequest = 30
        
        let session = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: bundleIdentifier! + ".background"))
        session.startRequestsImmediately = true
        return session
    }()
    //MARK:- sessionManager -
    private lazy var sessionManager: Alamofire.SessionManager = {
        
        let configure  = URLSessionConfiguration.default
        configure.timeoutIntervalForRequest = 40//120
        configure.httpMaximumConnectionsPerHost = 10
        
        return Alamofire.SessionManager(configuration: configure)
    }()
    //MARK:- backgroundCompletionHandler -
    var backgroundCompletionHandler: (() -> Void)? {
        get {
            return backgroundManager.backgroundCompletionHandler
        }
        set {
            backgroundManager.backgroundCompletionHandler = newValue
        }
    }
    
    //MARK:- showProgressHud-
    func showHud(inView view:UIView = AppDelegate.sharedDelegate.window!,message title:String = ""){
        
        self.hideHud()
        jkHud = JKProgressHUD.showProgressHud(inView: view, titleLabel: title)
        jkHud.setNeedsLayout()
        jkHud.lineColor = .black
        
    }
    //MARK:- showProgressBarHud-
    func showBarHud(inView view:UIView = AppDelegate.sharedDelegate.window! ,message title:String = "",progressMode mode:JKProgressHUDMode = .DefaultHorizontalBar) ->JKProgressHUD {
        
        jkHud = JKProgressHUD.showProgressHud(inView: view, progressMode: mode, titleLabel: title)
        jkHud.lineColor = .black
        return jkHud
        
    }
    func updateProgress(value:Float,title:String = ""){
        if (jkHud != nil), value < 1.0  {
            jkHud.progress = value
            if !jkHud.messageString.isEmpty , !title.isEmpty {
                let percentage = value*100
                jkHud.messageString = "\(title) \(percentage)"
            }
            
        }
        
    }
    //MARK:- hideHud-
    func hideHud(){
        
        if (jkHud != nil) {
            jkHud.hideHud(animated: true)
        }
        
    }
    //MARK: - showToast-
    func showToast(withMessage message:String?){
       
        
    }
    func showNetIndicator(isShow:Bool){
        UIApplication.shared.isNetworkActivityIndicatorVisible = isShow
    }
    //MARK: - checkNetworkConnetion-
    
    func CheckNetwork() -> Bool
    {
        
        let is_net = Reachability.isConnectedToNetwork()
        
        if(is_net==true)
        {
            showNetIndicator(isShow: true)
            return true;
        }
        else
        {
            DispatchQueue.main.async {
                self.hideHud()
                self.showNetIndicator(isShow: false)
                if let controller  = rootController {
                    controller.showAlertAction(title: kConnectionError, message: "The Internet connection appears to be offline.", cancelTitle: "Cancel", otherTitle: "Settings", onCompletion: { (index) in
                        if index == 2{
                            if #available(iOS 10, *) {
                                UIApplication.shared.open(URL(string: "prefs:root=WIFI")!, options: [:], completionHandler: nil)
                            }
                            else{
                                UIApplication.shared.openURL(URL(string: "prefs:root=WIFI")!)
                            }
                        }
                    })
                }
              
              
                
            }
            
            return false;
        }
    }
    
    var apiHeaders: HTTPHeaders? {
        guard let accessToken = UserDefaults.jkDefault(objectForKey: kAuthTokenKey) as? String else { return nil }
        return ["Authorization":"Bearer \(accessToken)"]
    }
    fileprivate var authSessionObj:JSON{
        let params:[String:Any] = ["Message":FieldValidation.kAuthSessionExpire,"Key":2]
        let  json =  JSON(params)
        return json
    }
    //MARK: - createServerPath-
    func createServerPath(api:String)->String{
        return "\(kBaseUrl)/\(api)"
    }
    
    
    //MARK: - httpDelete -
    
    func httpDelete(request api:String!,params:[String:Any]?, headers: HTTPHeaders? = nil,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
        print("service name =\(api)")
        print("service params =\(String(describing: params))")
        sessionManager.request ("\(api!)", method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            self.showNetIndicator(isShow: false)
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print("response\(response)")
                    
                    let json = try! JSON(data: response.data!)
                    if  response.response?.statusCode == 401{
                        
                        if (authSessionHandler != nil){
                            
                            
                            if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                authSessionHandler!(self.authSessionObj)
                            }else{
                                authSessionHandler!(json)
                            }

                        }
                    }
                    else {
                        //response.response?.statusCode == 200
                        if (successHandler != nil){
                            
                            successHandler!(json)

                        }
                        
                    }
                }
                break
                
            case .failure(_):
                if (failureHandler != nil){
                    failureHandler!(response.result.error!)
                }
                
                break
                
            }
            }.resume()
        
        
        
    }
    // MARK:- httpPut -
    func httpPut(request api:String!,params:[String:Any]?, isBackground:Bool = false,headers: HTTPHeaders? = nil,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
        
        print("service name =\(api)")
        print("service params =\(String(describing: params))")
        
        if isBackground {
            backgroundManager.request("\(api!)", method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response:DataResponse<Any>) in
                self.showNetIndicator(isShow: false)
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print("response\(response)")
                        let json = try! JSON(data: response.data!)
                        
                        
                        if  response.response?.statusCode == 401{
                            
                            if (authSessionHandler != nil){
                                
                                
                                if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                    authSessionHandler!(self.authSessionObj)
                                }else{
                                    authSessionHandler!(json)
                                }
  
                                
                            }
                        }
                        else {
                            //statusCode == 200
                            if (successHandler != nil){
                                
                                successHandler!(json)

                            }
                            
                        }
                        
                    }
                    break
                    
                case .failure(_):
                    if (failureHandler != nil){
                        failureHandler!(response.result.error!)
                    }
                    
                    break
                    
                }
            }).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                if (progressHandler != nil){
                    
                    progressHandler!(progress.fractionCompleted)
                }
                }.resume()
        }else{
            
            sessionManager.request ("\(api!)", method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                self.showNetIndicator(isShow: false)
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print("response\(response)")
                        let json = try! JSON(data: response.data!)
                        
                        if  response.response?.statusCode == 401{
                            
                            if (authSessionHandler != nil){
                                
                                if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                    authSessionHandler!(self.authSessionObj)
                                }else{
                                    authSessionHandler!(json)
                                }

                                
                            }
                        }
                        else {
                            //response.response?.statusCode == 200
                            if (successHandler != nil){
                                successHandler!(json)

                            }
                            
                        }
                    }
                    break
                    
                case .failure(_):
                    if (failureHandler != nil){
                        failureHandler!(response.result.error!)
                    }
                    
                    break
                    
                }
                }.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                    if (progressHandler != nil){
                        
                        progressHandler!(progress.fractionCompleted)
                    }
                }.resume()
            
        }
    }
    //MARK:- httpPost -
    func httpPost(request api:String!,params:Parameters?,headers: HTTPHeaders? = nil,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
  
        print("service name =\(api)")
        print("service params =\(String(describing: params))")
        sessionManager.request ("\(api!)", method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            self.showNetIndicator(isShow: false)
            switch(response.result) {
            case .success(_):
                
                if response.result.value != nil{
                    print("response\(response)")
                    
                    let json = try! JSON(data: response.data!)
                    if  response.response?.statusCode == 401{
                        
                        if (authSessionHandler != nil){
                            
                            if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                authSessionHandler!(self.authSessionObj)
                            }else{
                                authSessionHandler!(json)
                            }

                        }
                    }
                    else {
                        //response.response?.statusCode == 200
                        if (successHandler != nil){
                            
                            successHandler!(json)
                            
  
                        }
                        
                    }
                }
                break
                
            case .failure(_):
                if (failureHandler != nil){
                    failureHandler!(response.result.error!)
                }
                
                break
                
            }
            
            }.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                
                if (progressHandler != nil){
                    
                    progressHandler!(progress.fractionCompleted)
                }
            }.resume()
        
        self.backgroundManager.delegate.sessionDidFinishEventsForBackgroundURLSession = {
            session in
            
            // record the fact that we're all done moving stuff around
            // now, call the saved completion handler
            self.backgroundCompletionHandler?()
            self.backgroundCompletionHandler = nil
        }
        
        self.backgroundManager.backgroundCompletionHandler = {
            // finshed task
        }
  
    }
    //MARK:- httpGetRequest -
    func httpGet(request api:String!,params:[String:Any]?,headers: HTTPHeaders? = nil ,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil ,authSessionHandler:ServerSessionFailureCallBck? = nil){
        
        sessionManager.request(api, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            self.showNetIndicator(isShow: false)
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print("response\(response)")
                    let json = try! JSON(data: response.data!)
                    if  response.response?.statusCode == 401{
                        
                        if (authSessionHandler != nil){
                            
                            if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                if (authSessionHandler != nil){
                                    authSessionHandler!(self.authSessionObj)
                                }
                                
                            }else{
                                if (authSessionHandler != nil){
                                    authSessionHandler!(json)
                                }
                                
                            }

                        }
                    }
                    else {
                        //response.response?.statusCode == 200
                        if (successHandler != nil){
                            
                            successHandler!(json)
 
                        }
                        
                    }
                }
                break
                
            case .failure(_):
                if (failureHandler != nil){
                    failureHandler!(response.result.error!  )
                }
                
                break
                
            }
            
            }.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                if (progressHandler != nil){
                    
                    progressHandler!(progress.fractionCompleted)
                }
            }.resume()
        
        
    }
    //MARK:- httpUploadRequest -
    func httpUpload(api:String!,params:[String:Any]?,headers: HTTPHeaders? = nil ,multipartObject :[MultipartData]?,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
        if (multipartObject != nil) {
            sessionManager.upload(multipartFormData: { (multipartFormData) in
                if let mediaList  = multipartObject
                {
                    for object in mediaList
                    {
                        
                        multipartFormData.append(object.media, withName: object.mediaUploadKey, fileName: object.fileName, mimeType: object.mimType)
                        
                    }
                }
                
                
                if (params != nil){
                    for (key, value) in params! {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
            }, to: api,headers:headers, encodingCompletion: { (result) in
                self.showNetIndicator(isShow: false)
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                        if (progressHandler != nil){
                            progressHandler!(Progress.fractionCompleted)
                        }
                    })
                    upload.resume()
                    
                    upload.responseJSON { response in
                        if response.result.value != nil{
                            print("response\(response)")
                            let json = try! JSON(data: response.data!)
                            if  response.response?.statusCode == 401{
                                
                                if (authSessionHandler != nil){
                                    
                                    
                                    if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                        authSessionHandler!(self.authSessionObj)
                                    }else{
                                        authSessionHandler!(json)
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                            else {
                                //response.response?.statusCode == 200
                                if (successHandler != nil){
                                    
                                    
                                    successHandler!(json)
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    
                case .failure(let encodingError):
                    if (failureHandler != nil){
                        failureHandler!(encodingError as NSError )
                    }
                }
            })
        }else{
            
            self.httpPost(request: api, params: params,headers: headers, successHandler: successHandler, failureHandler: failureHandler, progressHandler: progressHandler, authSessionHandler: authSessionHandler)
        }
        
        
        
    }
    //MARK:- httpDownloadRequest -
    func httpDownload(request api:String! ,enableBackGroundTask isBackground:Bool = false ,successHandler:@escaping (_ destinationURL:URL?)->Void,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
        print("\(api!)")
        guard let fileUrl  = URL(string: "\(api!)") else {
            
            if (failureHandler != nil){
                
                let errorTemp = CustomError(localizedTitle: "file url incorrect", localizedDescription: "file url incorrect", code: 500)
                failureHandler!(errorTemp )
            }
            return
        }
        
        
        
        let request = URLRequest(url: fileUrl)
        
        let destination: DownloadRequest.DownloadFileDestination = { filePath,response in
            
            let directory : NSURL = (self.documentsDirectoryURL as NSURL)
            
            let fileURL =   directory.appendingPathComponent(response.suggestedFilename!)!
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        if  isBackground
        {
            backgroundManager.download(request, to: destination).response(completionHandler: { (response:DefaultDownloadResponse) in
                self.showNetIndicator(isShow: false)
                if response.error != nil{
                    if (failureHandler != nil){
                        failureHandler!(response.error! as NSError )
                    }
                }
                else{
                    if  response.response?.statusCode == 200{
                        
                        successHandler(response.destinationURL)
                        
                    }else if response.response?.statusCode == 401{
                        if (authSessionHandler != nil){
                            authSessionHandler!(self.authSessionObj)
                        }
                        
                    }
                }
                
            }).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                if (progressHandler != nil){
                    
                    progressHandler!(progress.fractionCompleted)
                }
                }.resume()
        }else{
            
            sessionManager.download(request, to: destination).response(completionHandler: { (response:DefaultDownloadResponse) in
                self.showNetIndicator(isShow: false)
                if response.error != nil{
                    if (failureHandler != nil){
                        failureHandler!(response.error! as NSError )
                    }
                }
                else{
                    print("response\(response)")
                    if  response.response?.statusCode == 200{
                        
                        successHandler(response.destinationURL)
                        
                    }else if response.response?.statusCode == 401{
                        if (authSessionHandler != nil){
                            authSessionHandler!(self.authSessionObj)
                        }
                        
                    }
                }
                
            }).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
                if (progressHandler != nil){
                    
                    progressHandler!(progress.fractionCompleted)
                }
                }.resume()
            
            
        }
        
        
        
    }
    //MARK:- httpBackgroundTaskRequest-
    func httpBackgroundTaskRequest(api:String!,params:[String:Any]?,multipartObject :[MultipartData]? ,httpMethod ispostMethod:Bool = true,headers: HTTPHeaders? = nil,successHandler:ServerSuccessCallBack?,failureHandler:ServerFailureCallBack?,progressHandler:ServerProgressCallBack? = nil,authSessionHandler:ServerSessionFailureCallBck? = nil){
        
        let method:HTTPMethod = ispostMethod == true ? .post : .get
        if (multipartObject != nil) && (multipartObject?.count)! > 0 {
            backgroundManager.upload(multipartFormData: { (multipartFormData) in
                if let mediaList  = multipartObject
                {
                    for object in mediaList
                    {
                        multipartFormData.append(object.media, withName: object.mediaUploadKey, fileName: object.fileName, mimeType: object.mimType)
                    }
                }
                if (params != nil){
                    for (key, value) in params! {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
            }, to: "\(api!)",headers:headers, encodingCompletion: { (result) in
                self.showNetIndicator(isShow: false)
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                        if (progressHandler != nil){
                            progressHandler!(Progress.fractionCompleted)
                        }
                    })
                    upload.resume()
                    upload.responseJSON { response in
                        if response.result.value != nil{
                            print("response\(response)")
                            let json = try! JSON(data: response.data!)
                            if  response.response?.statusCode == 401{
                                
                                if (authSessionHandler != nil){
                                    
                                    
                                    if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                        authSessionHandler!(self.authSessionObj)
                                    }else{
                                        authSessionHandler!(json)
                                    }

                                }
                            }
                            else {
                                
                                //response.response?.statusCode == 200
                                if (successHandler != nil){
 
                                    successHandler!(json)

                                }
                                
                            }
                            
                        }
                    }
                    
                case .failure(let encodingError):
                    if (failureHandler != nil){
                        failureHandler!(encodingError as NSError )
                    }
                }
            })
            
            backgroundManager.delegate.sessionDidFinishEventsForBackgroundURLSession = {
                session in
                
                // record the fact that we're all done moving stuff around
                // now, call the saved completion handler
                self.backgroundCompletionHandler?()
                self.backgroundCompletionHandler = nil
            }
            
            backgroundManager.backgroundCompletionHandler = {
                // finshed task
            }
        }else{
            backgroundManager.request("\(api!)", method: method, parameters: params, headers: headers).responseJSON { (response:DataResponse<Any>) in
                self.showNetIndicator(isShow: false)
                switch(response.result) {
                    
                case .success(_):
                    if response.result.value != nil{
                        print("response\(response)")
                        let json = try! JSON(data: response.data!)
                        if  response.response?.statusCode == 401{
                            
                            if (authSessionHandler != nil){
                                
                                if json["Message"].stringValue ==  FieldValidation.kAuthorizationDenied{
                                    authSessionHandler!(self.authSessionObj)
                                }else{
                                    authSessionHandler!(json)
                                }

                                
                            }
                        }
                        else {
                            //response.response?.statusCode == 200
                            if (successHandler != nil){
                                
                                successHandler!(json)
       
                            }
                            
                        }
                        
                    }
                    break
                    
                case .failure(_):
                    if (failureHandler != nil){
                        failureHandler!(response.result.error! )
                    }
                    
                    break
                    
                }
                
                }.downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    if (progressHandler != nil) {
                        
                        progressHandler!(progress.fractionCompleted)
                        
                    }
                }.resume()
            
            backgroundManager.delegate.sessionDidFinishEventsForBackgroundURLSession = {
                session in
                
                // record the fact that we're all done moving stuff around
                
                // now, call the saved completion handler
                
                self.backgroundCompletionHandler?()
                self.backgroundCompletionHandler = nil
            }
            
        }
        
    }
    
    
}
//MARK: - AppUtility -

class AppUtility:NSObject{
    
    
    
    class func UUIDString()->String
    {
        let keychain :Keychain = Keychain(service: Bundle.main.bundleIdentifier!)
        var retrievedString: String? = try? keychain.getString(kDeviceID) ?? ""
        if (retrievedString == nil || (retrievedString?.isEmpty)!)
        {
            try? keychain.set((UIDevice.current.identifierForVendor?.uuidString)!, key: kDeviceID)
            
            retrievedString = try? keychain.getString(kDeviceID) ?? ""
        }
        return  retrievedString!
        
        
    }
    class func removeUUIDString()->Bool
    {
        let keychain =   Keychain(service: Bundle.main.bundleIdentifier!)
        
        let retrievedString: String? =  try? keychain.getString(kDeviceID)  ?? ""
        if (retrievedString != nil)
        {
            do {
                try keychain.remove(kDeviceID)
                return true
            } catch let error {
                print("error: \(error)")
                return false
            }
            
            
            
        }
        else
        {
            return false
        }
        
    }
    //MARK:- mimeTypeForPath-
    class func mimeType(forPath filePath:URL)->String
    {
        var  mimeType:String;
        
        let fileExtension:CFString = filePath.pathExtension as CFString
        let UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, nil);
        let str = UTTypeCopyPreferredTagWithClass(UTI!.takeUnretainedValue(), kUTTagClassMIMEType);
        if (str == nil) {
            mimeType = "application/octet-stream";
        } else {
            mimeType = str!.takeUnretainedValue() as String
        }
        return mimeType
    }
    //MARK:- filename-
    class func filename(Prefix:String , fileExtension:String)-> String
    {
        let dateformatter=DateFormatter()
        dateformatter.dateFormat="MddyyHHmmss"
        let dateInStringFormated=dateformatter.string(from: Date() )
        return "\(Prefix)_\(dateInStringFormated).\(fileExtension)"
    }
    //MARK:- getJsonObjectDict-
    class func getJsonObjectDict(responseObject:Any)->[String:Any]
    {
        var anyObj :[String:Any]!
        do
        {
            anyObj = try JSONSerialization.jsonObject(with: (responseObject as! NSData) as Data, options: []) as! [String:Any]
            // use anyObj here
            return anyObj!
            
        } catch  {
            print("json error: \(error)")
        }
        return anyObj!
    }
    //MARK:- getJsonObjectArray-
    class func JSONArray(responseObject:Any)->[Any]
    {
        
        var anyObj :[Any] = [Any]()
        do
        {
            anyObj = try JSONSerialization.jsonObject(with: (responseObject as! NSData) as Data, options: []) as! [Any]
            // use anyObj here
            return anyObj
            
        } catch  {
            print("json error: \(error)")
        }
        return anyObj
    }
    //MARK:- JSONStringify-
    class func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String
    {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        if JSONSerialization.isValidJSONObject(value)
        {
            if let data = try? JSONSerialization.data(withJSONObject: value, options: options)
            {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                {
                    return string as String
                }
            }
        }
        return ""
    }
    //MARK:- getJsonData-
    class func JSONData(responseObject:Any)->Data
    {
        
        var data :Data!
        do
        {
            data = try JSONSerialization.data(withJSONObject: responseObject, options: [])
            // use anyObj here
            return data!
            
        } catch  {
            print("json error: \(error)")
        }
        return data!
    }
    
    //MARK: - getfileFromDirectory-
    class func getlocalfile( filename:String , OnCompletion:(_ filepath:URL? , _ isfileExists:Bool ,_ filemanager:FileManager)->Void){
        
        
        let filemanager =  FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        
        if let dirPath = paths.first {
            let fileurl =  URL(fileURLWithPath: dirPath).appendingPathComponent("\(filename)")
            if filemanager.fileExists(atPath: fileurl.path) {
                OnCompletion(fileurl,true,filemanager)
                return
            }else{
                OnCompletion(nil,false,filemanager)
            }
        }
        
    }
    //MARK: - deletefileFromDirectory-
    class func deletelocalfile( filename:String, OnCompletion:(_ success:Bool)->Void){
        
        self.getlocalfile(filename: filename) { (destinationURL:URL?, isfileExists:Bool, filemanager:FileManager) in
            
            if isfileExists == true ,(destinationURL != nil)  {
                do{
                    
                    try filemanager.removeItem(at: destinationURL!)
                    OnCompletion(true)
                }catch {
                    OnCompletion(false)
                }
            }else{
                OnCompletion(false)
            }
        }
        
        
        
        
    }
    
    
}

public enum ImageQuality : Int {
    case `default`
    case highest
    case high
    case medium
    case low
    case lowest
}
struct Base64DataModel {
    var base64String:String!
    var mediaUploadKey:String!
    var fileName:String!
    var pathExtension:String!
    
    init(image:UIImage,fileName:String? = nil,mediaKey uploadKey:String!,quality:ImageQuality = .default) {
        
        let imagedata :Data?
        switch quality{
        case .highest:
            imagedata = image.highestQualityJPEGNSData
        case .high:
            imagedata = image.highQualityJPEGNSData
        case .medium:
            imagedata = image.mediumQualityJPEGNSData
        case .low:
            imagedata = image.lowQualityJPEGNSData
        case .lowest:
            imagedata = image.lowestQualityJPEGNSData
        default:
            imagedata = image.uncompressedPNGData
            
        }
        
        
        guard let data  = imagedata else {return}
        self.base64String = data.base64EncodedString()
        self.pathExtension = quality == .default ? "png" : "jpeg"
        self.mediaUploadKey = uploadKey
        if let filename = fileName{
            
            self.fileName = filename
            
        }else{
            self.fileName = AppUtility.filename(Prefix: "image", fileExtension:  self.pathExtension)
        }
    }
    
    init(file:Any!,fileName:String? = nil,mediaKey uploadKey:String!,quality:ImageQuality = .default) {
        
        if  let filepath = file as? String{
            let url = NSURL.fileURL(withPath: filepath)
            self.pathExtension = url.pathExtension
            self.fileName = url.lastPathComponent
            let media = try! Data(contentsOf: url)
            self.base64String = media.base64EncodedString()
            
        }else if  let fileurl = file as? URL {
            self.pathExtension = fileurl.pathExtension
            self.fileName = fileurl.lastPathComponent
            let media = try! Data(contentsOf: fileurl)
            self.base64String = media.base64EncodedString()
        }
        self.mediaUploadKey = uploadKey
        
    }
    
}
//MARK:- MultipartData
class MultipartData: NSObject
{
    
    var media:Data!
    var mediaUploadKey:String!
    var fileName:String!
    var mimType:String!
    var pathExtension:String!
    init(medaiObject object:Any!,fileName:String? = nil,mediaKey uploadKey:String!,isPNG:Bool = true) {
        if (object != nil) , (uploadKey != nil) {
            if  object is UIImage {
                if let imageObject = object as? UIImage {
                    self.media =  isPNG == true ? imageObject.uncompressedPNGData : imageObject.lowQualityJPEGNSData//UIImagePNGRepresentation(imageObject)
                    self.mimType =  isPNG == true ? "image/png" : "image/jpeg"
                    self.pathExtension = isPNG == true ? "png" : "jpeg"
                    if let filename = fileName{
                        self.fileName = filename
                        
                    }else{
                        self.fileName = AppUtility.filename(Prefix: "image", fileExtension:  self.pathExtension)
                    }
                    
                }
                
            }else{
                
                if  let filepath = object as? String{
                    
                    let url = NSURL.fileURL(withPath: filepath)
                    self.pathExtension = url.pathExtension
                    self.fileName = url.lastPathComponent
                    self.media = try! Data(contentsOf: url) //NSData(contentsOf: url)
                    self.mimType = AppUtility.mimeType(forPath: url )
                    
                }else if  let fileurl = object as? URL {
                    self.pathExtension = fileurl.pathExtension
                    self.fileName = fileurl.lastPathComponent
                    
                    self.media = try! Data(contentsOf: fileurl) //NSData(contentsOf: url)
                    self.mimType = AppUtility.mimeType(forPath: fileurl )
                }
                
            }
            self.mediaUploadKey = uploadKey
        }
        
    }
    
    override init()
    {
        super.init()
        
    }
    required init(coder aDecoder: NSCoder) {
        
        if let media = aDecoder.decodeObject(forKey: "mediaData") as? Data {
            
            self.media = media
        }
        if let mediaUploadKey = aDecoder.decodeObject(forKey: "mediaUploadKey") as? String {
            
            self.mediaUploadKey = mediaUploadKey
        }
        if let fileName = aDecoder.decodeObject(forKey: "fileName") as? String {
            
            self.fileName = fileName
        }
        if let mimType = aDecoder.decodeObject(forKey: "mimType") as? String {
            
            self.mimType = mimType
        }
        
    }
    open func encodeWithCoder(_ aCoder: NSCoder)
    {
        if let media = self.media{
            aCoder.encode(media, forKey: "media")
        }
        if let mediaUploadKey = self.mediaUploadKey {
            aCoder.encode(mediaUploadKey, forKey: "mediaUploadKey")
        }
        if let fileName = self.fileName {
            aCoder.encode(fileName, forKey: "fileName")
        }
        if let mimType = self.mimType {
            aCoder.encode(mimType, forKey: "mimType")
        }
        
    }
    
}


protocol OurErrorProtocol: Error {
    
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}
struct CustomError: OurErrorProtocol {
    
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}
