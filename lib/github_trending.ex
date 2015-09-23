defmodule GithubTrending do
  def get do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        process_response(body)
    end
  end

  def url do
    "https://github.com/trending"
  end

  def process_response(body) do
    body
    |> Floki.find(".repo-list .repo-list-item .repo-list-name a")
    |> Floki.attribute("href")
  end
end
