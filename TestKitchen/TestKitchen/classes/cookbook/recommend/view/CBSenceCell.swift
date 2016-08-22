//
//  CBSenceCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSenceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configModel(title:String){
        self.nameLabel.text = title
    }
    class func createSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBSenceCell{
        let cellId = "sceneCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSenceCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CBSenceCell", owner: nil, options: nil).last as? CBSenceCell
        }
        if let title = listModel.title{
            cell?.configModel(title)
        }
        return cell!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
