import Cocoa

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var timer: Timer!
    private var dateFormatter: DateFormatter!
    private var timeFormatter: DateFormatter!
    private var statusItemView: NSTextField!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        dateFormatter = DateFormatter()
        timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        timeFormatter.dateFormat = "HH:mm:ss"

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        statusItemView = NSTextField(labelWithString: "")
        statusItemView.translatesAutoresizingMaskIntoConstraints = false
        statusItemView.font = .monospacedSystemFont(ofSize: NSFont.smallSystemFontSize, weight: .regular)
        statusItemView.alignment = .center
        statusItemView.maximumNumberOfLines = 2
        statusItemView.lineBreakMode = .byWordWrapping
        statusItem.button?.addSubview(statusItemView)
        NSLayoutConstraint.activate([
            statusItemView.leadingAnchor.constraint(equalTo: (statusItem.button?.leadingAnchor)!),
            statusItemView.trailingAnchor.constraint(equalTo: (statusItem.button?.trailingAnchor)!),
            statusItemView.topAnchor.constraint(equalTo: (statusItem.button?.topAnchor)!),
            statusItemView.bottomAnchor.constraint(equalTo: (statusItem.button?.bottomAnchor)!)
        ])
        updateStatusItemTitle()

        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStatusItemTitle),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: .common)
    }

    @objc private func updateStatusItemTitle() {
        let dateString = dateFormatter.string(from: Date())
        let timeString = timeFormatter.string(from: Date())
        statusItemView.stringValue = "\(dateString)\n\(timeString)"
    }

    func applicationWillTerminate(_ notification: Notification) {
        timer.invalidate()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
