defmodule CPCNSdk.MixProject do
  use Mix.Project

  @github_url "https://github.com/scottming/cpcn-sdk"

  def project do
    [
      app: :cpcn_sdk,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: "A sdk for CPCN payment.",
      deps: deps(),
      package: [
        files: ~w(mix.exs lib README.md),
        licenses: ["MIT"],
        maintainers: ["ScottMing"],
        links: %{
          "GitHub" => @github_url
        }
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CPCNSdk.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},

      {:xml_builder, "~> 2.1"},
      {:exsync, "~> 0.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}

      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
