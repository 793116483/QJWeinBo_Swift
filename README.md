# QJWeinBo_Swift
使用swift写微博

## 一、一些问题注意事项目
####  1. 核心动画
* 变动到某一个目标值时，临界值不是很准确(也就是没有用如0)
```objc
// 0.001 是因为苹果处理边界值时不是很灵，所以取值 0.001
toValue: 0.001
```
