import Cocoa

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
//    @IBOutlet var window: NSWindow!
    private var statusItem: NSStatusItem!
    private var timer: Timer!
    private let dateFormatter = DateFormatter()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        statusItem.button?.font = .monospacedDigitSystemFont(
            ofSize: NSFont.smallSystemFontSize,
            weight: .regular
        )

        dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"

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
        let dateAndTimeString = dateFormatter.string(from: .now)
        statusItem.button?.title = dateAndTimeString
    }

    func applicationWillTerminate(_ notification: Notification) {
        timer.invalidate()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
