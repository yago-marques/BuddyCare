//
//  AnimationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 23/06/23.
//

import Foundation


extension PetManagerView {

    func petIdleAnimation() {
        var index = 1
        var framesNumber = 0
        _ = Timer.scheduledTimer(withTimeInterval: 0.11, repeats: true) { (Timer) in

            //mockado enquanto não tem o valor associado a um pet
            petSprite = "\(viewModel.pet?.avatar ?? "CaramelDog")\(index)"
            framesNumber = viewModel.pet?.species == .cat ? 8 : 5

            index += 1
            if (index > framesNumber){
                index = 1
            }
        }
    }

    func stinkingPetAnimation() {
        var index = 1
        var framesNumber = 0
        _ = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { (Timer) in

            switch viewModel.pet?.avatar {
                case "CaramelDog":
                    petSprite = "StinkyCaramelDog\(index)"
                    framesNumber = 5
                case "BlackDog":
                    petSprite = "StinkyBlackDog\(index)"
                    framesNumber = 5
                case "WhiteDog":
                    petSprite = "StinkyWhiteDog\(index)"
                    framesNumber = 5
                case "OrangeCat":
                    petSprite = "StinkyOrangeCat\(index)"
                    framesNumber = 8
                case "BlackCat":
                    petSprite = "StinkyBlackCat\(index)"
                    framesNumber = 8
                case "WhiteCat":
                    petSprite = "StinkyWhiteCat\(index)"
                    framesNumber = 8
                default:
                    break
            }

            index += 1
            if (index > framesNumber){
                index = 1

            }
        }
    }

    func ssleepingPetAnimation() {
        var index = 1
        _ = Timer.scheduledTimer(withTimeInterval: 0.29, repeats: true) { (Timer) in

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
