//
//  AZCrossDissolveImageSlideshow.swift
//  AZCrossDissolveImageSlideshow
//
//  Created by ApolloZhu on 2019/7/22.
//
//  Copyright (c) 2019 Zhiyu Zhu/朱智语/ApolloZhu
//  Copyright (c) 2019 XiangWuShuo
//  MIT License.
//

import UIKit
import ImageSlideshow

/// ImageSlideshow with support for fade-transition between images.
open class AZCrossDissolveImageSlideshow: ImageSlideshow {
    
    // MARK: - Animation
    
    /// Seconds between each transition.
    open var crossFadeInterval: TimeInterval = 0 {
        didSet {
            pauseTimer()
            setTimerIfNeeded()
        }
    }
    
    /// Seconds spend on transitioning from one image to another.
    open var crossFadeDuration: TimeInterval = 0.5
    
    /// Implementation of cross-dissolve fade transition.
    @objc open func performTransition() {
        if !circular && currentPage == images.count - 1 {
            return
        }
        
        defer { restartTimer() }
        if indicesDidInvalidate { return }
        let nextPage = (currentPage + 1) % images.count
        
        let snapshot = imageView(for: images[nextPage])
        addSnapshot(snapshot)
        crossFade(from: currentPage, to: nextPage, using: snapshot)
    }
    
    private func imageView(for image: InputSource) -> UIImageView {
        let imageView = UIImageView(frame: bounds)
        image.load(to: imageView) { _ in }
        imageView.contentMode = contentScaleMode
        configurePreviewImageView?(imageView)
        return imageView
    }
    
    /// Modify properties of a snapshot of the next image view to be shown after transition.
    public var configurePreviewImageView: ((UIImageView) -> Void)? = nil
    
    private func addSnapshot(_ snapshot: UIView) {
        snapshot.alpha = 0
        if let pageIndicatorView = pageIndicator?.view {
            insertSubview(snapshot, belowSubview: pageIndicatorView)
        } else {
            addSubview(snapshot)
        }
    }
    
    private func crossFade(from currentPage: Int, to nextPage: Int, using snapshot: UIView) {
        UIView.animate(
            withDuration: crossFadeDuration,
            animations: { [weak self] in
                guard let self = self, !self.indicesDidInvalidate else { return }
                self.slideshowItems[currentPage].imageView.alpha = 0
                snapshot.alpha = 1
            },
            completion: { [weak self] _ in
                defer { snapshot.removeFromSuperview() }
                guard let self = self else { return }
                if !self.indicesDidInvalidate {
                    self.setCurrentPage(nextPage, animated: false)
                }
                if self.slideshowItems.indices.contains(currentPage) {
                    self.slideshowItems[currentPage].imageView.alpha = 1
                }
            }
        )
    }
    
    // MARK:  - Timer
    
    private var slideshowTimer: Timer?
    
    private func setTimerIfNeeded() {
        if slideshowInterval > 0 { return }
        guard crossFadeInterval > 0 && images.count > 1 && slideshowTimer == nil else { return }
        slideshowTimer = Timer.scheduledTimer(
            timeInterval: crossFadeInterval,
            target: self, selector: #selector(performTransition),
            userInfo: nil, repeats: true
        )
    }
    
    open override func pauseTimer() {
        slideshowTimer?.invalidate()
        slideshowTimer = nil
        super.pauseTimer()
    }
    
    open override func unpauseTimer() {
        setTimerIfNeeded()
        super.unpauseTimer()
    }
    
    open func restartTimer() {
        if slideshowTimer != nil {
            pauseTimer()
        }
        indicesDidInvalidate = false
        setTimerIfNeeded()
    }
    
    // MARK: - Inject into Life Cycle
    
    private var indicesDidInvalidate = false
    
    open override func setImageInputs(_ inputs: [InputSource]) {
        indicesDidInvalidate = true
        super.setImageInputs(inputs)
        setTimerIfNeeded()
    }
    
    open override func nextPage(animated: Bool) {
        super.nextPage(animated: animated)
        restartTimer()
    }
    
    open override func previousPage(animated: Bool) {
        super.previousPage(animated: animated)
        restartTimer()
    }
    
    open override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        restartTimer()
        super.scrollViewWillBeginDragging(scrollView)
    }
}
