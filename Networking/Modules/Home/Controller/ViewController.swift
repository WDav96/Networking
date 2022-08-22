//
//  ViewController.swift
//  Networking
//
//  Created by Wilson David Molina Lozano on 18/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - IBActions

    @IBAction func getUserButtonAction(_ sender: Any) {
        getUser(id: 2743)
    }
    @IBAction func postUserButtonAction(_ sender: Any) {
        addUser()
    }
    @IBAction func updateUserButtonAction(_ sender: Any) {
        updateUser()
    }
    @IBAction func deleteUserButtonAction(_ sender: Any) {
        deleteUser()
    }
    
    // MARK: - Life cycle ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        nameLabel.text = ""
        emailLabel.text = ""
        idLabel.text = ""
        activityIndicator.hidesWhenStopped = true
    }

    private func getUser(id: Int) {
        activityIndicator.startAnimating()
        
        APIManager.shared.getUser(id: 4099) { user in
            self.activityIndicator.stopAnimating()
                
            self.setupUser(user: user)
            
        } onFailure: { error in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    private func addUser() {
        let newUser = NewUser(name: "Test03", email: "test03@gmail.com", gender: "Male", status: "Active")
        
        activityIndicator.startAnimating()
        
        APIManager.shared.addUser(user: newUser) { user in
            self.activityIndicator.stopAnimating()
            
            self.setupUser(user: user)
            
        } onFailure: { error in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    private func updateUser() {
        let newUser = NewUser(name: "David 2", email: nil, gender: nil, status: nil)
        
        activityIndicator.startAnimating()
        
        APIManager.shared.updateUser(id: 5182, user: newUser) { user in
            self.activityIndicator.stopAnimating()
            
            self.setupUser(user: user)
            
        } onFailure: { error in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    private func deleteUser() {
        activityIndicator.startAnimating()
        
        let id = 5182
        
        APIManager.shared.deleteUser(id: 5182) {
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = "El usuario con ID \(id) se ha borrado con éxito"
            self.emailLabel.text = ""
            self.idLabel.text = ""
            
        } onFailure: { error in
            self.activityIndicator.stopAnimating()
            
            self.nameLabel.text = error.debugDescription
            
        }
    }
    
    private func setupUser(user: User) {
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.idLabel.text = user.id?.description
    }

}

