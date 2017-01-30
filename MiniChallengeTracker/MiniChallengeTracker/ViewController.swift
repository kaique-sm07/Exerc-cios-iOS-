//
//  ViewController.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/22/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        // call super
        super.viewDidLoad()
        
        // create new Challenge
        if (ChallengeServices.isEmpty()){
            ChallengeServices.createChallenge("Beyond Hello World", duration:10, startDate:NSDate(), endDate:NSDate(timeIntervalSinceReferenceDate: 1000) )
            GroupServices.createGroup("ACME", people: 4, desc: "Nunca teve problemas para dividir o uma conta depois de uma noite no bar ou jantar em um restaurante? Com BarBill , isso não vai acontecer novamente . Cada vez que alguém na mesa pedir algo , você insere o produto com seu preço e quantidade, ainda mais fácil se ele já foi pedido antes, escolhe com quem compartilhá-lo , e pronto ! Você pode verificar o quanto cada pessoa gastou , e quanto é o total da conta. Quando alguém decide sair , o aplicativo mostra o quanto eles devem pagar .", challenge: ChallengeServices.searchByName("Beyond Hello World"))
        }
        
        

        // remove this challenge
        ChallengeServices.deleteChallegeByName("Beyond Hello World")
    }

}

