defmodule Dockexir.Mixfile do
  use Mix.Project

  def project do
    [app: :dockexir,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:hackney],
     extra_applications: [:logger]]
  end

  defp deps do
    [{:hackney, "~> 1.8"},
     {:poison, "~> 3.1"}]
  end
end
