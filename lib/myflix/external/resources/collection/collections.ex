defmodule Myflix.External.Resources.Collections do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:overview, :string)
    field(:poster_path, :string)
    field(:backdrop_path, :string)

    # field :parts, TODO
  end

  def from_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :id,
      :name,
      :overview,
      :poster_path,
      :backdrop_path
    ])
    |> validate_required([:id, :name])
    |> apply_changes
  end
end
