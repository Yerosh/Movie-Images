//
//  ViewController.swift
//  practice6
//
//  Created by Yernur Adilbek on 10/14/23.
//
import SnapKit
import UIKit

final class ViewController: UIViewController {
    
    private lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie & Images"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let items = ["Image", "Movie"]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundImage = UIImage()
        return searchController
    }()
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var images: [UIImage?] = [UIImage(named: "Image"), UIImage(named: "Image"), UIImage(named: "Image"), UIImage(named: "Image"), UIImage(named: "Image"), UIImage(named: "Image")]
    private var movies: [UIImage?] = [UIImage(named: "Movie"), UIImage(named: "Movie"), UIImage(named: "Movie"), UIImage(named: "Movie"), UIImage(named: "Movie"), UIImage(named: "Movie")]
    private let apiManager = APIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        apiManager.loadImages{ [weak self] images in
            self?.images = images
            self?.myCollectionView.reloadData()
        }
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        setupUI()
    }
    
    @objc func indexChanged(_ segmentedControl: UISegmentedControl){
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            print("case 0")
        case 1:
            print("case 1")
        default:
            break
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        if segmentedControl.selectedSegmentIndex == 0{
            collectionView.reloadData()
            cell.configure(image: images[indexPath.item], text: "Name")
            cell.backgroundColor = UIColor(red: 237/255, green: 248/255, blue: 235/255, alpha: 1.0)
        }else if segmentedControl.selectedSegmentIndex == 1{
            collectionView.reloadData()
            cell.configure(image: movies[indexPath.item], text: "Name")
            cell.backgroundColor = UIColor(red: 30/255, green: 107/255, blue: 223/255, alpha: 0.2)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: view.window!.windowScene!.screen.bounds.width * 0.4 , height: view.window!.windowScene!.screen.bounds.height * 0.15)
        CGSize(width: 178, height: 200)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenImageViewController = FullScreenImageViewController()
        fullScreenImageViewController.configure(image: images[indexPath.item])
            navigationController?.present(fullScreenImageViewController, animated: true)
    }
}

//MARK: - SetupUI
private extension ViewController{
    func setupUI(){
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubview(myLabel)
        view.addSubview(segmentedControl)
        view.addSubview(searchController.searchBar)
        view.addSubview(myCollectionView)
    }
    
    func setupConstraints(){
        myLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints{ make in
            make.top.equalTo(myLabel).offset(45)
            make.centerX.equalTo(myLabel)
            make.width.equalTo(375)
            make.height.equalTo(36)
        }
        
        searchController.searchBar.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.centerX.equalTo(segmentedControl)
            make.trailing.equalTo(segmentedControl).offset(8)
            make.leading.equalTo(segmentedControl).offset(-8)
        }
        
        myCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchController.searchBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
}
