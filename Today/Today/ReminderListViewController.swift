//
//  ViewController.swift
//  Today
//
//  Created by Yuliya Lapenak on 1/15/23.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
    //
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapsShot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let listLayout = listLayout() // применяем созданный Layout для нашей коллекции . Теперь все наши конфигурации хранятся в данном свойстве и мы должны применить для коллекции
        collectionView.collectionViewLayout = listLayout
        
        // зарегистрировать и настроить ячейку
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            //чтобы в каждой ячейке располагалась наша заметка. Cоздаем reminder
            let reminder = Reminder.sampleData[indexPath.item]
            //создаем свойство contentConfiguration с типом ячейки по умолчанию
            var contentConfiguration = cell.defaultContentConfiguration()
            //
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView){ collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = SnapsShot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map{$0.title})
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    // определить Layout  как наша коллекция будет отображаться
    private func listLayout() -> UICollectionViewCompositionalLayout {
        //создать список тех требований тех конфигураций, которые мы хотим применить
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false //разграничительные линии между ячейками чтобы не отображались
        listConfiguration.backgroundColor = .clear // прозрачный бэкграунд
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}


