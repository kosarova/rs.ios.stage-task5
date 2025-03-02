import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var result = 0
            for i in 0..<prices.count{
                var max = 0
                for j in i + 1..<prices.count{
                    if (prices[j] - prices[i] > max){
                        max = prices[j] - prices[i]
                    }
                }
                result += max
            }
                
                return result
            
    }
}
