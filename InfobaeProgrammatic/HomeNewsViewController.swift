//
//  HomeNewsViewController.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 25/01/2022.
//

import UIKit

class HomeNewsViewController: UIViewController {
    lazy var logoNavigationBar = createLogoNavigationBar()
    lazy var homeNewTableView = UITableView(frame: .zero)
    
    let reuseIdentifier = "id"
//    var infoNewTableViewCellArray: [InfoNew] = [InfoNew(imageName: "new", titleText: "Mercados: Wall Street retoma las fuertes pérdidas y vuelve a arrastrar a bonos y acciones argentinas", descriptionText: "Mientras que los indicadores de las bolsas de Nueva York recortan más de 2%, los ADR caen hasta 5% y los bonos Globales un 0,2%. El riesgo país cede a 1.955 puntos"), InfoNew(imageName: "new", titleText: "Rusia redobla la amenaza sobre Ucrania con maniobras navales, aéreas y terrestres en la frontera sur", descriptionText: "El gobierno de Vladimir Putin resaltó que las operaciones en los mares Negro y Caspio, y en la península anexada de Crimea cuentan con 6.000 tropas, aviones caza, bombarderos y navíos de flotas. El ejército ensaya ataques con misiles a la “mayor distancia posible"), InfoNew(imageName: "new", titleText: "Marta Cohen habló de la cifra de contagios en Argentina", descriptionText: "La patóloga pediátrica argentina que vive y trabaja en Reino Unido indicó que la tasa de positividad, que en Argentina supera el 60%, debe ser menor al 10% para ser adecuada")]

    var infoNewTableViewCellArray = [InfoNew]()
    
    func createLogoNavigationBar() -> UIImageView {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "logo")
        return imageview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeApiCall (completed: { [weak self] result in
            switch result {
            case .success(let newsFeed):
                for article in newsFeed.articles {
                    let infoNews = InfoNew(imageName: article.urlToImage, titleText: article.title, descriptionText: article.description)
                    self?.infoNewTableViewCellArray.append(infoNews)
                    self?.homeNewTableView.reloadData()
                }
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
        
        homeNewTableView.register(DescriptionNewTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        homeNewTableView.dataSource = self
        homeNewTableView.delegate = self
    }
    
    @objc func onTappedSettingNavigationBar() {
        //To do
    }
    
    @objc func onTappedSearchNavigationController() {
        //To do
    }
    
    func makeApiCall(completed: @escaping(Result<NewsFeed,Error>) -> ()) {
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
        let newCell: DescriptionNewTableViewCell = homeNewTableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DescriptionNewTableViewCell
        let infoNew: InfoNew = infoNewTableViewCellArray[indexPath.row]
        
        newCell.imageName = infoNew.imageName
        newCell.titleNew.text = infoNew.titleText
        newCell.descriptionNew.text = infoNew.descriptionText
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



