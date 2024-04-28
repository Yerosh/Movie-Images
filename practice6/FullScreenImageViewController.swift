//
//  FullScreenImageViewController.swift
//  practice6
//
//  Created by Yernur Adilbek on 10/14/23.
//
import UIKit
import SnapKit

class FullScreenImageViewController: UIViewController {
    func configure(image: UIImage?){
        fullScreenImageView.image = image
    }
    
    private lazy var fullScreenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(fullScreenImageView)
        fullScreenImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
        fullScreenImageView.isUserInteractionEnabled = true
        fullScreenImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissFullScreenImage() {
        dismiss(animated: true)
    }
}
