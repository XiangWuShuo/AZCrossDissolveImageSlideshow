# AZCrossDissolveImageSlideshow

Subclass of [zvonicek/ImageSlideshow](https://github.com/zvonicek/ImageSlideshow) that supports fade transition between images

![demo of cross dissolve between images](demo.gif)

```swift
imageSlideshow.setImageInputs(/* ... */)

imageSlideshow.crossFadeDuration = 0.5
imageSlideshow.crossFadeInterval = 2.0
imageSlideshow.contentScaleMode = .scaleAspectFill

for item in imageSlideshow.slideshowItems {
    item.imageView.cornerRadius = 10
}
imageSlideshow.configurePreviewImageView = { imageView in
    imageView.cornerRadius = 10
}
```

## Install

```ruby
pod 'AZCrossDissolveImageSlideshow', :git => 'https://github.com/XiangWuShuo/AZCrossDissolveImageSlideshow.git'
```
