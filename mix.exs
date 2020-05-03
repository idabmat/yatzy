defmodule Yatzy.MixProject do
  use Mix.Project

  def project do
    [
      app: :yatzy,
      version: "1.0.0",
      description: "A Yatzy game engine",
      package: package(),
      elixir: "~> 1.10",
      elixirc_options: [warning_as_errors: true],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/idabmat/yatzy",
      homepage_url: "https://github.com/idabmat/yatzy"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.3", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:typed_struct, "~> 0.1.4"}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["igor@talimhq.com"],
      links: %{"GitHub" => "https://github.com/idabmat/yatzy"}
    ]
  end
end
