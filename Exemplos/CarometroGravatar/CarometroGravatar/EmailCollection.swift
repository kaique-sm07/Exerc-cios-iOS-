//
//  EmailCollection.swift
//  CarometroGravatar
//
//  Created by Augusto Souza on 8/11/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit
import CryptoSwift

class EmailCollection: NSObject {
    static let emails = [
        "augustorsouza@gmail.com",
        "sjordine@yahoo.com.br",
        "marceloreina@gmail.com",
        "limagustavo@gmail.com",
        "xan.marconi@hotmail.com",
        "ale.katao@gmail.com",
        "alfredo.cnt@gmail.com",
        "allinekobayashi@gmail.com",
        "amadeu01@gmail.com",
        "andretavares30@gmail.com",
        "andreschermas@gmail.com",
        "andre.tsuyoshi@gmail.com",
        "andreva65@hotmail.com",
        "andrev.terron@gmail.com",
        "junioracg@gmail.com",
        "arthur-alvarez91@hotmail.com",
        "arthurbrum11@gmail.com",
        "augustomgarcia@gmail.com",
        "brenovinicios23liv@yahoo.com.br",
        "brunoeijioy@gmail.com",
        "brunorochaesilva@gmail.com",
        "caiovpiologo@gmail.com",
        "carloseduardomillani@gmail.com",
        "caiquecayres@hotmail.com",
        "carolbonturi@gmail.com",
        "daniel_mots@hotmail.com",
        "danilobecke@hotmail.com",
        "danilo.marshall@gmail.com",
        "davirdgs@gmail.com",
        "diego.carv@hotmail.com",
        "educarlassara@gmail.com",
        "elias.ayache@gmail.com",
        "erichnp@me.com",
        "erickr.mattos@gmail.com",
        "bzr4@icloud.com",
        "evandro.coutodepaula@gmail.com",
        "fleming.fe@gmail.com",
        "felipedeulalio@hotmail.com",
        "fernando.hm.bastos@gmail.com",
        "francisco.solla@gmail.com",
        "gabrielcarioca23@gmail.com",
        "gabrielmblf@gmail.com",
        "nevesferreira.gabriel@hotmail.com",
        "gabrielashima@gmail.com",
        "giulialeproti@hotmail.com",
        "guilherme.babugia@hotmail.com",
        "gustavo.as88@gmail.com",
        "henriqueamitay@gmail.com",
        "hyahirai@hotmail.com",
        "igoravila93@gmail.com",
        "jean.unicamp@gmail.com",
        "jessicaoliveira3108@gmail.com",
        "jhenifferleonardi@gmail.com",
        "unicampfranco@gmail.com",
        "josestelz@yahoo.com.br",
        "hinostroza.jl@gmail.com",
        "jfonseca345@gmail.com",
        "juliana.jsalgado@gmail.com",
        "juliocgaravelli@yahoo.com.br",
        "kaiquesm07.ksm@gmail.com",
        "kevin.ferreira.silva@gmail.com",
        "leobmaffei@gmail.com",
        "leticiagoncalves2005@gmail.com",
        "lucasbonin369@gmail.com",
        "lucascoiado55@gmail.com",
        "lucaslmoreton@gmail.com",
        "lucas.gabriel_07@outlook.com",
        "lucasjuviniano@gmail.com",
        "lucas.mendonca16@gmail.com",
        "v33p@icloud.com",
        "lucasyukio@gmail.com",
        "luiz.lima925@gmail.com",
        "luiz_hs@hotmail.com.br",
        "marco.antonio.unicamp@gmail.com",
        "marco.gabarron@yahoo.com.br",
        "marcosmko@gmail.com",
        "marcos.scarpim@gmail.com",
        "matheus.botsx@gmail.com",
        "mathrocco@gmail.com",
        "matheus.fcc.faj@gmail.com",
        "nicholas.mizoguchi@gmail.com",
        "ogari.p.pacheco@gmail.com",
        "paula.mzago@gmail.com",
        "pcmassuci@gmail.com",
        "pedrohosantana@gmail.com",
        "pedromenotti@gmail.com",
        "pedrgrijo@gmail.com",
        "pedrotf76@gmail.com",
        "plinio.umezaki@gmail.com",
        "rafael@amithiva.com.br",
        "raphael.orgn@gmail.com",
        "poli.unicamp@gmail.com",
        "renan_geraldo@yahoo.com.br",
        "rene.argento@gmail.com",
        "riczcharf@gmail.com",
        "rodrigo.miyashiro@yahoo.com.br",
        "rodrigopagas@gmail.com",
        "rodrigotakase@gmail.com",
        "rodrigoperezaltieri@gmail.com",
        "sidneyorlovski@gmail.com",
        "thiagocoradi@gmail.com",
        "thiago10.alves@hotmail.com.br",
        "mrocha.vitor@gmail.com"
    ]
    
    static var emailsMd5Hashes: [String] = {
        return emails.map{ (email: String) in
            let sanitizedEmail = email.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let data = sanitizedEmail.dataUsingEncoding(NSUTF8StringEncoding)
            
            if let data = CryptoSwift.Hash.md5(data!).calculate() {
                return data.hexString.lowercaseString
            }
            
            return ""
        }
    }()
}
