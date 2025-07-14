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
    private let invalidRuleAlert = NSAlert()
    private let defaultFont = NSFont(name: "Helvetica Neue", size: 17.0)
    
    @IBAction func getLatestRelease(_ sender: AnyObject) {
        let url = URL(string: "https://github.com/homeofhx/Text-Purifier/releases/latest")
        NSWorkspace.shared.open(url!)
    }
    
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
            do {
                validCharRegex = try NSRegularExpression(pattern: rulesBoxRawString, options: [])
                outputBox.documentView!.insertText("> Custom purify rule \"" + rulesBoxRawString + "\" applied! <\n\n")
            } catch {
                invalidRuleAlert.runModal()
            }
        }
    }
    
    @IBAction func resetRule(_ sender: Any) {
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
        outputBox.documentView!.insertText("> Purify rule reset to default! (filters out non-ASCII characters) <\n\n")
    }
    
    private func setupNoRuleAlert() {
        noRuleAlert.messageText = "No Purify Rule!"
        noRuleAlert.informativeText = "No purify rule in the Custom Rule box. Please add purify rule using regular expression (Regex) in the Custom Rule box before clicking Apply."
        noRuleAlert.addButton(withTitle: "I Know")
        noRuleAlert.alertStyle = .warning
    }
    
    private func setupInvalidRuleAlert() {
        invalidRuleAlert.messageText = "Can't Process Custom Rule!"
        invalidRuleAlert.informativeText = "Your custom rule might need to be modified to comply with Apple's NSRegularExpression."
        invalidRuleAlert.addButton(withTitle: "I Know")
        invalidRuleAlert.alertStyle = .warning
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputFakeTextView = inputBox.documentView as! NSTextView
        inputFakeTextView.font = defaultFont
        let outputFakeTextView = outputBox.documentView as! NSTextView
        outputFakeTextView.font = defaultFont
        
        setupNoRuleAlert()
        setupInvalidRuleAlert()
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
}
