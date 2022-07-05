//
//  Storage.swift
//  FinanceManager
//
//  Created by Dima on 30.05.22.
//

import Foundation
import Charts

extension String.StringInterpolation{
    mutating func appendInterpolation(_ value: Double){
        let outputString = "\(NSString(format:"%.1f", value))"
        appendLiteral(outputString)
    }
    
    mutating func appendInterpolation(_ value: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        appendLiteral(formatter.string(from: value))
    }
}

class StorageStrategy: PFinanceStrategy{
    
    private(set) var options: SChartSettings?
    private(set) var expenses = [Expense]()
    private(set) var stats = [SCategoryStatistics]()
    private(set) var debtsSum: Double = 0.0
    
    private(set) var colorsDict = [
        "Household expenses": UIColor.tintColor,
        "Education expenses": UIColor.blue,
        "Transport expenses": UIColor.brown,
        "Oil expenses": UIColor.cyan,
        "Shopping expenses": UIColor.darkGray,
        "Bad habits": UIColor.gray,
        "Internet shopping expenses": UIColor.green,
        "Online games expenses": UIColor.lightGray,
        "Gambling expenses": UIColor.orange,
        "Entertainment expenses": UIColor.purple,
        "Fastfood expenses": UIColor.red,
        "Service expenses": UIColor.systemMint,
        "Investment": UIColor.systemGray,
        "Trade": UIColor.systemGray2,
        "Credit payment": UIColor.systemMint,
        "Leasing payment": UIColor.systemMint,
        "Microlan payment": UIColor.systemMint,
        "Other expenses": UIColor.systemIndigo
    ]
    
    func statistics() -> String{
        if options == nil{
            return "Statistics options is not set"
        }
        var usedCategories = [String]()
        var stats = [SCategoryStatistics]()
        for expense in expenses {
            if usedCategories.contains(expense.category!){
                continue
            }else{
                let category = expense.category!
                var statistic = SCategoryStatistics(category: category, count: 0, totalSum: 0)
                for expense in expenses {
                    if expense.category! == category{
                        statistic.count += 1
                        statistic.totalSum += expense.sum
                    }
                }
                usedCategories.append(category)
                stats.append(statistic)
            }
        }
        self.stats = stats
        stats = stats.sorted(by: { $0.totalSum > $1.totalSum })
        var result = "Expenses sorted by sum (including debts):\n\n"
        for stat in stats {
            result += "Category: \(stat.category)\n"
            result += "Number of expenses: \(stat.count)\n"
            result += "Total sum: \(NSString(format:"%.1f", stat.totalSum)) \(UserDataManager.data.currency!)\n\n"
        }
        return result
    }
    
    func detailedStatistics() -> String{
        if let options = options {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            var result = "Detailed expense list:\nStart date: \(options.startDate)\nEnd date: \(options.endDate)\n\n"
            let days = options.endDate.timeIntervalSince(options.startDate) / 60 / 60 / 24
            result += "Debts sum: \(debtsSum) \(UserDataManager.data.currency!)\n\n"
            if CarManager.car.fuel > 0{
                let distance = CarManager.car.distance
                let fuel = CarManager.car.fuel
                let carFuel = days*(distance*fuel/100)
                if carFuel > 1{
                    result += "Remember about fuel expenses on average for: \(carFuel) liters\n\n"
                }
            }
            for expense in expenses {
                result += expense.presentInfo()
                result += "\n\n"
            }
            return result
        }else{
            return "Statistics options is not set"
        }
    }
    
    func tips() -> String{
        if let _ = options{
            var result = "Tips:\n\n"
            var topCategories = [String]()
            for category in CategoriesManager.top{
                topCategories.append(category.category!)
            }
            var savingSum = 0.0
            var riskySum = 0.0
            var uselessSum = 0.0
            for stat in stats {
                if topCategories.contains(stat.category) || stat.category == "Credit payment" ||
                    stat.category == "Leasing payment" || stat.category == "Microlan payment"{
                    continue
                }else if stat.category == "Bad habits" || stat.category == "Fastfood expenses"{
                    uselessSum += stat.totalSum
                }else if stat.category == "Gambling expenses"{
                    riskySum += stat.totalSum
                }
                else{
                    savingSum += stat.totalSum
                }
            }
            if savingSum > 0{
                result += "Save \(NSString(format:"%.1f", savingSum)) \(UserDataManager.data.currency!) spending only on priority categories:\n"
                for category in topCategories {
                    result += category + "\n"
                }
                result += "\n"
            }
            if uselessSum > 0{
                result += "Save \(NSString(format:"%.1f", uselessSum)) \(UserDataManager.data.currency!) without spending money on bad habits and fastfood\n\n"
            }
            if riskySum > 0{
                result += "Save \(NSString(format:"%.1f", riskySum)) \(UserDataManager.data.currency!) without spending money on gambling\n\n"
            }
            let storeSum = savingSum + riskySum + uselessSum
            if Int(storeSum) > 0{
                result += "We recomment you to store \(NSString(format:"%.1f", storeSum)) \(UserDataManager.data.currency!) by following tips\n\n"
                result += "You will earn your wished sum since \(Int(UserDataManager.data.wishedSum/storeSum)) days storing this sum daily"
            }
            return result
        }else{
            return "Statistics options is not set"
        }
    }
    
    func commonChart() -> Any{
        var dataEntry = [PieChartDataEntry]()
        var colors = [UIColor]()
        for stat in stats {
            dataEntry.append(PieChartDataEntry(value: stat.totalSum, label: stat.category))
            colors.append(colorsDict[stat.category]!)
        }
        let dataSet = PieChartDataSet(entries: dataEntry, label: "")
        dataSet.colors = colors
        let chartData = PieChartData(dataSets: [dataSet])
        return chartData
    }
    
    
    func countDebts(_ days: Int){
        var sum = 0.0
        if days >= 30{
            let times = days/30
            let credits = DebtsManager.credits
            let leasings = DebtsManager.leasings
            let microlans = DebtsManager.microlans
            for credit in credits {
                var i = 0
                if credit.sum == credit.paymentSum{
                    sum += credit.sum
                    continue
                }
                while i < times{
                    sum += credit.paymentSum
                    i += 1
                }
            }
            for leasing in leasings {
                var i = 0
                if leasing.sum == leasing.paymentSum{
                    sum += leasing.sum
                    continue
                }
                while i < times{
                    sum += leasing.paymentSum
                    i += 1
                }
            }
            for microlan in microlans {
                var i = 0
                if microlan.sum == microlan.paymentSum{
                    sum += microlan.sum
                    continue
                }
                while i < times{
                    sum += microlan.paymentSum
                    i += 1
                }
            }
        }
        debtsSum = sum
    }
    
    func setOptions(_ options: SChartSettings?){
        if let options = options {
            self.options = options
            var sorted = [Expense]()
            let days = options.endDate.timeIntervalSince(options.startDate) / 60 / 60 / 24
            countDebts(Int(days))
            for expense in ExpenseManager.expenses{
                if options.startDate <= expense.date! && options.endDate >= expense.date!{
                    sorted.append(expense)
                }
            }
            expenses = sorted
        }
        else{
            self.options = options
            expenses = []
            stats = []
            debtsSum = 0.0
        }
    }
    
    func sum() -> Double {
        var sum = 0.0
        for expense in expenses {
            sum += expense.sum
        }
        sum += debtsSum
        return sum
    }

}
