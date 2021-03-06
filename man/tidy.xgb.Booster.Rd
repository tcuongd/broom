% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/xgboost-tidiers.R
\name{tidy.xgb.Booster}
\alias{tidy.xgb.Booster}
\title{Tidy a(n) xgb.Booster object}
\usage{
\method{tidy}{xgb.Booster}(x, type = c("feature_importance", "trees"),
  ...)
}
\arguments{
\item{x}{an xgb.Booster object}

\item{type}{result to return - either \code{feature_importance} for the
importance table, or \code{trees} for the tree structure. Default
\code{feature_importance}.}

\item{...}{additional arguments to pass to \code{xgboost::xgb.importance}
(when \code{type = 'feature_importance'}) or
\code{xgboost::xgb.model.dt.tree} (when \code{type = 'trees'}).}
}
\value{
A tibble::tibble containing the relevant components of the model.
}
\description{
Tidy summarizes information about the components of a model.
A model component might be a single term in a regression, a single
hypothesis, a cluster, or a class. Exactly what tidy considers to be a
model component varies cross models but is usually self-evident.
If a model has several distinct types of components, you will need to
specify which components to return.
}
\examples{

mdl <- copy(iris)
features <- setdiff(names(iris), "Species")
mdl[['Species']] <- as.integer(mdl[['Species']]) - 1
dtrain <- xgb.DMatrix(as.matrix(mdl[1:120, features]), label = mdl[['Species']][1:120])
dvalidate <- xgb.DMatrix(as.matrix(mdl[121:150, features]), label = mdl[['Species']][121:150])
xgb_params <- list(
  objective = 'multi:softmax', 
  eval_metric = c('mlogloss', 'merror'), 
  num_class = 3
)
fit <- xgb.train(
  data = dtrain, 
  params = xgb_params, 
  watchlist = list(train = dtrain, validate = dvalidate), 
  nrounds = 50, 
  early_stopping_rounds = 5, 
  verbose = 0
)
tidy(fit, type = "feature_importance")
tidy(fit, type = "trees")

}
\seealso{
\code{\link[xgboost:xgb.train]{xgboost::xgb.train()}}, \code{\link[=xgboost:xgboost]{xgboost:xgboost()}}
}
