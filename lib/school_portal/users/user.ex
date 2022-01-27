defmodule SchoolPortal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias SchoolPortal.Users.User

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
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password, :age, :gender, :address, :phone_number, :category_type])
    |> validate_required([:firstname, :lastname, :email, :password, :age, :gender, :address, :phone_number, :category_type])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
