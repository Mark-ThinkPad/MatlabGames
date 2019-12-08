# Matlab Games

## 简介

- 使用 MATLAB GUI 制作一个小游戏三合一程序
- 三人合作开发, 每人各出一个小游戏
- 菜单界面和2048小游戏使用 `App Designer` 构建开发, 贪吃蛇和扫雷使用 `GUIDE` 开发
 
## 开发环境

- 系统: `Windows 7 SP1 64-bit` / `Windows 10 64-bit`
- MATLAB版本: `R2019a Update5 64-bit(win64)` (Professional License)

## 项目结构

> `.mlapp` 格式为 `App Designer` 默认生成的二进制文件

- [AppDesigner](./AppDesigner): `App Designer` 默认生成的二进制文件
- [menu.m](./menu.m): 菜单界面, 由 `App Designer` 导出
- [play2048.m](./play2048.m): 2048小游戏, 由 `App Designer` 导出
- [snake.m](./snake.m): 贪吃蛇小游戏
- [minesweeper.m](./minesweeper.m): 扫雷小游戏

## 运行及操作方式

- 直接运行 `menu.m` 即可
- 每个小游戏均可独立运行
- `2048`: 方向键 / WSAD键
- `贪吃蛇`: 方向键
- `扫雷`: `鼠标左键+鼠标右键`
