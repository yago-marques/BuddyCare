//
//  AnimationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 23/06/23.
//

import Foundation

extension PetManagerView {

    func petIdleTimer() {
        var index = 1
        let timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { (Timer) in


            //mockado-------------------------
            petSprite = "CaramelDog\(index)"
            //------------------------------

            // comentei essa linha enquanto o modelo do pet da manager view não tá associado com a persistencia
//            petSprite = "\(viewModel.pet!.avatar)\(index)"

            index += 1
            if (index > 5){
                index = 1
            }
        }
    }

    func stinkingPetAnimation() {
        var index = 1
        let timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { (Timer) in

            switch viewModel.pet?.avatar {
                case "CaramelDog":
                    petSprite = "StinkyCaramelDog\(index)"
                case "BlackDog":
                    petSprite = "StinkyBlackDog\(index)"
                case "WhiteDog":
                    petSprite = "StinkyWhiteDog\(index)"
                case "OrangeCat":
                    petSprite = "StinkyOrangeCat\(index)"
                case "BlackCat":
                    petSprite = "StinkyBlackCat\(index)"
                case "WhiteCat":
                    petSprite = "StinkyWhiteCat\(index)"
                default:
                    break

            }
            index += 1
            if (index > 5){
                index = 1

            }
        }
    }

    func ssleepingPetAnimation() {
        var index = 1
        let timer = Timer.scheduledTimer(withTimeInterval: 0.29, repeats: true) { (Timer) in

            switch viewModel.pet?.avatar {
                case "CaramelDog":
                    petSprite = "SleepingCaramelDog\(index)"
                case "BlackDog":
                    petSprite = "SleepingBlackDog\(index)"
                case "WhiteDog":
                    petSprite = "SleepingWhiteDog\(index)"
                case "OrangeCat":
                    petSprite = "SleepingOrangeCat\(index)"
                case "BlackCat":
                    petSprite = "SleepingBlackCat\(index)"
                case "WhiteCat":
                    petSprite = "SleepingWhiteCat\(index)"
                default:
                    break

            }
            index += 1
            if (index > 3){
                index = 1

            }
        }
    }    
}
