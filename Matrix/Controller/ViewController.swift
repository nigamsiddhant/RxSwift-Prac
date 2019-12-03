//
//  ViewController.swift
//  Matrix
//
//  Created by Siddhant Nigam on 02/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import UIKit
import PopupDialog
import RxSwift

class ViewController: UIViewController {
    let disposebag = DisposeBag()
    var itemArray = [Details]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        
    }
    
    private func setupView() {
        self.title = "Details"
        self.tableView.separatorStyle = .none
        
        userEmailId()
    }
    
    private func userEmailId() {
        let verifyPopup = VerifyEmail(nibName: "VerifyEmail", bundle: nil)
        verifyPopup.delegate = self
        let popup = PopupDialog(viewController: verifyPopup,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        present(popup, animated: true, completion: nil)
    }
    
    private func getUserDetails(emailId: String) {
        let params = RequestParams(emailId: emailId)
            
            do {
                let paramsDict = try params.asDictionary()
                
                ApiHandler.postApiCall(urlMethod: Constants.K.list, params: paramsDict)!
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { (resData) in
                        print(resData)
                        do {
                            let jsonData = try JSONDecoder().decode(Items.self, from: resData)
                            print(jsonData)
                             self.itemArray = jsonData.items
                            self.tableView.reloadData()
                        }
                        catch {
                            UIUtility.showErrorAlert("", message: error.localizedDescription)
                        }
                    }, onError: { (error) in
                        UIUtility.showErrorAlert("", message: error.localizedDescription)
                    }, onCompleted: {
                        print("Completed")
                        CoreDataHandler.shared.deleteAllData { (success) in
                            if success{
                                CoreDataHandler.shared.addDataToDatabase(details: self.itemArray)
                            }
                        }
                        
                    }) {
                        print("disposed")
                        
                }
            .disposed(by: disposebag)
                
                
            }
            catch {
                UIUtility.showErrorAlert("", message: "Something Went Wrong.")
            }
            
        
    }

    

}

extension ViewController: EmailSubmitted {
    func emailSubmitted(success: Bool, emailId: String) {
        if success {
            if Connectivity.isConnectedToInternet {
                self.getUserDetails(emailId: emailId)
            }
            else {
                self.itemArray = CoreDataHandler.shared.fetchDetails()
                self.tableView.reloadData()
            }
        }
            
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
        cell.selectionStyle = .none
        cell.userData = self.itemArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

