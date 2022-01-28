defmodule SchoolPortal.Admins.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "admins" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:name, :age, :email, :password])
    |> validate_required([:name, :age, :email, :password])
  end
end
