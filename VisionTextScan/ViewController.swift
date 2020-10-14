//
//  ViewController.swift
//  VisionTextScan
//
//  Created by demothreen on 14.10.2020.
//

import UIKit
import Vision
import VisionKit

class ViewController: UIViewController {
	private var scanButton = ScanButton(frame: .zero)
	private var scanImageView = ScanImageView(frame: .zero)
	private var ocrTextView = OcrTextView(frame: .zero, textContainer: nil)
	private var ocrRequest = VNRecognizeTextRequest(completionHandler: nil)
	private let SCREEN_PADDING: CGFloat = 15
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		configureOCR()
		
		hideKeyboardWhenTappedAround()
	}
	
	private func prepareView() {
		view.backgroundColor = .white
		view.addSubview(scanImageView)
		view.addSubview(ocrTextView)
		view.addSubview(scanButton)
		
		setScanImageView()
		setOcrTextView()
		setScanButton()
	}
	
	private func setScanImageView() {
		let height = view.frame.height*3/5
		NSLayoutConstraint.activate([
			scanImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SCREEN_PADDING),
			scanImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: SCREEN_PADDING),
			scanImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SCREEN_PADDING),
			scanImageView.heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	private func setOcrTextView() {
		let height = view.frame.height*2/5
		NSLayoutConstraint.activate([
			ocrTextView.topAnchor.constraint(equalTo: scanImageView.bottomAnchor, constant: SCREEN_PADDING),
			ocrTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SCREEN_PADDING),
			ocrTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SCREEN_PADDING),
			ocrTextView.heightAnchor.constraint(equalToConstant: height),
		])
	}
	
	private func setScanButton() {
		scanButton.addTarget(self, action: #selector(scanCameraImage), for: .touchUpInside)
		NSLayoutConstraint.activate([
			scanButton.topAnchor.constraint(equalTo: ocrTextView.bottomAnchor, constant: SCREEN_PADDING),
			scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SCREEN_PADDING),
			scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SCREEN_PADDING),
			scanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -SCREEN_PADDING),
			scanButton.heightAnchor.constraint(equalToConstant: 50),
		])
	}
	
	
	@objc private func scanCameraImage() {
		let scanVC = VNDocumentCameraViewController()
		scanVC.delegate = self
		present(scanVC, animated: true)
	}
	
	
	private func processImage(_ image: UIImage) {
		guard let cgImage = image.cgImage else { return }
		
		ocrTextView.text = ""
		scanButton.isEnabled = false
		
		let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		do {
			try requestHandler.perform([self.ocrRequest])
		} catch {
			print(error)
		}
	}
	
	
	private func configureOCR() {
		ocrRequest = VNRecognizeTextRequest { (request, error) in
			guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
			
			var ocrText = ""
			for observation in observations {
				guard let topCandidate = observation.topCandidates(1).first else { return }
				
				ocrText += topCandidate.string + "\n"
			}
			
			DispatchQueue.main.async {
				self.ocrTextView.text = ocrText
				self.scanButton.isEnabled = true
			}
		}
		
		ocrRequest.recognitionLevel = .accurate
		ocrRequest.recognitionLanguages = ["en-US", "ru-RU"]
		ocrRequest.usesLanguageCorrection = true
	}
}


extension ViewController: VNDocumentCameraViewControllerDelegate {
	func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
		guard scan.pageCount >= 1 else {
			controller.dismiss(animated: true)
			return
		}
		
		scanImageView.image = scan.imageOfPage(at: 0)
		processImage(scan.imageOfPage(at: 0))
		controller.dismiss(animated: true)
	}
	
	func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
		controller.dismiss(animated: true)
	}
	
	func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
		controller.dismiss(animated: true)
	}
}
