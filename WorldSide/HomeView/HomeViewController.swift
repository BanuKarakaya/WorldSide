//
//  HomeViewController.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func prepareCollectionView() {
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
    }
}
