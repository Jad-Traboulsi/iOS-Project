//
//  ViewController.swift
//  ios proj
//
//  Created by Epita on 18/01/2022.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var countriesToDisp:[Country]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData(urlString: "https://restcountries.com/v2/all") {(countries) in
            for country in countries{
                self.countriesToDisp.append(country)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        searchBar.delegate=self
        tableView.delegate=self
        tableView.dataSource=self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    func containsOnlyLetters(input: String) -> Bool {
       for chr in input {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
             return false
          }
       }
       return true
    }
    func fetchData (urlString:String,completionHandler: @escaping ([Country])->Void){
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do{
                let data = try JSONDecoder().decode([Country].self,from:data)
                    completionHandler(data)
            }catch{
                let error = error
                print(error.localizedDescription)
            }

        }.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        self.countriesToDisp = []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if(!containsOnlyLetters(input:searchText) || searchText == ""){
            
            fetchData(urlString: "https://restcountries.com/v2/all"){(countries) in
                for country in countries{
                    self.countriesToDisp.append(country)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        else{
            fetchData(urlString: "https://restcountries.com/v2/name/\(searchText)"){(countries) in
                for country in countries{
                    self.countriesToDisp.append(country)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
    



extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.countrySelected = countriesToDisp[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countriesToDisp.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell") as! CountryTVC
        if(!countriesToDisp.isEmpty)
        {
            cell.countryName.text=countriesToDisp[indexPath.row].name
            cell.countryAlpha.text=countriesToDisp[indexPath.row].alpha2Code
            cell.countryImg.contentMode = .scaleAspectFill
            cell.countryImg.downloaded(from:countriesToDisp[indexPath.row].flags!["png"]!)
        
            cell.countryView.layer.cornerRadius = cell.countryView.frame.height/2
            cell.countryImg.layer.cornerRadius = cell.countryImg.frame.height/2
        }
        
        return cell
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

