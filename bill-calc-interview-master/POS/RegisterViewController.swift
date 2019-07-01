//
//  RegisterViewController.swift
//  POS
//
//  Created by Tayson Nguyen on 2019-04-23.
//  Copyright © 2019 TouchBistro. All rights reserved.
//

import UIKit
import BillTotalCalculator

class RegisterViewController: UIViewController {
    let cellIdentifier = "Cell"
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var orderTableView: UITableView!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountsLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.dataSource = self
        orderTableView.dataSource = self
        menuTableView.delegate = self
        orderTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.calculateBill()
        refreshComputedValues()
    }
    
    @IBAction func showTaxes() {
        let vc = UINavigationController(rootViewController: TaxViewController(style: .grouped))
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showDiscounts() {
        let vc = UINavigationController(rootViewController: DiscountViewController(style: .grouped))
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
    
    func refreshComputedValues() {
        subtotalLabel.text = viewModel.subtotalText()
        discountsLabel.text = viewModel.discountsText()
        taxLabel.text = viewModel.taxText()
        totalLabel.text = viewModel.totalText()
    }
}

extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == menuTableView {
            return viewModel.menuCategoryTitle(in: section)
            
        } else if tableView == orderTableView {
            return viewModel.orderTitle(in: section)
        }
        
        fatalError()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == menuTableView {
            return viewModel.numberOfMenuCategories()
        } else if tableView == orderTableView {
            return 1
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return viewModel.numberOfMenuItems(in: section)
            
        } else if tableView == orderTableView {
            return viewModel.numberOfOrderItems(in: section)
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        
        if tableView == menuTableView {
            cell.textLabel?.text = viewModel.menuItemName(at: indexPath)
            cell.detailTextLabel?.text = viewModel.menuItemPrice(at: indexPath)
            
        } else if tableView == orderTableView {
            cell.textLabel?.text = viewModel.labelForOrderItem(at: indexPath)
            cell.detailTextLabel?.text = viewModel.orderItemPrice(at: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuTableView {
            let indexPaths = [viewModel.addItemToOrder(at: indexPath)]
            orderTableView.insertRows(at: indexPaths, with: .automatic)
            
            viewModel.calculateBill()
            refreshComputedValues()
        
        } else if tableView == orderTableView {
            viewModel.toggleTaxForOrderItem(at: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == menuTableView {
            return .none
        } else if tableView == orderTableView {
            return .delete
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == orderTableView && editingStyle == .delete {
            viewModel.removeItemFromOrder(at: indexPath)
            orderTableView.deleteRows(at: [indexPath], with: .automatic)
            
            viewModel.calculateBill()
            refreshComputedValues()
        }
    }
}

class RegisterViewModel {
    
    let billCalculator = BillTotalCalculator()
    var billModel: BillTotalOutputModel?
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var orderItems: [Item] = []
    
    func menuCategoryTitle(in section: Int) -> String? {
        return categories[section].name
    }
    
    func orderTitle(in section: Int) -> String? {
        return "Bill"
    }
    
    func numberOfMenuCategories() -> Int {
        return categories.count
    }
    
    func numberOfMenuItems(in section: Int) -> Int {
        return categories[section].items.count
    }
    
    func numberOfOrderItems(in section: Int) -> Int {
        return orderItems.count
    }
    
    func menuItemName(at indexPath: IndexPath) -> String? {
        return categories[indexPath.section].items[indexPath.row].name
    }
    
    func menuItemPrice(at indexPath: IndexPath) -> String? {
        let price = categories[indexPath.section].items[indexPath.row].price
        return formatter.string(from: price)
    }
    
    func labelForOrderItem(at indexPath: IndexPath) -> String? {
        let item = orderItems[indexPath.row]
       
        if item.isTaxExempt {
            return "\(item.name) (No Tax)"
        } else {
            return item.name
        }
    }
    
    func orderItemPrice(at indexPath: IndexPath) -> String? {
        let price = orderItems[indexPath.row].price
        return formatter.string(from: price)
    }
    
    func addItemToOrder(at indexPath: IndexPath) -> IndexPath {
        let item = categories[indexPath.section].items[indexPath.row]
        orderItems.append(item)
        return IndexPath(row: orderItems.count - 1, section: 0)
    }
    
    func removeItemFromOrder(at indexPath: IndexPath) {
        orderItems.remove(at: indexPath.row)
    }
    
    func toggleTaxForOrderItem(at indexPath: IndexPath) {
        orderItems[indexPath.row].isTaxExempt = !orderItems[indexPath.row].isTaxExempt
    }
}

extension RegisterViewModel {
    func subtotalText() -> String? {
        return formatNumber(billModel?.subtotal)
    }
    
    func discountsText() -> String? {
        return formatNumber(billModel?.discounts)
    }
    
    func taxText() -> String? {
        return formatNumber(billModel?.tax)
    }
    
    func totalText() -> String? {
        return formatNumber(billModel?.total)
    }
    
    func formatNumber(_ number: Float?) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(for: number)
    }
}

extension RegisterViewModel {
    
    func calculateBill() {
        let input = generateInputModel()
        billModel = billCalculator.calculateBill(input: input)
    }
    
    func generateInputModel() -> BillTotalInputModel {
        return BillTotalInputModel(billItems: generateBillItems(), discounts: activeDiscounts())
    }

    func generateBillItems() -> [BillItem] {
        var items = [BillItem]()
        
        orderItems.forEach {
            let price = $0.price
            var activeTaxes: [Float] = []
            if let taxes = taxesForCategory(categoryName: $0.category) {
                activeTaxes = activeTaxAmounts(taxes)
            }
            
            items.append(BillItem(price: Float(truncating: price), taxes:activeTaxes))
        }
        
        return items
    }
    
    func activeTaxAmounts(_ taxes: [Tax]) -> [Float] {
        return taxes.filter {
            $0.isEnabled
            }.map {
                return $0.amount
        }
    }
    
    func taxesForCategory(categoryName: String) -> [Tax]? {
        let category = categories.first {
            $0.name == categoryName
        }
        
        return category?.applicipleTaxes
    }
    
    func activeDiscounts() -> [BillDiscount] {
        let activeDiscounts = discounts.filter {
            $0.isEnabled
        }
        let billDiscounts = activeDiscounts.map { (discount) -> BillDiscount in
            if discount.type == .percentile {
                return BillDiscount(value: discount.amount, type: .percentile)
            } else {
                return BillDiscount(value: discount.amount, type: .amount)
            }
        }
        
        return billDiscounts
    }
}
