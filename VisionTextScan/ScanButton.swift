//
//  ScanButton.swift
//  VisionTextScan
//
//  Created by demothreen on 14.10.2020.
//

import UIKit

class ScanButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
		prepare()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func prepare() {
		translatesAutoresizingMaskIntoConstraints = false
		setTitle("Scan", for: .normal)
		titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
		titleLabel?.textColor = .white
		layer.cornerRadius = 7.0
		backgroundColor = UIColor.systemOrange
	}
}
