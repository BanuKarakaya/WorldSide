//
//  DetailViewController.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newContent: UILabel!
    
    
    lazy var viewModel: DetailViewModelProtocol = DetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func configure(selectedNew: Article?) {
        sourceName.text = selectedNew?.source.name
        newTitle.text = selectedNew?.title
        authorName.text = selectedNew?.author
        newDate.text = selectedNew?.publishedAt
        newContent.text = selectedNew?.content
        prepareBannerImage(with: selectedNew?.urlToImage)
        
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newImage.sd_setImage(with: url)
        }
    }
    
    func prepareUI() {
        print("banu")
    }

}
