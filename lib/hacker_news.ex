defmodule HackerNews do

  #1- want to use slow-scrapper, 2- how we will use it
  def client_spec do
    headers = []
    SlowScraper.client_spec(:hn, headers, HackerNews.HTTP)
    #1- library use first parameter as a key (can be any arbitrary terms that we'll use later to request up at runtime),
    #2- headers for any initial configuration
    #3- another module name which implements a behavior like a contract or interface
  end

  def get_newest_page do
    SlowScraper.request_page(:hn, "https://news.ycombinator.com/newest", 10_000, 100, 0)
    #1- the term we added to identify this instance in mermory hn we going to refer to it here
    #2- the url
    #3- how long something stays in memory before it's failed
    #4- how many times can it be fail
    #5- how long am i willing to wait for the answer if it's already been loaded
      |> parse_news
  end

  def get_home_page do
    SlowScraper.request_page(:hn, "https://news.ycombinator.com/news", 10_000, 100, 0)
    #1- the term we added to identify this instance in mermory hn we going to refer to it here
    #2- the url
    #3- how long something stays in memory before it's failed
    #4- how many times can it be fail
    #5- how long am i willing to wait for the answer if it's already been loaded
      |> parse_news
  end

  def get_jobs_page do
    SlowScraper.request_page(:hn, "https://news.ycombinator.com/jobs", 10_000, 100, 0)
    #1- the term we added to identify this instance in mermory hn we going to refer to it here
    #2- the url
    #3- how long something stays in memory before it's failed
    #4- how many times can it be fail
    #5- how long am i willing to wait for the answer if it's already been loaded
      |> parse_news
  end


  def parse_news(hn_page) do
    Floki.find(hn_page, ".athing")
     #|> Enum.map(fn x -> Floki.text(x) end) OR |> Enum.map(&Floki.text(&1))
      |>Enum.map( fn new_item ->
        link = Floki.find(new_item, ".storylink") #get the link
        title = Floki.text(link)                  #get the title
        href = Floki.attribute(link, "href")
          |> List.first #it doesn't crash if: 1- list is empty,2- not a list, will just return nil

        %{
          title: title,
          url: href,
        }
        #create a map of our information now
      end)
    end

  defmodule HTTP do
    require Logger  #requires Logger Module to compile before compiling this module
    @behaviour SlowScraper.Adapter
    #will enfcore at compile time that u have all required functions and have this right amount of parameters
    #its like an interface

    #part of required
    #1- headers that provided at initializatio always constant,
    #2- what user provide could be term or string for now string
    def scrape(headers, url) do
      Logger.info("MAHMOUD Requesting #{url}")

      #Start Using httpoison
      {:ok, response} = HTTPoison.get(url, headers, [])
      #3rd param is for payload tht u will send

      #incase it was nil use response[:body] instead of response.body
      body = Map.get(response, :body) #response[:body]

      #its like jQuery, when we want to search for something
      result = Floki.find(body, "#hnmain")

      #Logger.info(inspect(result))

      result
    end
  end
end
