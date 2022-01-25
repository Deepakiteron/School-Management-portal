defmodule SchoolPortal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :address, :string
    field :age, :integer
    field :category_type, :string
    field :email, :string
    field :firstname, :string
    field :gender, :string
    field :lastname, :string
    field :password, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password, :age, :gender, :address, :phone_number, :category_type])
    |> validate_required([:firstname, :lastname, :email, :password, :age, :gender, :address, :phone_number, :category_type])
  end
end
