% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apa_print_glm.R
\name{apa_print.glm}
\alias{apa_print.glm}
\alias{apa_print.lm}
\alias{apa_print.summary.glm}
\alias{apa_print.summary.lm}
\title{Format statistics (APA 6th edition)}
\usage{
\method{apa_print}{glm}(x, est_name = NULL, ci = 0.95, in_paren = FALSE, ...)

\method{apa_print}{lm}(
  x,
  est_name = NULL,
  standardized = FALSE,
  ci = 0.95,
  observed_predictors = TRUE,
  in_paren = FALSE,
  ...
)

\method{apa_print}{summary.glm}(x, ...)

\method{apa_print}{summary.lm}(x, ...)
}
\arguments{
\item{x}{\code{glm} or \code{lm} object.}

\item{est_name}{Character. If \code{NULL} (default) the name given in \code{x} (or a formally correct
adaptation, such as "\eqn{b^*}" instead of "b" for standardized regression coefficients) is used,
otherwise the supplied name is used. See details.}

\item{ci}{Numeric. Either a single value (range [0, 1]) giving the confidence level or a two-column
\code{matrix} with confidence region bounds as column names (e.g. "2.5 \%" and "97.5 \%") and
coefficient names as row names (in the same order as they appear in \code{summary(x)$coefficients}.
See details.}

\item{in_paren}{Logical. Indicates if the formatted string will be reported inside parentheses. See details.}

\item{...}{
  Arguments passed on to \code{\link[=printnum]{printnum}}
  \describe{
    \item{\code{}}{}
  }}

\item{standardized}{Logical. Indicates if coefficients are standardized or unstandardized and leading
zeros are omitted if appropriate. See details.}

\item{observed_predictors}{Logical. Indicates whether predictor variables were observed. See details.}
}
\value{
\code{apa_print.lm} returns a list containing the following components according to the input:

   \describe{
     \item{\code{statistic}}{A named list of character strings giving the test statistic, parameters, and \emph{p}
         value for each term.}
     \item{\code{estimate}}{A named list of character strings giving the descriptive estimates and confidence intervals
         for each term.} % , either in units of the analyzed scale or as standardized effect size.
     \item{\code{full_result}}{A named list of character strings comprised of \code{estimate} and \code{statistic} for each term.}
     \item{\code{table}}{A data.frame containing the complete regression table, which can be passed to \code{\link{apa_table}}.}
   }
}
\description{
These methods take \code{glm} and \code{lm} objects to create formatted character
strings to report the results in accordance with APA manuscript guidelines.
}
\details{
The coefficients names are sanitized to facilitate their use as list names. Parentheses
   are omitted and other non-word characters are replaced by \code{_} (see \code{\link{sanitize_terms}}).

   If \code{in_paren} is \code{TRUE} parentheses in the formatted string, such as those surrounding degrees
   of freedom, are replaced with brackets.

   \code{est_name} is placed in the output string and is then passed to pandoc or LaTeX through \pkg{knitr}.
   Thus, to the extent it is supported by the final document type, you can pass LaTeX-markup to format the final
   text (e.g., \code{\\\\beta} yields \eqn{\beta}).

   If \code{standardized} is \code{TRUE} "scale()" is removed from coefficients names (see examples).
   Currently, this option is ignored for \code{glm}-objects.

   If \code{ci} is a single value, confidence intervals are calculated using \code{\link[stats]{confint}}.

   If \code{x} is an \code{lm}-object and the \pkg{MBESS} package is available, confidence intervals for \eqn{R^2}
   are computed using \code{\link[MBESS]{ci.R2}} to obtain a confidence region that corresponds to the
   \eqn{\alpha}-level chosen for the confidence intervals of regression coefficients (e.g., 95\% CI or
   \eqn{\alpha = 0.05} for regression coefficients yields a 90\% CI for \eqn{R^2}, see Steiger, 2004). If
   \code{observed_predictors = FALSE}, it is assumed that predictors are fixed variables, i.e., "the values of the
   [predictors] were selected a priori as part of the research design" (p. 15, Kelly, 2007); put differently, it
   is assumed that predictors are not random.
}
\examples{
# Data from Dobson (1990), p. 9.
ctl <- c(4.17, 5.58, 5.18, 6.11, 4.50, 4.61, 5.17, 4.53, 5.33, 5.14)
trt <- c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83, 6.03, 4.89, 4.32, 4.69)
group <- gl(2, 10, 20, labels = c("Ctl", "Trt"))
weight <- c(ctl, trt)
lm_fit <- lm(weight ~ group)

apa_print(lm_fit)

trt <- rep(trt, 2) # More data is always better
ctl <- rep(ctl, 2)
lm_fit2 <- lm(scale(trt) ~ scale(ctl))

apa_print(lm_fit2, standardized = TRUE)


# Dobson (1990) Page 93: Randomized Controlled Trial :
counts <- c(18,17,15,20,10,20,25,13,12)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
d.AD <- data.frame(treatment, outcome, counts)
glm.D93 <- glm(counts ~ outcome + treatment, family = poisson())

apa_print(glm.D93)
}
\references{
Steiger (2004). Beyond the F Test: Effect Size Confidence Intervals and Tests of Close Fit in the Analysis of
   Variance and Contrast Analysis. \emph{Psychological Methods}, 9(2), 164-182.
   doi:\href{https://doi.org/10.1037/1082-989X.9.2.164}{10.1037/1082-989X.9.2.164}

   Kelley, K. (2007). Confidence intervals for standardized effect sizes: Theory, application, and
   implementation. \emph{Journal of Statistical Software}, 20(8), 1-24.
   doi:\href{https://doi.org/10.18637/jss.v020.i08}{10.18637/jss.v020.i08}
}
\seealso{
\code{\link[stats]{confint}}, \code{\link[MBESS]{ci.pvaf}}

Other apa_print: 
\code{\link{apa_print.BFBayesFactor}()},
\code{\link{apa_print.aov}()},
\code{\link{apa_print.emmGrid}()},
\code{\link{apa_print.glht}()},
\code{\link{apa_print.htest}()},
\code{\link{apa_print.list}()},
\code{\link{apa_print}()}
}
\concept{apa_print}
