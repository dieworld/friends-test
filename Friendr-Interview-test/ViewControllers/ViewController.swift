import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    var viewModel: CounterViewModel? = BananaCounterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDelegate = self
        viewModel?.fetchData()
    }
}

extension ViewController: CounterViewModelViewDelegate {
    func didChangeLoadingState(_ sender: CounterViewModel, loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
            self.countLabel.isHidden = loading
        }
    }
    
    func didCalculateWordsCount(_ sender: CounterViewModel, count: Int) {
        DispatchQueue.main.async {
            self.countLabel.text = String(count)
        }
    }
    
}

