//
//  ApiService.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//


import UIKit
import Alamofire

class ApiService:BaseService{
    static let sharedInstance : ApiService = {
        let instance = ApiService()
        return instance
    }()
    
    fileprivate override init() {
        super.init()
    }
    
    
    func getIndusCount(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"industryCount"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [String:Any]{
                    if let int = data["count"] as? Int{
                        DispatchQueue.global().async {
                            completion(int,nil)
                        }
                    }
                }
            }
        }

    }
    
    func getLiveCount(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"device/live"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [String:Any]{
                    if let int = data["LiveDevice"] as? Int{
                        DispatchQueue.global().async {
                            completion(int,nil)
                        }
                    }
                }
            }
        }
        
    }
    
    
    func getMaxViolatingState(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"exceedance/state"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
    }
    
    func getMaxViolatingCategory(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"exceedance/category"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func getMaxViolatingEffulent(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"exceedance/effluent"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func getMaxViolatingCategoryEmission(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"exceedance/emission"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func getLiveDataFeed(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"feed/category"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var bars = [BarModel]()
                    for i in data{
                        let bar = BarModel()
                        bar.upateModal(i)
                        bars.append(bar)
                    }
                    DispatchQueue.global().async {
                        completion(bars,nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func getStateAlarm(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"alarm/state"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as? [[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
        
    }
    
    
    func getIndustryAlarm(_ completion:@escaping (_ data:Any?,_ error:Error?) -> Void){
        var url = constantUrl+"alarm/category"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as?[[String:Any]]{
                    var pies = [PieModel]()
                    for i in data{
                        let pie = PieModel()
                        pie.upateModal(i)
                        pies.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(pies,nil)
                    }
                }
            }
        }
        
        
    }
    
    func getCategories(_ completion:@escaping (_ data:Any?,_ error:ErrorModal?) -> Void){
        var url = constantUrl+"industryCategory"
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as?[[String:Any]]{
                    var cats = [Category]()
                    for i in data{
                        let pie = Category()
                        pie.updateModal(i)
                        cats.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(cats,nil)
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        
        
    }
    
    func getCategoryDetails(_ id:Int, _ completion:@escaping (_ data:Any?,_ error:ErrorModal?) -> Void){
        var url = constantUrl+"alertRule/category/"+String(id)
        self.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                let response = result as! DataResponse<Any>
                if let data = response.result.value as?[[String:Any]]{
                    var cats = [CategoryDetails]()
                    for i in data{
                        let pie = CategoryDetails()
                        pie.updateModal(i)
                        cats.append(pie)
                    }
                    DispatchQueue.global().async {
                        completion(cats,nil)
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(nil,error )
                }
            }
        }
        
        
    }
    
    func postUserDetailsForVerfication(_ data:[String:String], _ completion:@escaping (_ data:Any?,_ error:ErrorModal?) -> Void){
        let url = constantUrl+"registerAppUser"
        self.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                DispatchQueue.main.async {
                    completion(1,nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        }
        
        
    }
    
    func postVerifyDetails(_ data:[String:String], _ completion:@escaping (_ data:Any?,_ error:ErrorModal?) -> Void){
        let url = constantUrl+"authenticateAppUser"
        self.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: nil) { (result, error) in
            if error == nil{
                DispatchQueue.main.async {
                    completion(1,nil)
                }
            }
            else{
                DispatchQueue.main.async {
                    var error = ErrorModal()
                    error.title = "Error"
                    error.message = "Wrong Verification Code"
                    completion(nil,error)
                }
            }
        }
    }
    
    func postAndUploadImages(_ image:UIImage, _ data:[String:String], _ completion:@escaping (_ data:Any?,_ error:ErrorModal?) -> Void){
        let url = constantUrl+"uploadCpcbImage"
        let parameters : [String:String] =  data
        let imageData = UIImagePNGRepresentation(image)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData {
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded  = \(response)")
                    DispatchQueue.main.async {
                        completion(1,nil)
                    }
                    if let err = response.error{
                        let error = ErrorModal()
                        error.title = "Failed"
                        error.message = err.localizedDescription
                        DispatchQueue.main.async {
                            completion(nil,error)
                        }
                    }
                    
                }
            case .failure(let err):
                let error = ErrorModal()
                error.title = "Failed"
                error.message = err.localizedDescription
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                
            }
        }
    }
    
}
