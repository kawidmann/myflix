defmodule Myflix.External.Resources.Tvs do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:overview, :string)

    field(:poster_path, :string)
    field(:backdrop_path, :string)

    field(:popularity, :float)
    field(:vote_average, :float)
    field(:vote_count, :integer)

    field(:number_of_episodes, :integer)
    field(:number_of_seasons, :integer)

    field(:in_production, :boolean)
    field(:status, :string)
    field(:first_air_date, :date)
    field(:last_air_date, :date)

    field(:homepage, :string)
    field(:original_language, :string)
    field(:original_name, :string)
    field(:type, :string)

    @doc """
    field :seasons, TODO
    field :genres, TODO
    field :episode_run_time, TODO
    field :languages, TODO
    field :last_episode_to_air, TODO
    field :next_episode_to_air, TODO
    field :networks, TODO
    field :origin_country, TODO
    field :production_companies, TODO
    field :created_by, TODO
    """
  end

  def from_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :id,
      :name,
      :overview,
      :poster_path,
      :backdrop_path,
      :popularity,
      :vote_average,
      :vote_count,
      :number_of_episodes,
      :number_of_seasons,
      :in_production,
      :status,
      :first_air_date,
      :last_air_date,
      :homepage,
      :original_language,
      :original_name,
      :type
    ])
    |> validate_required([:id, :name])
    |> apply_changes
  end
end
