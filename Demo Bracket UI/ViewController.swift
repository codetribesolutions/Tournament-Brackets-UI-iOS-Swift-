//
//  ViewController.swift
//  Demo Bracket UI
//
//  Created by Apple on 22/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var viewInScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var viewInScrollWidth: NSLayoutConstraint!
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var scrollView1: UIScrollView!
    
//    var arrData = [["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"],
//                   ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"],
//                   ["a", "b", "c", "d", "e", "f", "g", "h"],
//                   ["a", "b", "c", "d"],
//                   ["a", "d"],
//                   ["a"]]
    
    var arrData = [["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "i"],
                   ["a", "b", "c", "d", "e", "f", "g", "h"],
                   ["a", "b", "c", "d"],
                   ["a", "d"],
                   ["a"]]
    
    var arrSeparatorSize = [Int]()
    
    var cellWidth = 0
    var cellHeight = 80
    var cellsGap = 0
    var levelHeight = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellWidth = Int(view.frame.width / 1.7)
        
        collView.delegate = self
        collView.dataSource = self
        
        scrollView1.delegate = self
        scrollView1.maximumZoomScale = 1.0
        scrollView1.minimumZoomScale = 0.3
        
        for i in 0..<arrData.count
        {
            if(i > 0)
            {
                var val = 0
                for x in arrSeparatorSize
                {
                    val += x
                }
                arrSeparatorSize.append(val + (cellHeight * i))
            }
            else
            {
                arrSeparatorSize.append(0)
            }
            
        }
        
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews[0]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewInScrollWidth.constant = CGFloat(Int(cellWidth + cellsGap) * arrData.count) // + 10 is inset of collectionview
        if(arrData.count > 0)
        {
            if(arrData.count > 1)
            {
                if(CGFloat((cellHeight + arrSeparatorSize[0]) * arrData[0].count) < CGFloat((cellHeight + arrSeparatorSize[1]) * arrData[1].count))
                {
                    viewInScrollHeight.constant = CGFloat(((cellHeight + arrSeparatorSize[1]) * arrData[1].count) + levelHeight)
                }
                else
                {
                    viewInScrollHeight.constant = CGFloat(((cellHeight + arrSeparatorSize[0]) * arrData[0].count) + levelHeight)
                }
            }
            else
            {
                viewInScrollHeight.constant = CGFloat(((cellHeight + arrSeparatorSize[0]) * arrData[0].count) + levelHeight)
            }
        }
        return arrData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollCell
        cell.tblView.delegate = self
        cell.tblView.dataSource = self
        cell.tblView.tableFooterView = UIView()
        cell.tblView.tag = indexPath.row
        
        if(indexPath.row == (arrData.count - 1))
        {
            cell.lblLevel.text = "Final"
        }
        else if(indexPath.row == (arrData.count - 2))
        {
            cell.lblLevel.text = "Semi Final"
        }
        else
        {
            cell.lblLevel.text = "Level \((indexPath.row) + 1)"
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(cellWidth), height: viewInScrollHeight.constant + CGFloat(levelHeight))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var frame = tableView.frame
        if((tableView.tag - 1) >= 0)
        {
//            if(arrData[tableView.tag].count % 2 == 0)
//            {
                frame.origin.y = CGFloat(((cellHeight / 2) + arrSeparatorSize[tableView.tag - 1]) + levelHeight)
//            }
//            else
//            {
//                frame.origin.y = CGFloat(((20 + arrSeparatorSize[tableView.tag - 1])) / 2)
//            }
        }
        
        
        
        tableView.frame = frame
        return arrData[tableView.tag].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        cell.mainView.layer.borderColor = UIColor.lightGray.cgColor
        cell.mainView.layer.borderWidth = 1.5
        
        cell.separatorHeight.constant = CGFloat(arrSeparatorSize[tableView.tag] + 10)
        
        if(tableView.tag < arrData.count - 1)
        {
            if(indexPath.row % 2 == 0)
            {
                cell.evenLine.isHidden = false
                cell.oddLine.isHidden = true
            }
            else
            {
                cell.evenLine.isHidden = true
                cell.oddLine.isHidden = false
            }
        }
        else
        {
            cell.evenLine.isHidden = true
            cell.oddLine.isHidden = true
        }
        
        if(tableView.tag != 0)
        {
            cell.leadingLine.isHidden = false
        }
        else
        {
            cell.leadingLine.isHidden = true
        }
        
        
//        if(tableView.tag % 2 == 0)
//        {
//            cell.viewSeparator.backgroundColor = .white
//        }
//        else
//        {
//            cell.viewSeparator.backgroundColor = .lightGray
//        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight + arrSeparatorSize[tableView.tag])
    }
    
    
    
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}

class CollCell: UICollectionViewCell {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblLevel: UILabel!
}

class TableCell: UITableViewCell {
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var oddLine: UIView!
    @IBOutlet weak var evenLine: UIView!
    @IBOutlet weak var leadingLine: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewSeparator: UIView!
    
}



