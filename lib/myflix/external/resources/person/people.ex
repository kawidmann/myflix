defmodule Myflix.External.Resources.People do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)

    field(:profile_path, :string)
    field(:popularity, :float)
    field(:known_for_department, :string)
    field(:biography, :string)

    field(:gender, :integer)

    field(:place_of_birth, :string)
    field(:birthday, :date)
    field(:deathday, :date)

    field(:imdb_id, :string)
    field(:homepage, :string)
    field(:adult, :boolean)

    # field :also_known_as, TODO
  end

  def from_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :id,
      :name,
      :profile_path,
      :popularity,
      :known_for_department,
      :biography,
      :gender,
      :place_of_birth,
      :birthday,
      :deathday,
      :imdb_id,
      :homepage,
      :adult
    ])
    |> validate_required([:id, :name])
    |> apply_changes
  end
end
