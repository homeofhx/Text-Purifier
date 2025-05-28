import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var inputBox: NSScrollView!
    @IBOutlet weak var outputBox: NSScrollView!
    @IBOutlet weak var rulesBox: NSTextField!
    @IBOutlet weak var purifyButton: NSButton!
    @IBOutlet weak var applyRuleButton: NSButton!
    @IBOutlet weak var resetRuleButton: NSButton!
    
    private var validCharRegex : NSRegularExpression!
    private let defaultRule = "[ -~\\t\\n]"
    private let noRuleAlert = NSAlert()
    
    @IBAction func purify(_ sender: Any) {
        let inputFakeTextView = inputBox.documentView as! NSTextView     // A change made in version 2. Similar approach as inputBoxFakeNSString in this function.
        let inputBoxRawText = inputFakeTextView.string
        var inputBoxPurifiedText = ""
        
        let validResult = validCharRegex.matches(in: inputBoxRawText, options: [], range: NSRange(location: 0, length: inputBoxRawText.utf16.count))
        
        // Adopt from https://stackoverflow.com/questions/36075857/how-can-i-find-the-substrings-from-the-nstextcheckingresult-objects-in-swift
        let inputBoxFakeNSString = inputBoxRawText as NSString
        for result in validResult {
            let matchString = inputBoxFakeNSString.substring(with: result.range) as String
            inputBoxPurifiedText.append(matchString)
        }
        
        outputBox.documentView!.insertText("------ PURIFIED TEXT ------\n\n")
        outputBox.documentView!.insertText(inputBoxPurifiedText + "\n\n")
        outputBox.documentView!.insertText("------ END OF PURIFIED TEXT ------\n\n\n\n\n")
    }
    
    @IBAction func applyRule(_ sender: Any) {
        let rulesBoxRawString:String = rulesBox.stringValue
        
        if rulesBoxRawString.count == 0 {
            noRuleAlert.runModal()
        } else {
            validCharRegex = try! NSRegularExpression(pattern: rulesBoxRawString, options: [])
            outputBox.documentView!.insertText("CUSTOM PURIFY RULE APPLIED!\n\n")
        }
    }
    
    @IBAction func resetRule(_ sender: Any) {
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
        outputBox.documentView!.insertText("PURIFY RULE RESET TO DEFAULT! (filters out non-ASCII characters)\n\n")
    }
    
    private func setupNoRuleAlert() {
        noRuleAlert.messageText = "No Purify Rule!"
        noRuleAlert.informativeText = "No purify rule in the Custom Rule box. Please add purify rule using regular expression (Regex) in the Custom Rule box before clicking Apply."
        noRuleAlert.addButton(withTitle: "OK")
        noRuleAlert.alertStyle = .warning
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNoRuleAlert()
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
}
