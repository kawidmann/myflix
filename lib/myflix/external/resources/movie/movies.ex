defmodule Myflix.External.Resources.Movies do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:title, :string)

    field(:overview, :string)
    field(:tagline, :string)
    field(:runtime, :integer)
    field(:release_date, :date)

    field(:backdrop_path, :string)
    field(:poster_path, :string)

    field(:popularity, :float)
    field(:vote_average, :float)
    field(:vote_count, :integer)

    field(:imdb_id, :string)
    field(:original_language, :string)
    field(:original_title, :string)
    field(:homepage, :string)

    field(:budget, :integer)
    field(:revenue, :integer)
    field(:status, :string)

    field(:adult, :boolean)

    @doc """
    field :belongs_to_collection, TODO
    field :genres, TODO
    field :production_companies, TODO
    field :production_countries, TODO
    field :spoken_languages, TODO
    field(:video, :boolean)
    """
  end

  def from_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :id,
      :title,
      :overview,
      :tagline,
      :runtime,
      :release_date,
      :backdrop_path,
      :poster_path,
      :popularity,
      :vote_average,
      :vote_count,
      :imdb_id,
      :original_language,
      :original_title,
      :homepage,
      :budget,
      :revenue,
      :status,
      :adult
    ])
    |> validate_required([:id, :title])
    |> apply_changes
  end
end
