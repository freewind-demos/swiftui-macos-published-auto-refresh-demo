import SwiftUI

// 这是用来对比 plain 属性和 @Published 属性的状态板。
final class RefreshBoard: ObservableObject {
  // 这是普通属性；改它不会自动广播。
  var plainCount: Int

  // 这是会自动广播的属性。
  @Published var publishedCount: Int

  // 初始化默认值。
  init(
    plainCount: Int = 0,
    publishedCount: Int = 0
  ) {
    // 保存普通计数初值。
    self.plainCount = plainCount

    // 保存自动广播计数初值。
    self.publishedCount = publishedCount
  }

  // 只改普通属性。
  func bumpPlainOnly() {
    // 这里故意不发广播。
    plainCount += 1
  }

  // 改 @Published 属性。
  func bumpPublished() {
    // 这里只改 published 字段。
    publishedCount += 1
  }

  // 手动广播 1 次，让 plainCount 的积压变化显形。
  func forceRefresh() {
    // 主动发出刷新通知。
    objectWillChange.send()
  }

  // 重置全部状态。
  func reset() {
    // 先发广播。
    objectWillChange.send()

    // 重置普通计数。
    plainCount = 0

    // 重置自动广播计数。
    publishedCount = 0
  }
}
