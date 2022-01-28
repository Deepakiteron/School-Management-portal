defmodule SchoolPortal.Admins.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias SchoolPortal.Admins.Admin

  schema "admins" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :age, :email, :password])
    |> validate_required([:name, :age, :email, :password])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end


  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
