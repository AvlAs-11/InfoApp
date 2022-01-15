//
//  DetailedViewController.swift
//  InfoApp
//
//  Created by Pavel Avlasov on 12.01.2022.
//

import UIKit
import MapKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var registered: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var favoriteFruit: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var friends: UILabel!
    @IBOutlet weak var greating: UILabel!
    @IBOutlet weak var about: UILabel!
    var infoModel: InfoModel?
    var friendsArray = String()
    var tagsArray = String()
    
    override func viewDidLoad() {
        configureData()
        configureMapView()
        super.viewDidLoad()
    }
  
    private func configureMapView() {
        guard let infoModel = infoModel else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.title = infoModel.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: infoModel.latitude, longitude: infoModel.longitude)
        mapView.addAnnotation(annotation)
        let coords = CLLocationCoordinate2D(latitude: infoModel.latitude, longitude: infoModel.longitude)
        mapView.setCenter(coords, animated: true)
    }
    
    private func configureData() {
        guard let infoModel = infoModel else {
            return
        }
        self.title = infoModel.name
        self.balance.text = "Balance: " + infoModel.balance
        self.address.text = "Address: " + infoModel.address
        self.age.text = "Age: " + String(infoModel.age)
        self.eyeColor.text = "Eye color: " + infoModel.eyeColor
        self.gender.text = "Gender: " + infoModel.gender
        self.company.text = "Company: " + infoModel.company
        self.email.text = "Email: " + infoModel.email
        self.phone.text = "Phone: " + infoModel.phone
        self.about.text = "About: " + infoModel.about
        self.registered.text = "Registered: " + infoModel.registered
        self.greating.text = "Greating: " + infoModel.greating
        self.favoriteFruit.text = "Favorite fruit: " + infoModel.favoriteFruit
        
        for i in infoModel.friends {
            friendsArray += i.name + ", "
        }
        friendsArray.removeLast(2)
        self.friends.text = "Friends: " + friendsArray
        for i in infoModel.tags {
            tagsArray += i + ", "
        }
        tagsArray.removeLast(2)
        self.tags.text = "Tags: " + tagsArray
    }
}

extension DetailedViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "MapViewAnnotation"
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            return annotationView
    }
}
