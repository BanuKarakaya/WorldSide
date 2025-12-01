//
//  DetailViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 23.10.2025.
//

import Foundation
import CommonModule

public protocol DetailViewModelProtocol {
    func viewDidLoad()
}

public protocol DetailViewModelDelegate: AnyObject {
    func configure(selectedNew: Article?)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
}

public final class DetailViewModel {
    private weak var delegate: DetailViewModelDelegate?
    public var selectedNew: Article?
    
   public init(delegate: DetailViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    public func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.configure(selectedNew: selectedNew!)
    }
}
