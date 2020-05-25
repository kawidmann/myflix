defmodule Myflix.External.TMDB do
  @endpoint "https://api.themoviedb.org/3"
  @baseimgurl "https://image.tmdb.org/t/p"

  def send_request(url) do
    case HTTPoison.get(@endpoint <> url, headers(), options()) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        Jason.decode!(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Response{status_code: 407}} ->
        {:error, :invalid_api_key}

      {:ok, %HTTPoison.Response{status_code: 422}} ->
        %{page: 0, results: [], total_pages: 0, total_results: 0}

      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  # helper functions to fill out headers and options
  defp headers() do
    [
      Authorization: "Bearer #{Application.get_env(:myflix, :tmdb_key)}",
      Accept: "Application/json; Charset=utf-8"
    ]
  end

  defp options() do
    [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 500]
  end

  # TODO img link builder

  def img(conn, nil) do
    Routes.static_path(conn, "/images/no_poster.jpeg")
  end

  def img(_conn, path) do
    @baseimgurl <> "/w154/" <> path
  end
end
