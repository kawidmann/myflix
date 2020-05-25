defmodule Myflix.External.Search.Results do
  use Ecto.Schema
  import Ecto.Changeset
  alias Myflix.External.Search.Result

  embedded_schema do
    field(:page, :integer)
    field(:total_pages, :integer)
    field(:total_results, :integer)
    field(:type, :string)

    embeds_many(:results, Result)
  end

  def changeset(data, type) do
    changeset(Map.put(data, "type", type))
  end

  def changeset(data) do
    %__MODULE__{}
    |> cast(data, [
      :page,
      :total_pages,
      :total_results,
      :type
    ])
    |> cast_embed(:results)
    |> validate_required([:results])
    |> apply_changes()
  end
end
