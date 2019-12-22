defmodule Myflix.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :encrypted_password, :string, null: false
    field :username, :string, null: false
    field :email, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :email])
    |> validate_required([:username, :encrypted_password, :email])
    |> unique_constraint([:username, :email])
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)
  end
end
