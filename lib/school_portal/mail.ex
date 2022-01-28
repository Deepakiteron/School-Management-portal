defmodule SchoolPortal.Mail do
  import Swoosh.Email

  def welcome(user) do
    new()
    |> to({user.firstname, user.email})
    |> from({"Admin", "deepak.k@Iteron.com"})
    |> subject("Within a 24 hours you get an access to login")
    # |> html_body("<h1>Hello #{registration.name}</h1>")
    |> text_body("Hello #{user.firstname}\n")
  end
end
