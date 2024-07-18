library(ggplot2)


### Recommendation data ----
# Data from https://media.allpax.de/media/products/Gartabelle_DE_neu.pdf
df = data.frame(
  thickness = rep(1:6, 5),
  temperature  = factor(rep(c(49, 50, 55, 60, 65), each = 6)),
  minutes   = c(
    5, 20, 43, 70, 110, 165,
    6, 22, 45, 80, 120, 170,
    6, 25, 50, 85, 130, 185,
    7, 25, 50, 90, 135, 195,
    7, 25, 50, 90, 140, 200
  )
)
ggplot(df, aes(x = thickness, y = minutes, color = temperature)) + theme_minimal() + 
  geom_line(linetype = "dashed") + geom_point(size = 2)


### Model 1 ----
## Estimating the coefficients
model <- lm(minutes ~ as.numeric(temperature) + I(thickness^2), df)
summary(model)
beta <- summary(model)$coefficients[, 1]
beta

## Estimating new cooking times using these coefficients
# Rounding up to 5min intervals to be safe.
df$estimation <- ceiling(beta[1] + beta[2] * as.numeric(df$temperature) + beta[3] * (df$thickness^2))
df$estimation <- df$estimation + (df$estimation %% 5)

## Estimation errors
# Positive ones do no harm.
df$difference <- df$estimation - df$minutes
ggplot(df, aes(x = thickness, y = difference)) + theme_minimal() + 
  geom_ribbon(aes(ymin = 0, ymax = I(max(difference))), fill = "gray", alpha = 0.3) + 
  geom_line(linetype = "dashed", aes(color = temperature)) + geom_point(size = 2, aes(color = temperature)) + 
  ggtitle("difference between recommended and estimated cooking time", "by temperature")
# Not good enough


### Model 2 ----
## Estimating the coefficients
model <- lm(minutes ~ temperature : I(thickness^2), df)
summary(model)
beta <- summary(model)$coefficients[, 1]
beta

## Estimating new cooking times using these coefficients
# Rounding up to 5min intervals to be safe.
df$estimation <- ceiling(beta[1] + rep(beta[-1], each = 6) * (df$thickness^2))
df$estimation <- df$estimation + (df$estimation %% 5)

## Estimation errors
# Positive ones do no harm.
df$difference <- df$estimation - df$minutes
ggplot(df, aes(x = thickness, y = difference)) + theme_minimal() + 
  geom_ribbon(aes(ymin = 0, ymax = I(max(difference))), fill = "gray", alpha = 0.3) + 
  geom_line(linetype = "dashed", aes(color = temperature)) + geom_point(size = 2, aes(color = temperature)) + 
  ggtitle("difference between recommended and estimated cooking time", "by temperature")
# I think this is safe enough FOR ME. OTHER PEOPLE SHOULD FOLLOW OFFICIAL TEMPERATURE TABLES.

