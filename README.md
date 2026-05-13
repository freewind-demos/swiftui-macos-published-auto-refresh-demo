# SwiftUI macOS Published Auto Refresh Demo

## 简介

这是 1 个只讲 `@Published` 的 macOS SwiftUI demo。

它会把 2 个字段并排给你看：

1. `plainCount`：普通属性，不会自动刷新
2. `publishedCount`：`@Published` 属性，改了就自动广播

## 快速开始

### 环境要求

- macOS 14+
- Xcode 15+
- XcodeGen

### 运行

```bash
cd /Users/peng.li/workspace/freewind-demos/swiftui-macos-published-auto-refresh-demo
./scripts/build.sh
open PublishedAutoRefreshDemo.xcodeproj
```

### 开发循环

```bash
cd /Users/peng.li/workspace/freewind-demos/swiftui-macos-published-auto-refresh-demo
./dev.sh
```

## 注意事项

- 这个 demo 的重点不是 `ObservableObject` 本身
- 重点是“哪个字段一改就自动刷新”
- 你会直观看到：没 `@Published` 的变化会先憋住

## 教程

### 1. `@Published` 在干嘛

它像“这个属性一改，就自动替你摇铃通知”。

也就是说：

- 你不用手写 `objectWillChange.send()`
- 只要改这个字段
- 盯着对象的 View 就自动刷新

### 2. 生动例子

把它想成前台有 2 个数字牌：

- `plainCount`：写在纸上，改了没人喊
- `publishedCount`：接了电铃，改了立刻响

所以：

- 你连续点“只改 plainCount”
- 墙上数字先不动
- 你再点“改 publishedCount”或“强制广播”
- 墙上会突然把之前憋着的 `plainCount` 一起补出来

### 3. 关键代码

```swift
final class RefreshBoard: ObservableObject {
  var plainCount: Int = 0
  @Published var publishedCount: Int = 0
}
```

重点：

1. 两个字段都在同 1 个对象里
2. 只有 `publishedCount` 自带自动广播
3. `plainCount` 只有等别的广播发生时才会被看见

## 操作

1. 连点几次“只改 plainCount”
2. 看界面不刷新
3. 再点“改 publishedCount”
4. 看 `plainCount` 突然跳到最新值
5. 再试“强制广播”，体会 `@Published` 本质就是替你自动发广播
