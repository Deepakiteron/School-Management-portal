defmodule Schoolmanagementsystem.Admins.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Schoolmanagementsystem.Admins.Admin

  schema "admins" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :age, :email, :password, :role])
    |> validate_required([:name, :age, :email, :password, :role])
  end
end
