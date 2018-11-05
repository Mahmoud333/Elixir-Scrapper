defmodule Hackerpage.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hackerpage,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  #MAHMOUD: THE APPLICATION WE WANT TO RUN BEFORE THE APP RUN
  def application do
    [
      mod: {Hackerpage, []},
      extra_applications: [
        :logger,
        #MAHMOUD OURS
        :gproc,     #keep track of processes
        :httpoison #keeping track of workers in background so it doesn't spawn new processes continuing

      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.3"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:plug_cowboy, "~> 1.0"},
      #MAHMOUD MINE
      {:floki, "~> 0.17.0"},   #process HTML like jQuery
      {:httpoison, "~> 0.11.1"}, #allow us to do web requests
      {:gproc, "~> 0.5"},      #find processes and its general
      {:slow_scraper, github: "LeviSchuck/SlowScraper", branch: :master}
      #repo, branch
      #allow to slightly cache what we request so i dont spam hacker news & take 3 seconds everytime i want to refresh the page
    ]
  end
end
