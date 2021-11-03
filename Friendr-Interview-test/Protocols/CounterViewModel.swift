import Foundation

protocol CounterViewModel: AnyObject {
    var remoteURL: URL { get }
    var searchWord: String { get }
    var viewDelegate: CounterViewModelViewDelegate? { get set }
    func fetchData()
}

protocol CounterViewModelViewDelegate: AnyObject {
    func didChangeLoadingState(_ sender: CounterViewModel, loading: Bool)
    func didCalculateWordsCount(_ sender: CounterViewModel, count: Int)
}
