//
//  ViewController.swift
//  Appitune
//
//  Created by Toan on 7/7/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit
import Stevia
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    let table : UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        return table
    }()
    
     
    var SeachBar :UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-20, height: 20))
    var myVideo = [MyVideo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.sv(table)
        view.layout(-50,|-0-table.width(UIScreen.main.bounds.width)-0-|,0)
        table.delegate = self
        table.dataSource = self
        SeachBar.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: SeachBar)
    }
    func getdata(searchText :String){
       
        let url = String(format: "https://itunes.apple.com/search?term=%@&limit=20", searchText)
        AF.request(url, method: .get).responseJSON { [weak self](responds) in
            guard let StrongSelf = self else {return}
            switch responds.result {
                        case .success(let Value):
                            if let data = Video(JSON(Value)) {
                                print(data.count)
                                StrongSelf.myVideo = data.results
                                StrongSelf.table.reloadData()
                                
                                for item in data.results {
                                    print(item.artistName,item.artworkUrl100)
                                    
                                }
                            
                            }
            
                        case .failure(let error):
                            print(error)
                        
                        }
        }
    }

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myVideo.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
//    let artistName, trackName: String
//       let previewURL: String
//       let  artworkUrl100: String
//       let  trackPrice: Double
//     let country,primaryGenreName: String
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.artisNamelabel.text = myVideo[indexPath.row].artistName
        cell.artworkUrl100Image.downloaded(from: myVideo[indexPath.row].artworkUrl100 , contentMode: .scaleAspectFit)
        cell.trackPrice.text = String(myVideo[indexPath.row].trackPrice)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = playVideoViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.url = myVideo[indexPath.row].previewURL
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getdata(searchText: searchText)
        self.table.reloadData()
    }
}


