//
//  ReportViewController.swift
//  Validador de Facturas
//
//  Created by Juan Rodriguez Reyes on 23/01/20.
//  Copyright © 2020 Juan Rodriguez Reyes. All rights reserved.
//

import UIKit
 

class ReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var data = ["Report 1","Report 2","Report 3","Report 4","Report 5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

           cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"

           return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
