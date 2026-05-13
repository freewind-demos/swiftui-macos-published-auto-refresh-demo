import SwiftUI

// 这是主界面。
struct ContentView: View {
  // 直接观察状态板。
  @ObservedObject var board: RefreshBoard

  // 组织整体布局。
  var body: some View {
    // 用纵向布局包住标题、操作区、状态区。
    VStack(alignment: .leading, spacing: 16) {
      headerCard

      HStack(alignment: .top, spacing: 16) {
        actionPanel
        resultPanel
      }
    }
    .padding(20)
    .frame(minWidth: 1000, minHeight: 700)
  }

  // 顶部解释 demo 目标。
  private var headerCard: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("@Published = 这个字段一改就自动摇铃")
        .font(.system(size: 28, weight: .bold))

      Text("点“只改 plainCount”时，界面会先装没看见。点“改 publishedCount”或“强制广播”后，之前憋着的 plainCount 才会显形。")
        .foregroundStyle(.secondary)

      HStack(spacing: 10) {
        badge("plain 属性")
        badge("@Published 属性")
        badge("自动广播 vs 手动广播")
      }
    }
    .padding(18)
    .background(.thinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 左边操作区。
  private var actionPanel: some View {
    VStack(alignment: .leading, spacing: 14) {
      Text("操作区")
        .font(.headline)

      Text("按顺序试：先多点几次只改 plain，再点 published 或强制广播。")
        .foregroundStyle(.secondary)

      Button("只改 plainCount") {
        board.bumpPlainOnly()
      }

      Button("改 publishedCount") {
        board.bumpPublished()
      }

      Button("强制广播") {
        board.forceRefresh()
      }

      Button("重置") {
        board.reset()
      }

      insightCard(
        title: "观察点",
        body: "只改 plainCount 时，没有 @Published，也没有手动 send，所以界面不一定立刻刷新。"
      )

      Spacer(minLength: 0)
    }
    .padding(18)
    .frame(width: 360)
    .frame(minHeight: 360, alignment: .topLeading)
    .background(.regularMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 右边结果区。
  private var resultPanel: some View {
    VStack(alignment: .leading, spacing: 14) {
      Text("结果墙")
        .font(.headline)

      stateRow(name: "plainCount", value: "\(board.plainCount)")
      stateRow(name: "publishedCount", value: "\(board.publishedCount)")

      insightCard(
        title: "你会看到什么",
        body: "先点 3 次 plainCount，墙上可能还是 0。再点 1 次 publishedCount，plainCount 会突然跳成 3，publishedCount 跳成 1。"
      )

      insightCard(
        title: "本质",
        body: "@Published 帮你自动做了 objectWillChange.send()。所以它不是神奇状态，而是自动广播包装器。"
      )

      Spacer(minLength: 0)
    }
    .padding(18)
    .frame(maxWidth: .infinity, minHeight: 360, alignment: .topLeading)
    .background(.regularMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 构造状态行。
  private func stateRow(name: String, value: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(name)
        .font(.caption)
        .foregroundStyle(.secondary)

      Text(value)
        .font(.system(size: 40, weight: .bold, design: .rounded))
        .textSelection(.enabled)
    }
  }

  // 构造说明卡片。
  private func insightCard(title: String, body: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)

      Text(body)
        .foregroundStyle(.secondary)
    }
    .padding(14)
    .background(Color.primary.opacity(0.04))
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }

  // 顶部小标签。
  private func badge(_ text: String) -> some View {
    Text(text)
      .font(.caption.weight(.medium))
      .padding(.horizontal, 10)
      .padding(.vertical, 6)
      .background(Color.primary.opacity(0.06))
      .clipShape(Capsule())
  }
}
