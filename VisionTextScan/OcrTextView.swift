//
//  OcrTextView.swift
//  VisionTextScan
//
//  Created by demothreen on 14.10.2020.
//

import UIKit

class OcrTextView: UITextView {
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: .zero, textContainer: textContainer)
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
		font = .systemFont(ofSize: 16.0)
		backgroundColor = .white
		textColor = .black
	}
}

