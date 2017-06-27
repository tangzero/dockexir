defmodule Dockexir.Mixfile do
  use Mix.Project

  def project do
    [app: :dockexir,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     deps: deps()]
  end

  def application do
    [applications: [:hackney],
     extra_applications: [:logger]]
  end

  defp deps do
    [{:hackney, "~> 1.8"},
     {:poison, "~> 3.1"},
     {:mock, "~> 0.2.0", only: :test},
     {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
     {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
     {:excoveralls, "~> 0.6", only: :test}]
  end

end
