//
//  DetailViewController.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit
import SDWebImage
import CommonModule

public final class DetailViewController: UIViewController {
    
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newContent: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    public lazy var viewModel: DetailViewModelProtocol = DetailViewModel(delegate: self)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        newTitle.accessibilityIdentifier = "detail_title"
    }
}

extension DetailViewController: DetailViewModelDelegate {
    public func configure(selectedNew: Article?) {
        sourceName.text = selectedNew?.source.name
        newTitle.text = selectedNew?.title
        authorName.text = selectedNew?.author
        newDate.text = selectedNew?.publishedAt
        newContent.text = selectedNew?.content
        prepareBannerImage(with: selectedNew?.urlToImage)
        
    }
    
    public func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newImage.sd_setImage(with: url)
        }
    }
    
    public func prepareUI() {
        scrollView.showsVerticalScrollIndicator = false
    }
}

public enum NewsDetailFactory {
    public static func makeDetailViewController() -> DetailViewController {
        let sb = UIStoryboard(name: "NewsDetail", bundle: .module)
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        else { fatalError("DetailViewController not found in NewsDetail.storyboard") }
        return vc
    }
}
