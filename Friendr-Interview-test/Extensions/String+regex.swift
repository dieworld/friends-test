import Foundation

extension String {
    func regex(pattern: String) -> [String]?{
        let nsSelf = self as NSString
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options:  [.dotMatchesLineSeparators])
            let all = NSRange(location: 0, length: nsSelf.length)
            var matches = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                    if let r = result {
                        let result = nsSelf.substring(with: r.range) as String
                        matches.append(result)
                    }
            }
            return matches
        } catch {
            return nil
        }
    }
    
    func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        let nsSelf = self as NSString
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators, .caseInsensitive] )
            let range = NSRange(location: 0, length: nsSelf.length)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
