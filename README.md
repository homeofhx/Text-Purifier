# Text Purifier

A super simple Mac application that filters out specific characters in given text using regular expression (Regex).

**Mac OS compatibility**: 10.10 (OS X Yosemite) or newer. ARM Macs need to install Rosetta 2 (Mac OS will prompt to install if not) before use.

## How to Use

 - Paste the text to the input box (the one on the left) and click the Purify button, you'll then get the text without non-ASCII characters in the output box (the one on the right).

Or if you want to keep specific characters (groups)...

 - You can specify the Regex for the characters (groups) to keep in the Custom Rule box at the bottom and click "Apply" before purifying the input text.

To reset the rule to the default (filter out non-ASCII characters), click the "Reset to Default" button.

## Known Issues & Limitations

You may want to adapt the syntax for custom rule Regex to accommodate Apple's `NSRegularExpression` ([see here for the documentation](https://developer.apple.com/documentation/foundation/nsregularexpression)).

You're also welcome to use Issues for bug reports and Discussions for general suggestions.