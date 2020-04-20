//
//  SectionHeaderview.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 12.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    private var sectionTitle: String
    private var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(sectionTitle: String) {
        self.sectionTitle = sectionTitle
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        sectionTitleLabel.text = sectionTitle
        addSubview(sectionTitleLabel)
        NSLayoutConstraint.activate([
            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
