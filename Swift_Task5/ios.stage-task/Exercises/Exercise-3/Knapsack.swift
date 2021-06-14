import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var foodsInBackpack: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1),
            count: foods.count + 1)
        var drinksInBackpack: [[Int]] = Array(repeating: Array(repeating: 0, count: maxWeight + 1),
            count: drinks.count + 1)
        
        for i in 0..<foods.count{
            let currentFood = foods[i]
            for j in 1...maxWeight{
                if (((j - currentFood.weight > 0 && foodsInBackpack[i][j - currentFood.weight] > 0) ||
                j - currentFood.weight == 0) && foodsInBackpack[i][j - currentFood.weight] + currentFood.value > foodsInBackpack[i][j]){
                    foodsInBackpack[i + 1][j] = foodsInBackpack[i][j - currentFood.weight] + currentFood.value
                }
                else {
                    foodsInBackpack[i + 1][j] = foodsInBackpack[i][j]
                }
            }
        }
        
        for i in 0..<drinks.count{
            let currentDrink = drinks[i]
            for j in 1...maxWeight{
                if (((j - currentDrink.weight > 0 && drinksInBackpack[i][j - currentDrink.weight] > 0) ||
                j - currentDrink.weight == 0) && drinksInBackpack[i][j - currentDrink.weight] + currentDrink.value > drinksInBackpack[i][j]){
                    drinksInBackpack[i + 1][j] = drinksInBackpack[i][j - currentDrink.weight] + currentDrink.value
                }
                else {
                    drinksInBackpack[i + 1][j] = drinksInBackpack[i][j]
                
                }
            }
        }
        
        for i in 1...maxWeight{
            if (foodsInBackpack[foods.count][i] < foodsInBackpack[foods.count][i - 1]){
                foodsInBackpack[foods.count][i] = foodsInBackpack[foods.count][i - 1]
            }
        }
        
        for i in 1...maxWeight{
            if (drinksInBackpack[drinks.count][i] < drinksInBackpack[drinks.count][i - 1]){
                drinksInBackpack[drinks.count][i] = drinksInBackpack[drinks.count][i - 1]
            }
        }
        
        var max = 0
        for i in 0...maxWeight{
            let currentFood = foodsInBackpack[foods.count][i]
            let currentDrink = drinksInBackpack[drinks.count][maxWeight - i]
            var result = currentFood
            if (currentDrink < currentFood){ result = currentDrink }
            if (result > max) {
                max = result
                
            }
        }
        
        return max
        
    }
}
