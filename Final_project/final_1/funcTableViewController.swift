//
//  funcTableViewController.swift
//  final_1
//
//  Created by Feng Qi on 10/30/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// this is to control image display on secondVC

import UIKit

class funcTableViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // customizing table view
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.white
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(FunctionsDBChangeNotification), object: FuncDatabase.sharedInstance, queue: nil){(NSNotification) in self.tableView.reloadData()}
        
        // update FirstViewController post_count variable
        NotificationCenter.default.post(name: NSNotification.Name(FunctionsDBChangeNotification), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // number of section shown in screen
    // just one section in this app
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // number of images shown in screen
    // it depends on #images uploaded
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FuncDatabase.sharedInstance.image_name_db.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! funcTableViewCell
        
        // Configure the cell...
        // access dictionary by index
        let curt = FuncDatabase.sharedInstance.image_name_db[indexPath.row]
        cell.selectionStyle = .none
        if FuncDatabase.sharedInstance.image_db[indexPath.row] == nil {
            cell.log_image?.image = helper_func.resizeImage(image: UIImage(named: curt)!, newWidth: cell.frame.size.width)
        }else{
            cell.log_image?.image = helper_func.resizeImage(image: FuncDatabase.sharedInstance.image_db[indexPath.row]!, newWidth: cell.frame.size.width)
        }
        cell.express_field?.text = FuncDatabase.sharedInstance.image_name_db[indexPath.row]
        cell.express_field.font = UIFont(name: "HelveticaNeue-UltraLight", size: 25)
        cell.delegate = self
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            FuncDatabase.sharedInstance.intro.remove(at: indexPath.row)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // cell display fashion : animation display
    // ref: https://stackoverflow.com/questions/27817932/tableviewcell-animation-in-swift
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        // 1. Setup the CATransform3D structure
        let M_PI = 3.14
        var rotation = CATransform3DMakeRotation( CGFloat((90.0 * M_PI)/180), 0.0, 0.7, 0.4);
        rotation.m34 = 1.0 / -600
        
        // 2. Define the initial state (Before the animation)
        cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)

        // 3. Define the final state (After the animation) and commit the animation
        cell.layer.transform = rotation
        UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
        cell.alpha = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
}
    
    // customize section header
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int)-> UIView?{
        // add "Moments" title
        if section == 0 {
            let headerView = UIView()
            let content = UILabel(frame: CGRect(x:10, y:25, width: tableView.frame.size.width, height: 50))
            content.textAlignment = .center
            content.text = "Moments"
            content.font = UIFont(name: "Noteworthy", size: content.frame.size.height)
            headerView.addSubview(content)
            return headerView
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

extension funcTableViewController: TableViewCellDelegate{
    
    // implement delete_action protocol
    func delete_action(cell: funcTableViewCell){
        let idx = tableView.indexPath(for: cell)
        FuncDatabase.sharedInstance.description_db.remove(at: idx!.row)
        FuncDatabase.sharedInstance.image_name_db.remove(at: idx!.row)
        FuncDatabase.sharedInstance.image_db.remove(at: idx!.row)
    }
}
