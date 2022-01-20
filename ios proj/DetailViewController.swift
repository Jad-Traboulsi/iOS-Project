//
//  DetailViewController.swift
//  ios proj
//
//  Created by Epita on 20/01/2022.
//

import UIKit

class DetailViewController: UIViewController {
   

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    var countrySelected:Country = Country()
    
    let titles = ["Official Name","Capital","Area","Population","Currency","Region","Timezone","Languages","GPS Position"]
    
    var dataToDisp:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView2.dataSource = self
        tableView2.delegate=self
        
        
        tableView2.separatorStyle = .none
        tableView2.showsVerticalScrollIndicator = false
        
        print(countrySelected)
        
        var currencyString = ""
        if((countrySelected.currencies) != nil){
            
        
        for i in countrySelected.currencies!{
            currencyString+=i.name!+"-"+i.symbol!+", "
        }
            
        currencyString=String(currencyString.dropLast())
        currencyString=String(currencyString.dropLast())
        }
        
        var languagesString = ""
        for i in countrySelected.languages!{
            languagesString+=i.name!+", "
        }
        languagesString=String(languagesString.dropLast())
        languagesString=String(languagesString.dropLast())
        
        
        let gpsString = "[\(countrySelected.latlng![0]),\(countrySelected.latlng![1])]"
        var capital=""
        if(countrySelected.capital != nil){
            capital+=countrySelected.capital!
        }
        
        var area = ""
        if(countrySelected.area != nil){
            area = String(countrySelected.area!)
        }
        
        dataToDisp = [countrySelected.name!,capital,area,String(countrySelected.population!),currencyString,countrySelected.region!,countrySelected.timezones![0],languagesString,gpsString]
    }
    


}

extension DetailViewController: UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "details") as! CountryDetailsTVC
        cell.title.text = titles[indexPath.row]
        cell.info.text = dataToDisp[indexPath.row]
        image.downloaded(from:countrySelected.flags!["png"]!)
        return cell
        
    }
}


