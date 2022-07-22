//
//  FirstViewController.swift
//  Glory_of_Ukraine
//
//  Created by Serhii Palamarchuk on 21.07.2022.
//

import UIKit

class FirstViewController: UICollectionViewController {
    
    static var arrayDetailText = [String]()
    var arrayPersonnel = ArrayPersonnel()
    var arrayEquipment = ArrayEquipment()
    
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveArray()
    }
    
    func receiveArray() {
        NetworkJsonManager.fetchJson(urlString: urlPersonnel, type: ArrayPersonnel.self) { arrayPersonnel in
            self.arrayPersonnel = arrayPersonnel
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        NetworkJsonManager.fetchJson(urlString: urlEquipment, type: ArrayEquipment.self) { arrayEquipment in
            self.arrayEquipment = arrayEquipment
            self.doArrayToDetail()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detail = segue.destination as! DetailView
            let cell = sender as! ArrayCell
            detail.detailIndex = cell.indexDay
            detail.detailText = FirstViewController.arrayDetailText[cell.indexDay]
        }
    }
    
    func doArrayToDetail() {
        for i in 0 ..< arrayPersonnel.count {
            var str = ""
            switch arrayPersonnel[i].welcomePersonnel {
            case .about : str = ">"
            case .more :  str = "<"
            }
            let text = """
Date : \(arrayPersonnel[i].date)
Day : \(arrayPersonnel[i].day)
Personnel : \(str) \(arrayPersonnel[i].personnel)
Prisoner of War : \(arrayPersonnel[i].pow ?? 0)

Aircraft : \(arrayEquipment[i].aircraft)
Helicopter : \(arrayEquipment[i].helicopter)
Tank : \(arrayEquipment[i].tank)
Armored Personnel Carrier : \(arrayEquipment[i].apc)
Multiple Rocket Launcher : \(arrayEquipment[i].mrl)
MilitaryAuto : \(arrayEquipment[i].militaryAuto ?? 0)
Field Artillery : \(arrayEquipment[i].fieldArtillery)
FuelTank : \(arrayEquipment[i].fuelTank ?? 0)
Drone : \(arrayEquipment[i].drone)
Naval Ship : \(arrayEquipment[i].navalShip)
Anti-Aircraft Warfare : \(arrayEquipment[i].antiAircraftWarfare)
Special Equipment : \(arrayEquipment[i].specialEquipment ?? 0)
Mobile SRBM System : \(arrayEquipment[i].mobileSRBMSystem ?? 0)
Greatest Losses Direction : \(arrayEquipment[i].greatestLossesDirection ?? "")
Vehicles and Fuel Tanks : \(arrayEquipment[i].vehiclesAndFuelTanks ?? 0)
Cruise Missiles : \(arrayEquipment[i].cruiseMissiles ?? 0)
"""
            FirstViewController.arrayDetailText.append(text)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPersonnel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArrayCell
        cell.backgroundColor = .yellow
        cell.layer.cornerRadius = sectionInserts.left
        cell.layer.borderWidth = 3
        cell.layer.borderColor = .init(red: 0.1, green: 0.1, blue: 0.95, alpha: 1)
        cell.labelOneLine.text = "Day " + String(arrayPersonnel[indexPath.item].day)
        var str = ""
        switch arrayPersonnel[indexPath.item].welcomePersonnel {
        case .about : str = ">"
        case .more :  str = "<"
        }
        cell.indexDay = indexPath.item
        cell.labelTwoLine.text = str + String(arrayPersonnel[indexPath.item].personnel)
        return cell
    }
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
