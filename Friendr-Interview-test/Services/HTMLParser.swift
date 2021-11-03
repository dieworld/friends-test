import Foundation

class HTMLParser {
    
    var content: String?
    
    static let bodyRegex: String = "<body[^>]*>([\\w|\\W]*)</body>"
    static let scriptRegex: String = "<script[^<]*</script>"
    static let stylesRegex: String = "<style[^<]*</style>"
    static let tagsRegex: String = "<[^>]*>"
    static let lineBreakRegex: String = "\r?\n|\r|\t"
    static let extraSpacesRegex: String = "[\\s\n]+"
    
    func getBodyContent() -> String? {
        return content?.regex(pattern: HTMLParser.bodyRegex)?.first
    }
    
    func removeScriptsAndStyles(from string: String) -> String {
        return string
            .removingRegexMatches(pattern: HTMLParser.scriptRegex)
            .removingRegexMatches(pattern: HTMLParser.stylesRegex)
    }
    
    func removeTags(from string: String) -> String {
        return string
            .removingRegexMatches(pattern: HTMLParser.tagsRegex)
            .removingRegexMatches(pattern: HTMLParser.lineBreakRegex, replaceWith: " ")
            .removingRegexMatches(pattern: HTMLParser.extraSpacesRegex, replaceWith: " ")
    }
    
}
