//
//  ViewController.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/14.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        
        // Set Center
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtStudentId: UITextField!
    @IBAction func SignIN(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let sId = txtStudentId.text, let pw = txtPassword.text{
            self.activityIndicatorView.startAnimating()
            defaults.set(sId, forKey: "studentID")
            defaults.set(pw, forKey: "studentPassword")
            API.sharedInstance.login(completion: { (json) in
                defaults.set(json["data"], forKey: "myprofileData")
                self.activityIndicatorView.stopAnimating()
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTBVC") as! MainTBVC
                self.present(viewController, animated: true)
            })
        }
        else{
            print("We need student ID and password")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let defaults = UserDefaults.standard
        if((defaults.string(forKey: "studentID")) != nil){
            txtStudentId.text = defaults.string(forKey: "studentID")
        }
        if((defaults.string(forKey: "studentPassword")) != nil){
            txtPassword.text = defaults.string(forKey: "studentPassword")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

