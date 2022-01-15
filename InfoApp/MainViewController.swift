//
//  ViewController.swift
//  InfoApp
//
//  Created by Pavel Avlasov on 11.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewSelector: UISegmentedControl!
    @IBOutlet weak var ageSortButton: UIButton!
    @IBOutlet weak var genderSelector: UISegmentedControl!
    @IBOutlet weak var refreshButton: UIButton!
    private var infoModel = [InfoModel]()
    private var infoTableView: UITableView!
    private var infoCollectionView: UICollectionView!
    private var genderSelectorWasPressed: Bool?
    private var ascending: Bool?
    
    @IBAction func refreshData(_ sender: Any) {
        loadInfo()
        ascending = nil
        genderSelectorWasPressed = nil
        self.ageSortButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)
        switch viewSelector.selectedSegmentIndex {
        case 0:
            genderSelector.selectedSegmentIndex = 0
            self.infoTableView.reloadData()
            break
        case 1:
            genderSelector.selectedSegmentIndex = 0
            self.infoCollectionView.reloadData()
            break
        default:
            break
        }
    }
    @IBAction func changeViewSelector(_ sender: Any) {
        switch viewSelector.selectedSegmentIndex {
        case 0:
            configureTableView()
            self.infoCollectionView.removeFromSuperview()
            self.infoCollectionView = nil
            break
        case 1:
            configureCollectionView()
            self.infoTableView.removeFromSuperview()
            self.infoTableView = nil
            break
        default:
            break
        }
    }

    @objc private func loadInfo() {
        let result = JSONCaller.loadJson()
        self.infoModel = result.compactMap({InfoModel(index: $0.index, balance: $0.balance, age: $0.age, eyeColor: $0.eyeColor, name: $0.name, gender: $0.gender, company: $0.company, email: $0.email, phone: $0.phone, address: $0.address, about: $0.about, registered: $0.registered, latitude: $0.latitude, longitude: $0.longitude, tags: $0.tags, friends: $0.friends, greating: $0.greeting, favoriteFruit: $0.favoriteFruit)
        })
    }
    
    @objc private func sortByAge() {
        guard genderSelectorWasPressed != nil else {
            guard ascending != nil else {
                infoModel = infoModel.sorted(by: {$0.age < $1.age})
                genderSelectorWasPressed = true
                ascending = true
                updateViewInfo()
                return
            }
            return
        }
        switch ascending {
        case true:
            infoModel = infoModel.sorted(by: {$0.age > $1.age})
            ascending = false
            updateViewInfo()
            self.ageSortButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi)

            break
        case false:
            infoModel = infoModel.sorted(by: {$0.age < $1.age})
            ascending = true
            updateViewInfo()
            self.ageSortButton.imageView?.transform = CGAffineTransform(rotationAngle: 0)

            break
        default:
            break
        }
    }
    
    @objc private func sortByGender() {
        loadInfo()
        var sortedInfoModel = [InfoModel]()
        switch genderSelector.selectedSegmentIndex {
        case 0:
            for i in infoModel {
                if i.gender == "male" {
                    sortedInfoModel.append(infoModel[i.index])
                }
            }
            infoModel = sortedInfoModel
            if let check = ascending {
                ascending = !check
                sortByAge()
            }
            break
        case 1:
            for i in infoModel {
                if i.gender == "female" {
                    sortedInfoModel.append(infoModel[i.index])
                }
            }
            infoModel = sortedInfoModel
            if let check = ascending {
                ascending = !check
                sortByAge()
            }
            break
        default:
            break
        }
        guard ascending != nil else {
            updateViewInfo()
            return
        }
    }
    
    private func updateViewInfo() {
        switch viewSelector.selectedSegmentIndex {
        case 0:
            self.infoTableView.reloadData()
            break
        case 1:
            self.infoCollectionView.reloadData()
            break
        default:
            break
        }
    }
   
    private func addTargets() {
        genderSelector.addTarget(self, action: #selector(MainViewController.sortByGender), for: .valueChanged)
        ageSortButton.addTarget(self, action: #selector(MainViewController.sortByAge), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        configureTableView()
        loadInfo()
        addTargets()
        super.viewDidLoad()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
        cell.configure(with: infoModel[indexPath.row])
        return cell
    }
    
    func configureTableView() {
        infoTableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.minY + self.stackView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - self.viewSelector.frame.maxY))
        infoTableView.dataSource = self
        infoTableView.delegate = self
        self.view.addSubview(infoTableView)
        let nib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        infoTableView.register(nib, forCellReuseIdentifier: "InfoTableViewCell")

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testController = storyboard.instantiateViewController(withIdentifier :"DetailedInfo") as! DetailedViewController
        guard let navi = navigationController else {
            return
        }
        testController.infoModel = infoModel[indexPath.row]
        navi.pushViewController(testController, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
        let item = infoModel[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection = 1
        return numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 120)
        infoCollectionView = UICollectionView(frame: CGRect(x: 0, y: self.view.frame.minY + self.stackView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - self.viewSelector.frame.maxY), collectionViewLayout: layout)
        infoCollectionView.dataSource = self
        infoCollectionView.delegate = self
        let nib = UINib(nibName: "InfoCollectionViewCell", bundle: nil)
        infoCollectionView.register(nib, forCellWithReuseIdentifier: "InfoCollectionViewCell")
        self.view.addSubview(infoCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testController = storyboard.instantiateViewController(withIdentifier :"DetailedInfo") as! DetailedViewController
        guard let navi = navigationController else {
            return
        }
        testController.infoModel = infoModel[indexPath.item]
        navi.pushViewController(testController, animated: true)
    }
}


