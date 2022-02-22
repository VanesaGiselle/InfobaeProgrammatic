//
//  HomeNewsViewController.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 25/01/2022.
//

import UIKit

class HomeNewsViewController: UIViewController {
    lazy var homeNewTableView = UITableView(frame: .zero)
    var infoNewTableViewCellArray = [InfoNew]()
    
    lazy var logoNavigationBar: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo")
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoNew (completed: { [weak self] result in
            switch result {
            case .success(let newsFeed):
                for article in newsFeed.articles {
                    guard let articleTitle = article.title, let articleDescription = article.description, let articleImageUrl = article.urlToImage else {
                        return
                    }
                    let infoNews = InfoNew(titleText: articleTitle, descriptionText: articleDescription, imageUrlString: articleImageUrl)
                    self?.infoNewTableViewCellArray.append(infoNews)
                }
                self?.homeNewTableView.reloadData()
            case .failure(let error):
                print("Fallo")
            }
        })

        setupHomeNewNavigationBar()
        setupNewTableView()
        self.view.backgroundColor = .white
    }
    
    func setupHomeNewNavigationBar() {
        self.navigationItem.titleView = logoNavigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings-icon"), style: .done, target: self, action: #selector(onTappedSettingNavigationBar))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onTappedSearchNavigationController))
    }
    
    func setupNewTableView() {
    
        homeNewTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(homeNewTableView)
        
        NSLayoutConstraint.activate([
            homeNewTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            homeNewTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            homeNewTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            homeNewTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        homeNewTableView.register(NewTableViewCell.self, forCellReuseIdentifier: NewTableViewCell.reuseIdentifier)
        homeNewTableView.dataSource = self
        homeNewTableView.delegate = self
    }
    
    @objc func onTappedSettingNavigationBar() {
        //To do
    }
    
    @objc func onTappedSearchNavigationController() {
        //To do
    }
    
    func getInfoNew(completed: @escaping(Result<NewsFeed,Error>) -> ()) {
        let urlString: String = "https://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=93b8b11c68d2442480ee3d735da6d1d1"

        let url = URL(string: urlString)
        
        guard let urlOk = url else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlOk) { (data, response, error) in

            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                    DispatchQueue.main.async {
                        completed(.success(newsFeed))
                    }
                }
                
                catch {
                    completed(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}

extension HomeNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoNewTableViewCellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell: NewTableViewCell = homeNewTableView.dequeueReusableCell(withIdentifier: NewTableViewCell.reuseIdentifier) as! NewTableViewCell
        let infoNew: InfoNew = infoNewTableViewCellArray[indexPath.row]
        
        guard let imageUrl = URL(string: infoNew.imageUrlString) else {
            return UITableViewCell()
        }
        
        let viewModel = NewTableViewCell.ViewModel(titleText: infoNew.titleText, descriptionText: infoNew.descriptionText, imageUrl: imageUrl)
        
        newCell.render(viewModel: viewModel)
        return newCell
    }
}

extension HomeNewsViewController: UITableViewDelegate {
    
}

class SectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class AlertViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

class SavedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

