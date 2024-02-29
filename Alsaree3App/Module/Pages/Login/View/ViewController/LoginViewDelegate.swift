//
//  loginTableViewDelegate.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 29/02/24.
//

import Foundation
import UIKit

extension LoginViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let headerView = Bundle.main.loadNibNamed("LoginHeader", owner: self, options: nil)?.first as? LoginHeader
            headerView?.setHeaderLbl()
            return headerView
            
        default:
            return nil
        }
    }
}
