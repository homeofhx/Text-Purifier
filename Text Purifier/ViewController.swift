import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var inputBox: NSTextView!
    @IBOutlet weak var displayBox: NSScrollView!
    @IBOutlet weak var rulesBox: NSTextField!
    @IBOutlet weak var purifyButton: NSButton!
    @IBOutlet weak var applyRuleButton: NSButton!
    @IBOutlet weak var resetRuleButton: NSButton!
    
    private var validCharRegex : NSRegularExpression!
    private let defaultRule = "[ -~\\t\\n]"
    
    @IBAction func purify(_ sender: Any) {
        let inputBoxRawText:String = inputBox.string
        var inputBoxPurifiedText = ""
        
        let validResult = validCharRegex.matches(in: inputBoxRawText, options: [], range: NSRange(location: 0, length: inputBoxRawText.utf16.count))
        
        // Adopt from https://stackoverflow.com/questions/36075857/how-can-i-find-the-substrings-from-the-nstextcheckingresult-objects-in-swift
        let nsString = inputBoxRawText as NSString
        for result in validResult {
            let matchString = nsString.substring(with: result.range) as String
            inputBoxPurifiedText.append(matchString)
        }
        
        displayBox.documentView!.insertText("------ PURIFIED TEXT ------\n\n")
        displayBox.documentView!.insertText(inputBoxPurifiedText + "\n\n")
        displayBox.documentView!.insertText("------ END OF PURIFIED TEXT ------\n\n\n\n\n")
    }
    
    @IBAction func applyRule(_ sender: Any) {
        let rulesBoxRawString:String = rulesBox.stringValue
        validCharRegex = try! NSRegularExpression(pattern: rulesBoxRawString, options: [])
    }
    
    @IBAction func resetRule(_ sender: Any) {
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validCharRegex = try! NSRegularExpression(pattern: defaultRule, options: [])
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
}
