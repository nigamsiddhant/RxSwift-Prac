//
//  VerifyEmail.swift
//  Matrix
//
//  Created by Siddhant Nigam on 02/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import UIKit

protocol EmailSubmitted: class {
    func emailSubmitted(success: Bool, emailId: String)
}

class VerifyEmail: UIViewController {
    var delegate: EmailSubmitted?
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        self.submitButton.clipsToBounds = true
        self.submitButton.layer.cornerRadius = 15
    }
    
    @IBAction func submitAction(_ sender: Any) {
        if !UIUtility.isValidEmail(emailStr: emailIdTextField.text ?? "") {
            UIUtility.showWarningAlert("", message: "Please Enter Valid EmailId.")
        }
        else {
            self.delegate?.emailSubmitted(success: true, emailId: emailIdTextField.text ?? "")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
