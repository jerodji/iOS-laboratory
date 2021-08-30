class Solution {
    // 深度优先搜索 108ms 100% 80.5%
    func numIslands(_ grid: [[Character]]) -> Int {
        if (grid.isEmpty) {return 0}
        if (grid[0].isEmpty) {return 0}
        let count = grid.count
        let len = grid[0].count
        var res = 0

        var use: [[Bool]] = Array(repeating: Array(repeating: false, count: len), count: count)

        func dfs(_ i:Int, _ j:Int) {
            use[i][j] = true
            if i - 1 >= 0 && i - 1 < count && !use[i-1][j] && grid[i-1][j] == "1" {
                dfs(i-1, j) // 上
            }
            if i + 1 >= 0 && i + 1 < count && !use[i+1][j] && grid[i+1][j] == "1" {
                dfs(i+1, j) // 下
            }
            if j - 1 >= 0 && j - 1 < len && !use[i][j-1] && grid[i][j-1] == "1" {
                dfs(i, j-1) // 左
            }
            if j + 1 >= 0 && j + 1 < len && !use[i][j+1] && grid[i][j+1] == "1" {
                dfs(i, j+1)  // 右
            }
        }

        for i in 0..<count {
            for j in 0..<len {
                if grid[i][j] == "1" && use[i][j] == false {
                    res += 1
                    dfs(i, j)
                }
            }
        }
        print("岛屿 \(res) 个")
        return res
    }
}

//let grid :[[String]] = [
//    ["1","1","1","1","0"],
//    ["1","1","0","1","0"],
//    ["1","1","0","0","0"],
//    ["0","0","0","0","0"]
//]

var grid = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
  ] as [[Character]]

Solution().numIslands(grid)
