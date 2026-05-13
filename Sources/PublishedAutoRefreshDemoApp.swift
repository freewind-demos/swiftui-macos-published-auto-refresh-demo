import SwiftUI

// 这是 demo 的应用入口。
@main
struct PublishedAutoRefreshDemoApp: App {
  // 用 StateObject 持有 1 份共享状态板。
  @StateObject private var board = RefreshBoard()

  // 定义主窗口。
  var body: some Scene {
    // 用单窗口承载 demo。
    Window("Published Demo", id: "main") {
      // 把状态板传给内容视图。
      ContentView(board: board)
    }
    // 给窗口 1 个舒服尺寸。
    .defaultSize(width: 1100, height: 760)
  }
}
