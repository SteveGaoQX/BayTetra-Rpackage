% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mcmc_BayTetra.R
\name{mcmc_BayTetra}
\alias{mcmc_BayTetra}
\title{Posterior inference for BayTetra}
\usage{
mcmc_BayTetra(
  data,
  v_rsp,
  v_covs,
  v_grp,
  v_time,
  df,
  prior = list(),
  mcmc = list(),
  display_process = TRUE
)
}
\arguments{
\item{data}{longitudinal data with ID, VISIT, Group, and Covariates, Responses, Time.}

\item{v_rsp}{Column names corresponding to responses.}

\item{v_covs}{Column names corresponding to covariates.}

\item{v_grp}{Column name corresponding to group memberships.}

\item{v_time}{Column name corresponding to time.}

\item{df}{This parameter specifies the degree of freedom of B-spline and is used to select
the number of interior knots. Default value is 4 and minimum value is 3.
\itemize{
\item {df = 3: Function uses a degree 2 B-spline with 0 interior knots.}
\item {df = 4: Function uses a degree 3 B-spline with 0 interior knots.}
\item {df >= 5: Function uses a degree 3 B-spline with (df - 4) interior knots.}
}}

\item{prior}{A list giving the prior information.
\itemize{
\item \code{mu_alpha}: The mean in normal prior for \eqn{\alpha_{q}}. Default value is a zero vector.
\item \code{V_alpha}: The covariance matrix in normal prior for \eqn{\alpha_{q}}. Default value is 100 * \eqn{I} where \eqn{I} is the identity matrix.
\item \code{a_nu}: The hyperparameter \eqn{a_{\nu}} in prior for \eqn{\nu_{kq0}^2}. Default value is 1.
\item \code{b_nu}: The hyperparameter \eqn{b_{\nu}} in prior for \eqn{\nu_{kq0}^2}. Default value is 1.
\item \code{a_eta}: The hyperparameter \eqn{a_{\eta}} in prior for \eqn{\tau_{kq}^2}. Default value is 1.
\item \code{b_eta}: The hyperparameter \eqn{b_{\eta}} in prior for \eqn{\tau_{kq}^2}. Default value is 1.
\item \code{a_tau}: The hyperparameter \eqn{a_{\tau}} in prior for \eqn{\tau_q^2}. Default value is 1.
\item \code{b_tau}: The hyperparameter \eqn{b_{\tau}} in prior for \eqn{\tau_q^2}. Default value is 1.
\item \code{a_lamb}: The hyperparameter \eqn{a_{\lambda}} in prior for \eqn{\lambda_q}. Default value is 1.
\item \code{b_lamb}: The hyperparameter \eqn{b_{\lambda}} in prior for \eqn{\lambda_q}. Default value is 1.
\item \code{h_1}: The hyperparameter \eqn{a_{\sigma}} in prior for \eqn{\sigma_q^2}. Default value is 1.
\item \code{h_2}: The hyperparameter \eqn{b_{\sigma}} in prior for \eqn{\sigma_q^2}. Default value is 1.
}}

\item{mcmc}{A list giving the MCMC parameters.
\itemize{
\item \code{Nit}: The number of iterations for the MCMC chain. Default is 4000.
\item \code{burn_in}: The number of burn-in samples in the MCMC chain. Default is 2000.
\item \code{thin_factor}: The thinning factor for the chain. Default is 10.
}}

\item{display_process}{A bool value; if TRUE, progress will be displayed every 1000 iteration by default.}
}
\value{
An object of class 'Post_BayTetra' containing posterior samples:
\itemize{
\item \code{pos.alpha}: Posterior samples for \eqn{\alpha_{q}}.
\item \code{pos.beta}: Posterior samples for \eqn{\widetilde{\boldsymbol{\beta}}_{k q}^{-}}.
\item \code{pos.beta_kq0}: Posterior samples for \eqn{\beta_{kq0}}.
\item \code{pos.Sigma_omega}: Posterior samples for \eqn{\Sigma_{\omega}}.
\item \code{pos.tau_q}: Posterior samples for \eqn{\tau^2_q}.
\item \code{pos.lambda_q}: Posterior samples for \eqn{\lambda^2_q}.
\item \code{pos.sigma2}: Posterior samples for \eqn{\sigma^2_q}.
}
}
\description{
Draw posterior samples of the parameters of interest from BayTetra
}
\details{
The model of the BayTetra is:
\deqn{y_{i q j}=\boldsymbol{Z}_{i j}^{\mathrm{T}} \boldsymbol{\alpha}_q+\sum_{l=1}^{L-1} \widetilde{\beta}_{K q l} \widetilde{\boldsymbol{B}}_l\left(t_{i q j}\right)+\sum_{k=1}^{K-1} \mathbb{I}\left(g_i=k\right)\left(\widetilde{\beta}_{k q 0}+\sum_{l=1}^{L-1} \widetilde{\beta}_{k q l} \widetilde{\boldsymbol{B}}_l\left(t_{i q j}\right)\right)+\omega_{i q}+ \theta_{iqj}+ \epsilon_{i q j},}

\deqn{ \boldsymbol{\omega}_i=\left(\omega_{i 1}, \ldots, \omega_{i Q}\right) \sim \mathcal{N}\left(\mathbf{0}, \Sigma_\omega\right),\boldsymbol{\theta}_{i q}=\left(\theta_{i q 1}, \ldots, \theta_{i q, J_i}\right) \sim \mathcal{N}\left(\mathbf{0}, \boldsymbol{\Sigma}_{\boldsymbol{\theta}_{i q}}\right), \epsilon_{i q j} \sim \mathcal{N}\left(0, \sigma_q^2\right),}

where \eqn{\widetilde{\boldsymbol{B}}_l\left(t_{i q j}\right)} denote the \eqn{l}-th basis function for the \eqn{L-1} dimensional
cubic B-spline expansion at time \eqn{t_{iqj}}, where \eqn{\boldsymbol{\Sigma}_{\boldsymbol{\omega}}} is a correlation matrix,
and \eqn{\boldsymbol{\Sigma}_{\boldsymbol{\theta}_{i q}}} is a \eqn{J_i \times J_i} squared exponential covariance matrix whose
\eqn{\left(j, j^{\prime}\right)}-th entry is \eqn{\tau_q^2 \exp \left\{-\left(\frac{t_{i q j}-t_{i q j^{\prime}}}{\lambda_q}\right)^2\right\}}.

We set \eqn{\widetilde{\beta}_{K q 0}} to 0 for identifiability and denote
\eqn{\widetilde{\boldsymbol{\beta}}_{k q}=\left(\widetilde{\beta}_{k q 0}, \widetilde{\beta}_{k q 1}, \ldots, \widetilde{\beta}_{k q, L-1}\right)^{\mathrm{T}}=\left(\widetilde{\beta}_{k q 0},\left(\widetilde{ \boldsymbol{\beta } }_{k q}^{-}\right)^{\mathrm{T}}\right)^{\mathrm{T}} .}

We assign priors:
\deqn{\widetilde{\boldsymbol{\beta}}_{k q}^{-} \mid \eta_{kq}^2 \propto \exp \left\{-\frac{1}{2 \eta_{kq}^2} (\widetilde{\boldsymbol{\beta}}_{k q}^{-})^{\mathrm{T}} \bm{P}_{kq}  \widetilde{\boldsymbol{\beta}}_{k q}^{-} \right\},}
\deqn{\eta_{kq}^2 \sim \text{Gamma}(a_{\eta},b_{\eta}),}
where \eqn{P_{kq}} is a singular penalty matrix constructed from the second-order differences of the adjacent B-spline coefficients.

For the intercept \eqn{\widetilde{\beta}_{k q 0}}, we assume its prior:
\deqn{\widetilde{\beta}_{k q 0} \sim \mathcal{N}\left(0, \nu_{k q 0}^2 \right),}
\deqn{\nu_{kq0}^2 \sim \text { Inverse-Gamma }\left(a_\nu, b_\nu\right).}

The prior of other parameters are:
\deqn{\boldsymbol{\alpha}_q \sim \mathcal{N}\left(0, \Sigma_\alpha\right), p\left(\Sigma_\omega\right) \propto 1 ,}
\deqn{\tau_q^2 \sim \text { Inverse-Gamma }\left(a_\tau, b_\tau\right) ,}
\deqn{\lambda_q \sim \text { Inverse-Gamma }\left(a_\lambda, b_\lambda\right) ,}
\deqn{\sigma_q^2 \sim \text { Inverse-Gamma }\left(a_\sigma, b_\sigma\right) .}
}
\examples{
\dontrun{
mcmc_result = mcmc_BayTetra(data = ex_data,
                            v_rsp = paste("R", 1:2,sep = ""),
                            v_covs = "cov1",
                            v_grp = "Group",
                            v_time = "time",
                            df = 10)
}



}
