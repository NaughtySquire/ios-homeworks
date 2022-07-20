import UIKit

final class PageViewControllerSegmentedAdapter: NSObject {

    private let pageViewController: UIPageViewController
    fileprivate let segmentControl: UISegmentedControl
    fileprivate let viewControllers: [UIViewController]
    fileprivate var selectedIndex: Int = 0

    init(pageViewController: UIPageViewController, segmentControl: UISegmentedControl, viewControllers: [UIViewController]) {
        if segmentControl.numberOfSegments != viewControllers.count {
            fatalError("Number of segments in UISegmentControl should be equals to the number of UIViewControllers")
        }

        self.pageViewController = pageViewController
        self.segmentControl = segmentControl
        self.viewControllers = viewControllers

        super.init()

        pageViewController.delegate = self
        pageViewController.dataSource = self

        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)

        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false)
        }
    }

    @objc private func segmentControlValueChanged() {
        let selectedIndex = self.selectedIndex

        if self.segmentControl.selectedSegmentIndex > selectedIndex {
//            let nextIndex = selectedIndex + 1
//            for index in nextIndex...self.segmentControl.selectedSegmentIndex {
//
//            }
            self.setViewController(atIndex: self.segmentControl.selectedSegmentIndex, direction: .forward)
        } else if self.segmentControl.selectedSegmentIndex < selectedIndex {
//            let previousIndex = selectedIndex - 1
//            for index in (self.segmentControl.selectedSegmentIndex...previousIndex).reversed() {
//
//            }
            self.setViewController(atIndex: self.segmentControl.selectedSegmentIndex, direction: .reverse)
        }
    }

    private func setViewController(atIndex index: Int, direction: UIPageViewController.NavigationDirection) {
        self.pageViewController.setViewControllers([self.viewControllers[index]], direction: direction, animated: true) { [weak self] completed in
            guard let self = self else {
                return
            }
            if completed {
                self.selectedIndex = index
            }
        }
    }
}

extension PageViewControllerSegmentedAdapter: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.viewControllers.firstIndex(of: viewController),
            index > 0 else {
                return nil
        }
        return self.viewControllers[index-1]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = self.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        index = index + 1
        if index == self.viewControllers.count {
            return nil
        }
        return self.viewControllers[index]
    }

}

extension PageViewControllerSegmentedAdapter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
            let lastViewController = viewControllers.last,
              let index = self.viewControllers.firstIndex(of: lastViewController) else {
                return
        }
        
        if finished && completed {
            self.selectedIndex = index
            self.segmentControl.selectedSegmentIndex = self.selectedIndex
        }
    }

}
