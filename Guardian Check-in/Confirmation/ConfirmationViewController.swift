//
//  ConfirmationViewController.swift
//  Guardian Check-in
//
//  Created by Anand Kelkar on 12/11/19.
//  Copyright © 2019 Anand Kelkar. All rights reserved.
//

import Foundation
import UIKit

class ConfirmationViewController : UIViewController {
    
    @IBOutlet weak var mainCardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    @IBOutlet weak var editButton: UIView!
    @IBOutlet weak var confirmButton: UIView!
    static var sname:String?
    static var fname:String?
    static var lname:String?
    static var phone:String?
    static var relation:String?
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        mainCardView.layer.cornerRadius = 10
        mainCardView.layer.shouldRasterize = false
        mainCardView.layer.borderWidth = 1
        
        mainCardView.layer.shadowRadius = 10
        mainCardView.layer.shadowColor = UIColor.black.cgColor
        mainCardView.layer.shadowOpacity = 1
        
        editButton.layer.cornerRadius = 10
        editButton.layer.shouldRasterize = false
        editButton.layer.borderWidth = 1
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.layer.shouldRasterize = false
        confirmButton.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        //Setup starting position for card
        mainCardView.center.x = mainCardView.center.x + self.view.bounds.width
        
        //Swipe right to go back
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        //Tap on edit button
        editButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        
        //Tap on confirm button
        confirmButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(done)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        nameLabel.text = ConfirmationViewController.sname
        fnameLabel.text = ConfirmationViewController.fname
        lnameLabel.text = ConfirmationViewController.lname
        phoneLabel.text = ConfirmationViewController.phone
        relationLabel.text = ConfirmationViewController.relation
        UIView.animate(withDuration: 0.5) {
            self.mainCardView.center.x = self.mainCardView.center.x - self.view.bounds.width
        }
    }
    
    @objc func goBack() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mainCardView.center.x = self.mainCardView.center.x + self.view.bounds.width
        }, completion: { finished in
            AddGuardianViewController.back = true
            self.navigationController?.popViewController(animated: false)
        })
    }
    
    @objc func done() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mainCardView.center.x = self.mainCardView.center.x - self.view.bounds.width
        }, completion: { finished in
            OptionSelectionViewController.fname = self.fnameLabel.text!
            OptionSelectionViewController.comingFromConfirmation = true
            self.performSegue(withIdentifier: "showOptions", sender: self)
        })
    }
    
    
    
    
}