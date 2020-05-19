defmodule Myflix.Flix do
  @moduledoc """
  The Filx context.
  """

  import Ecto.Query, warn: false
  alias Myflix.Repo

  alias Myflix.Flix.Video

  @endpoint "https://api.themoviedb.org/3"
  @searchDom %{
    company: "/search/company",
    collection: "/search/collection",
    keyword: "/search/keyword",
    movie: "/search/movie",
    person: "/search/person",
    tv: "/search/tv"
  }

  @doc """
  Returns the list of videos.

  ## Examples

      iex> list_videos()
      [%Video{}, ...]

  """
  def list_videos do
    Repo.all(Video)
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id), do: Repo.get!(Video, id)

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    File.rm(video.path)
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{source: %Video{}}

  """
  def change_video(%Video{} = video) do
    Video.changeset(video, %{})
  end

  # The movie database API

  def search_all(term) do
    Map.keys(@searchDom)
    |> Enum.map(&search(&1, term))
  end

  # TODO get the query defaults from user settings

  def search(type, term, page \\ 1) do
    query = %{language: "en-US", page: page, query: term, include_adult: "false"}

    (@endpoint <> @searchDom[type] <> "?" <> URI.encode_query(query))
    |> send_request()
  end

  # media_type can be "all", "movie", "tv", or "person"
  # time_window can be "day", "week"

  def trending(media_type \\ "all", time_window \\ "day") do
    "#{@endpoint}/trending/#{media_type}/#{time_window}"
    |> send_request()
  end

  # details of sending the request, returns just the JSON response

  defp send_request(url) do
    case HTTPoison.get(url, headers(), options()) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, result} = {:ok, Jason.decode!(body)}
        result

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  # helper functions to fill out headers and options
  defp headers() do
    [
      Authorization: "Bearer #{Application.get_env(:Myflix, :tmdb_key)}",
      Accept: "Application/json; Charset=utf-8"
    ]
  end

  defp options() do
    [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 500]
  end
end
