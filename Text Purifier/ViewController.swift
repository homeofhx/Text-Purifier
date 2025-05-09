import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var inputBox: NSTextView!
    @IBOutlet weak var displayBox: NSScrollView!
    @IBOutlet weak var rulesBox: NSTextField!
    @IBOutlet weak var purifyButton: NSButton!
    @IBOutlet weak var applyRuleButton: NSButton!
    @IBOutlet weak var resetRuleButton: NSButton!
    
    private var validCharRegex : NSRegularExpression!
    
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
        print("using rule: " + validCharRegex.description)
    }
    
    @IBAction func applyRule(_ sender: Any) {
        print("applied btn clicked")
        let rulesBoxRawString:String = rulesBox.stringValue
        print("entered rule: " + rulesBoxRawString)
        validCharRegex = try! NSRegularExpression(pattern: rulesBoxRawString, options: [])
        print("current rule: " + validCharRegex.description)
    }
    
    @IBAction func resetRule(_ sender: Any) {
        print("reseted btn clicked")
        validCharRegex = try! NSRegularExpression(pattern: "[ -~\\t\\n]", options: [])
        print("current rule: " + validCharRegex.description)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validCharRegex = try! NSRegularExpression(pattern: "[ -~\\t\\n]", options: [])
        
        print("")
        print("")
        print("INIT COMPLETE")
        print("rule: " + validCharRegex.description)
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
}
