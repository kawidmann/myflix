defmodule Myflix.External.Search.Result do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:display_img, :string)
    field(:popularity, :float)
    field(:vote_average, :float)
    field(:vote_count, :integer)
    field(:release_date, :string)
    field(:video, :boolean)
    field(:type, :string)
  end

  def changeset(result, data) do
    result
    |> cast(parse_data(data), [
      :id,
      :name,
      :display_img,
      :popularity,
      :vote_average,
      :vote_count,
      :release_date,
      :video,
      :type
    ])
    |> validate_required([:id])
  end

  def parse_data(%{"first_air_date" => _} = tv) do
    new_data = %{
      "type" => "tv",
      "display_img" => tv["poster_path"],
      "release_date" => tv["first_air_date"],
      "video" => false
    }

    tv
    |> Map.merge(new_data)
  end

  def parse_data(%{"profile_path" => _} = person) do
    new_data = %{
      "type" => "person",
      "display_img" => person["profile_path"],
      "video" => false
    }

    person
    |> Map.merge(new_data)
  end

  def parse_data(%{"title" => _} = movie) do
    new_data = %{
      "type" => "movie",
      "display_img" => movie["poster_path"],
      "name" => movie["title"],
      "video" => false
    }

    movie
    |> Map.merge(new_data)
  end

  def parse_data(%{"original_name" => _} = collection) do
    new_data = %{
      "type" => "collection",
      "display_img" => collection["poster_path"],
      "video" => false
    }

    collection
    |> Map.merge(new_data)
  end
end
