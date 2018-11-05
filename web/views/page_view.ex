defmodule Hackerpage.PageView do
  use Hackerpage.Web, :view

  def hn_newest do
    HackerNews.get_newest_page()
      |> Enum.take(20)             #Specify how many you want
  end

  def hn_top_rated do
    HackerNews.get_home_page()
      |> Enum.take(20)             #Specify how many you want
  end

  def hn_jobs do
    HackerNews.get_jobs_page()
      |> Enum.take(20)
  end

end
