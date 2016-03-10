# R Package for Density Ratio Estimation



## 1. KLIEP (Kullback-Leibler Importance Estimation Procedure)


```r
set.seed(314)
x <- rnorm(400, 1, 1/8)
y <- rnorm(400, 1, 1/2)

plot(function(x) dnorm(x, 1, 1/8), xlim=c(-1, 3), xlab="x", ylab="", lwd=2)
plot(function(x) dnorm(x, 1, 1/2), xlim=c(-1, 3), lwd=2, col=4, add=TRUE)
legend("topright", legend=c("p(x)","p(y)"), col=c(1,4), lwd=2)
```

![](README_files/figure-html/unnamed-chunk-1-1.png)


```r
library(densratio)
result <- KLIEP(x, y)
```


```r
plot(y, result$y_density_ratio, xlim = c(-1, 3), ylim=c(0, 4), col = 4, xlab = "x", ylab = "")
plot(function(x) result$compute_density_ratio(x)[,1], xlim=c(-1, 3), lwd=2, col=3, add=TRUE)
plot(function(x) dnorm(x, 1, 1/8) / dnorm(x, 1, 1/2), xlim=c(-1, 3), lwd=2, col=2, add=TRUE)
legend("topright", legend=c("w(x)","w-hat(x)","w-hat(y)"), col=2:4, lty=c(1,1,NA), lwd=2, pch=c(NA,NA,1))
```

![](README_files/figure-html/unnamed-chunk-3-1.png)


```r
x <- rnorm(1000, 2, 1/4)
y <- rnorm(200, 1, 1/2)

plot(function(x) dnorm(x, 2, 1/4), xlim=c(-1, 3), xlab="x", ylab="", lwd=2)
plot(function(x) dnorm(x, 1, 1/2), xlim=c(-1, 3), lwd=2, col=4, add=TRUE)
legend("topleft", legend=c("p(x)","p(y)"), col=c(1,4), lwd=2)
```

![](README_files/figure-html/unnamed-chunk-4-1.png)


```r
result <- KLIEP(x, y)
```


```r
plot(y, result$y_density_ratio, xlim = c(-1, 3), ylim=c(0, 30), col = 4, xlab = "x", ylab = "")
plot(function(x) result$compute_density_ratio(x)[,1], xlim=c(-1, 3), lwd=2, col=3, add=TRUE)
plot(function(x) dnorm(x, 2, 1/4) / dnorm(x, 1, 1/2), xlim=c(-1, 3), lwd=2, col=2, add=TRUE)
legend("topleft", legend=c("w(x)","w-hat(x)","w-hat(y)"), col=2:4, lty=c(1,1,NA), lwd=2, pch=c(NA,NA,1))
```

![](README_files/figure-html/unnamed-chunk-6-1.png)

## References

[1] Sugiyama, M., Nakajima, S., Kashima, H., von Bünau, P. & Kawanabe, M. 
Direct importance estimation with model selection and its application to covariate shift adaptation. 

