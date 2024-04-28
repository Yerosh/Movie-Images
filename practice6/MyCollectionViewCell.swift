//
//  MyCollectionViewCell.swift
//  practice6
//
//  Created by Yernur Adilbek on 10/14/23.
//

import UIKit
import SnapKit

final class MyCollectionViewCell: UICollectionViewCell {
    func configure(image: UIImage?, text: String?){
        imageView.image = image
        label.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
}

// MARK: - setting iui methods
private extension MyCollectionViewCell {
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(label)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalTo(178)
            make.height.equalTo(154)
            make.top.leading.trailing.equalToSuperview()
        }
        
        label.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.width.equalTo(178)
            make.height.equalTo(46)
            make.top.equalTo(imageView.snp.bottom)
        }
    }
}
