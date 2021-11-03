import Foundation

class BananaCounterViewModel: CounterViewModel {
    
    private(set) var remoteURL: URL
    private(set) var searchWord: String
    
    private var parser: HTMLParser
    private var networkService: NetworkService
    
    var viewDelegate: CounterViewModelViewDelegate?
    
    init() {
        guard let url = URL(string: "https://en.wikipedia.org/wiki/Banana") else {
            fatalError("Can't initialize remoteURL")
        }
        self.networkService = NetworkService()
        self.parser = HTMLParser()
        self.remoteURL = url
        self.searchWord = "banana"
    }
    
    func fetchData() {
        viewDelegate?.didChangeLoadingState(self, loading: true)
        networkService.getHTML(for: remoteURL) { result in
            // We do not use [weak self] because there can't be any retain cycle, as we do not retain the closure
            switch result {
            case .success(let content):
                let wordCount = self.calculateWordCount(from: content)
                self.viewDelegate?.didCalculateWordsCount(self, count: wordCount)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.viewDelegate?.didChangeLoadingState(self, loading: false)
        }
    }
    
    private func normalizeContent(_ content: String) -> String? {
        parser.content = content
        
        // Getting body content from HTML
        guard let bodyContent = self.parser.getBodyContent() else {
            return nil
        }
        
        // Removing <script> and <style> tags and theirs content
        let bodyContentWithoutScriptsAndStyles = self.parser.removeScriptsAndStyles(from: bodyContent)
        // Removing all remaining tags and replacing /t, /s, /n with space symbol
        let bodyWithoutTags = self.parser.removeTags(from: bodyContentWithoutScriptsAndStyles)
        
        return bodyWithoutTags
    }
    
    private func getWordCount(str: String, word: String) -> Int {
        let words = str.components(separatedBy: " ")
        // Since the search word can be surrounded by special characters, we delete them, leaving only letters
        return words.filter({ $0.trimmingCharacters(in: .letters.inverted) == word }).count
    }
    
    private func calculateWordCount(from string: String) -> Int {
        if let normalizedContent = normalizeContent(string) {
            return getWordCount(str: normalizedContent, word: searchWord)
        } else {
            return 0
        }
    }
}
