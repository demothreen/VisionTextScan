//
//  ScanImageView.swift
//  VisionTextScan
//
//  Created by demothreen on 14.10.2020.
//

import UIKit

class ScanImageView: UIImageView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		prepare()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func prepare() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 7.0
		layer.borderWidth = 1.0
		layer.borderColor = UIColor.systemBlue.cgColor
		backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
		clipsToBounds = true
	}
}
